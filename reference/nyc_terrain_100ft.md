# Get the NYC bare-earth elevation raster at 100ft or 50ft resolution

Returns a
[terra::SpatRaster](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
of bare-earth elevation in feet above sea level (NAVD88), masked to the
New York City borough boundaries. The single layer is named `elev`. CRS
is EPSG:2263 (NAD83 / New York Long Island, ftUS). Cells outside the
city boundary are `NA`.

## Usage

``` r
nyc_terrain_100ft()

nyc_terrain_50ft()
```

## Value

A
[terra::SpatRaster](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
with one layer (`elev`).

## Details

These rasters are mean-aggregated from the City of New York's 1-foot
Digital Elevation Model derived from 2010 LiDAR.

## Examples

``` r
if (FALSE) { # \dontrun{
library(terra)
r <- nyc_terrain_100ft()
plot(r)

# Hillshade with terra
slp <- terrain(r, "slope", unit = "radians")
asp <- terrain(r, "aspect", unit = "radians")
hs <- shade(slp, asp, angle = 35, direction = 315)
plot(hs, col = grey(0:100 / 100), legend = FALSE)
} # }
```
