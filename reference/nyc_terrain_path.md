# Get the file path to a bundled NYC terrain GeoTIFF

Returns the path to a GeoTIFF bundled with the package. Useful when you
want to read the raster with another tool (e.g. `stars`, GDAL,
`rayshader`) instead of `terra`.

## Usage

``` r
nyc_terrain_path(resolution = c("100ft", "50ft"))
```

## Arguments

- resolution:

  Either `"100ft"` (default) or `"50ft"`.

## Value

A character string file path.

## Examples

``` r
nyc_terrain_path()
#> [1] "/home/runner/work/_temp/Library/nycterrain/extdata/nyc_terrain_100ft.tif"
nyc_terrain_path("50ft")
#> [1] "/home/runner/work/_temp/Library/nycterrain/extdata/nyc_terrain_50ft.tif"
```
