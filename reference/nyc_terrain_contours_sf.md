# NYC bare-earth elevation contours

Contour lines derived from the 100-foot bare-earth Digital Elevation
Model. Useful as a lightweight elevation overlay for ggplot2 maps.
EPSG:2263, NAD83 / New York Long Island (ftUS).

## Usage

``` r
nyc_terrain_contours_sf
```

## Format

### `nyc_terrain_contours_sf`

A simple feature collection of multilinestrings:

- elev_ft:

  Contour level, in feet above sea level (NAVD88).

- geometry:

  MULTILINESTRING geometry in EPSG:2263.

## Source

City of New York, 1-foot Digital Elevation Model (DEM):
<https://data.cityofnewyork.us/City-Government/1-foot-Digital-Elevation-Model-DEM-/dpc8-z3jc>

## Details

Contours are computed from the 100-foot mean-aggregated DEM via
[`terra::as.contour()`](https://rspatial.github.io/terra/reference/contour.html)
at 50 evenly spaced levels covering the city's elevation range. For
higher-resolution work, derive your own contours from
[`nyc_terrain_50ft`](https://kjhealy.github.io/nycterrain/reference/nyc_terrain_100ft.md).

## Author

Kieran Healy
