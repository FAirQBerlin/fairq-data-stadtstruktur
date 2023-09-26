



#' Get fisbroker data
#'
#' Downloads raw geodata from WFS services of the fisbroker Berlin
#'
#' @param wfs_resource name of a single wfs_resource from the WFS service of the FisBroker Berlin
#' @param crs coordinate reference system or spatial reference
#'     system (srs) - defaults to "EPSG:25833"
#' @param ... arbitrary arguments for parameterized queries.
#' @return sf object
#'
#' @export
extract_fisbroker <-
  function(wfs_resource, crs = "EPSG:25833", ...) {
    url <- wfs_resource %>%
      build_wfs_url() %>%
      parse_url()
    
    url$query <- list(
      service = "wfs",
      version = "2.0.0",
      request = "GetFeature",
      srsName = crs,
      TYPENAMES = wfs_resource
    )
    
    request <- httr::build_url(url)
    logging("Sending request to fisbroker to get wfs resource %s",
            wfs_resource)
    sf_obj <- read_sf(request)
    
    return(sf_obj)
  }


#' Build a complete wfs fisbroker url
#'
#' creates full url for a single wfs_resource WFS service of the FisBroker Berlin
#' to be passed on to extract_fisbroker()
#'
#' @param wfs_resource name of a single wfs_resource from the WFS service of the FisBroker Berlin
#' @return character
#'
#' @export
build_wfs_url <- function(wfs_resource) {
  paste0("https://fbinter.stadt-berlin.de/fb/wfs/data/senstadt/",
         wfs_resource)
}
