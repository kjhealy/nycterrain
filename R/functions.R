#' Get the NYC bare-earth elevation raster at 100ft or 50ft resolution
#'
#' Returns a [terra::SpatRaster] of bare-earth elevation in feet above
#' sea level (NAVD88), masked to the New York City borough boundaries.
#' The single layer is named `elev`. CRS is EPSG:2263 (NAD83 / New York
#' Long Island, ftUS). Cells outside the city boundary are `NA`.
#'
#' These rasters are mean-aggregated from the City of New York's 1-foot
#' Digital Elevation Model derived from 2010 LiDAR.
#'
#' @return A [terra::SpatRaster] with one layer (`elev`).
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(terra)
#' r <- nyc_terrain_100ft()
#' plot(r)
#'
#' # Hillshade with terra
#' slp <- terrain(r, "slope", unit = "radians")
#' asp <- terrain(r, "aspect", unit = "radians")
#' hs <- shade(slp, asp, angle = 35, direction = 315)
#' plot(hs, col = grey(0:100 / 100), legend = FALSE)
#' }
#'
#' @importFrom terra rast
#' @keywords functions
nyc_terrain_100ft <- function() {
  terra::rast(nyc_terrain_path("100ft"))
}

#' @rdname nyc_terrain_100ft
#' @export
nyc_terrain_50ft <- function() {
  terra::rast(nyc_terrain_path("50ft"))
}


#' Get the file path to a bundled NYC terrain GeoTIFF
#'
#' Returns the path to a GeoTIFF bundled with the package. Useful when
#' you want to read the raster with another tool (e.g. `stars`, GDAL,
#' `rayshader`) instead of `terra`.
#'
#' @param resolution Either `"100ft"` (default) or `"50ft"`.
#'
#' @return A character string file path.
#'
#' @export
#'
#' @examples
#' nyc_terrain_path()
#' nyc_terrain_path("50ft")
#'
#' @keywords functions
nyc_terrain_path <- function(resolution = c("100ft", "50ft")) {
  resolution <- match.arg(resolution)
  fname <- paste0("nyc_terrain_", resolution, ".tif")
  system.file(
    "extdata",
    fname,
    package = "nycterrain",
    mustWork = TRUE
  )
}
