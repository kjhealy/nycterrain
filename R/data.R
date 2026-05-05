#' NYC bare-earth elevation contours
#'
#' Contour lines derived from the 100-foot bare-earth Digital Elevation
#' Model. Useful as a lightweight elevation overlay for ggplot2 maps.
#' EPSG:2263, NAD83 / New York Long Island (ftUS).
#'
#' @format ## `nyc_terrain_contours_sf`
#' A simple feature collection of multilinestrings:
#' \describe{
#'   \item{elev_ft}{Contour level, in feet above sea level (NAVD88).}
#'   \item{geometry}{MULTILINESTRING geometry in EPSG:2263.}
#' }
#'
#' @details
#' Contours are computed from the 100-foot mean-aggregated DEM via
#' [terra::as.contour()] at 50 evenly spaced levels covering the city's
#' elevation range. For higher-resolution work, derive your own contours
#' from [`nyc_terrain_50ft`][nyc_terrain_100ft()].
#'
#' @author Kieran Healy
#' @source City of New York, 1-foot Digital Elevation Model (DEM):
#'   <https://data.cityofnewyork.us/City-Government/1-foot-Digital-Elevation-Model-DEM-/dpc8-z3jc>
"nyc_terrain_contours_sf"

