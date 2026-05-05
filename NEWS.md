# nycterrain 0.0.1.9000

* Initial release with bare-earth elevation data for New York City,
  derived from the City's 1-foot 2010 LiDAR DEM.
* Added `nyc_terrain_100ft()` and `nyc_terrain_50ft()` accessor
  functions returning `terra::SpatRaster` objects masked to the borough
  boundaries.
* Added `nyc_terrain_path()` for direct file access.
* Added `nyc_terrain_contours_sf`, a 50-level contour dataset derived
  from the 100ft DEM for use as a ggplot2 overlay.
