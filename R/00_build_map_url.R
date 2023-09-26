#' Build a complete map fisbroker url
#'
#' Creates full url for a single map_resource of the FisBroker Berlin that can be
#' viewed in a Browser.
#'
#' @param map_resource name of a single map_resource ("Kartenservice) 
#'     from the WFS service of the FisBroker Berlin
#' @return character
#'
#' @export
build_map_url <- function(map_resource) {
  map_url <- paste0(
    "https://fbinter.stadt-berlin.de/fb/index.jsp?loginkey=zoomStart&mapId=",
    map_resource,
    "@senstadt"
  )
  
  if (!url.exists(map_url)) {
    warning(paste("Map resource with url\n", map_url, "\ndoes not exist."))
    map_url <- NULL
  }
  
  return(map_url)
}
