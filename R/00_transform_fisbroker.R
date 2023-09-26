



#' Transforms downloaded fisbroker data
#'
#' Transforms downloaded fisbroker data and makes them ready for sending
#' to database. The transformation includes reprojection to WGS84 (=CRS 4326)
#' and adding lon/lat as additional columns for spatial points.
#' Also, the geometry column will be transformed to a geojson character.
#'
#' @param sf_obj spatial sf object
#' @return tibble with geometry column as character (geojson).
#'         Geometry has been reprojected to WGS84.
#'         For spatial points additional columns lon/lat (double) will be added.
#'
#' @export
transform_fisbroker <- function(sf_obj) {
  sf_obj_check(sf_obj)
  
  # Reprojection to coordinate ref system (crs) 4326:
  # 4326 is WGS 84 - World Geodetic System 1984
  # used in GPS https://epsg.io/4326 and compatible with "common"
  # lat/lon coordinates
  sf_obj_wgs84 <- st_transform(sf_obj, 4326)
  # Adds lon/lat columns if sf_obj is spatial points
  sf_obj_with_coords <- get_coordinates(sf_obj_wgs84)
  df_for_db <- sf_to_geojson_df(sf_obj_with_coords)
  
  return(df_for_db)
}


#' Extract coordinates from a geometry
#'
#' Adds coordinates (lon/lat) to a sf object.
#'
#' @param sf_obj spatial point sf object
#' @return sf object with additional columns "x" and "y"
#'
#' @export
get_coordinates <- function(sf_obj) {
  sf_obj_check(sf_obj)
  
  sf_type <- st_geometry_type(sf_obj, by_geometry = FALSE) %>%
    as.character()
  
  if (sf_type == "POINT") {
    lon_lat <- st_coordinates(sf_obj) %>%
      as.data.frame() %>%
      rename(lon = "X",
             lat = "Y")
    
    logging("Adding coordinates as lon/lat columns.")
    geometry <- NULL # fixing RMD check to make binding visible
    geom_to_geometry <- c(geometry = "geom") 
    
    sf_obj_with_coords <- bind_cols(sf_obj, lon_lat) %>%
      # rename "geom" col to "geometry" (if necessary)
      rename(any_of(geom_to_geometry)) %>%
      relocate(geometry, .after = last_col())
    
    sf_obj_with_coords
    
  } else {
    logging("Not of geometry type 'points', no coordinates (lon/lat) added.")
    sf_obj
  }
}


#' Turns sf object into a dataframe
#'
#' Turns the geometry of a sf_obj into a character column, in the form of a geojson.
#'
#' @param sf_obj spatial sf object
#' @return dataframe with a geometry column that is of type character (geojson)
#'
#' @export
sf_to_geojson_df <- function(sf_obj) {
  sf_obj_check(sf_obj)
  
  geometries <- sfc_geojson(sf_obj$geometry)
  # Turn sf_obj into a NON sf_obj (just dropping column does not work)
  df <- st_set_geometry(sf_obj, NULL)
  df$geometry <- c(geometries)
  
  return(df)
}


#' Checks if obj is a spatial sf object.
#'
#' Passes if obj is a spatial sf object, throws error otherwise.
#'
#' @param obj any object
#'
#' @export
sf_obj_check <- function(obj) {
  if (!"sf" %in% class(obj)) {
    stop("Argument provided is not an sf object, thus cannot be processed.")
  }
}
