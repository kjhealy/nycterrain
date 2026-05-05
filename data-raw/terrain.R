## nyc_terrain — bare-earth elevation rasters and contours.
# Reads the 1ft NYC DEM, masks to borough boundaries, aggregates to
# 50ft and 100ft mean elevation, writes GeoTIFFs to inst/extdata/, and
# builds the nyc_terrain_contours_sf object from the 100ft DEM.

source(here::here("data-raw", "_source.R"))

# -- Configuration -----------------------------------------------------------
raw_tif <- here(
  "..",
  "..",
  "data-to-be-packaged",
  "terrain",
  "raw",
  "NYC_DEM_1ft_Int",
  "DEM_LiDAR_1ft_2010_Improved_NYC_int.tif"
)

out_100ft <- here("inst", "extdata", "nyc_terrain_100ft.tif")
out_50ft <- here("inst", "extdata", "nyc_terrain_50ft.tif")

fs::dir_create(here("inst", "extdata"))

gdal_opts <- c(
  "COMPRESS=DEFLATE",
  "PREDICTOR=3",
  "TILED=YES",
  "BIGTIFF=IF_SAFER"
)

# -- Inputs ------------------------------------------------------------------
dem_1ft <- rast(raw_tif)

bbs <- nycmaps::nyc_boros_sf |>
  st_transform(crs = 2263) |>
  vect()

# -- Mask 1ft DEM to NYC boroughs (slow but only done once) ------------------
dem_mask <- mask(dem_1ft, bbs)

# -- Aggregate to 100ft and 50ft (mean) --------------------------------------
dem_100ft <- aggregate(dem_mask, fact = 100, fun = "mean", na.rm = TRUE)
dem_50ft <- aggregate(dem_mask, fact = 50, fun = "mean", na.rm = TRUE)

names(dem_100ft) <- "elev"
names(dem_50ft) <- "elev"

# -- Write GeoTIFFs ----------------------------------------------------------
writeRaster(
  dem_100ft,
  out_100ft,
  datatype = "FLT4S",
  overwrite = TRUE,
  gdal = gdal_opts
)

writeRaster(
  dem_50ft,
  out_50ft,
  datatype = "FLT4S",
  overwrite = TRUE,
  gdal = gdal_opts
)

message(
  "Wrote ",
  out_100ft,
  " (",
  round(file.info(out_100ft)$size / 1024^2, 2),
  " MB)"
)
message(
  "Wrote ",
  out_50ft,
  " (",
  round(file.info(out_50ft)$size / 1024^2, 2),
  " MB)"
)

# -- Contours from the 100ft DEM ---------------------------------------------
nyc_terrain_contours_sf <- as.contour(
  dem_100ft,
  maxcells = 2.5e6,
  nlevels = 50
) |>
  st_as_sf() |>
  dplyr::rename(elev_ft = level) |>
  tibble::as_tibble() |>
  st_as_sf()

usethis::use_data(
  nyc_terrain_contours_sf,
  overwrite = TRUE,
  compress = "xz"
)

message(
  "Built nyc_terrain_contours_sf: ",
  nrow(nyc_terrain_contours_sf),
  " rows, ",
  length(unique(nyc_terrain_contours_sf$elev_ft)),
  " levels"
)
