# berlin_lor ----

#' Transform for berlin_lor
#'
#' @param x fisbroker single_source
#' @param ... other parameters
#'
transform.berlin_lor <-
  function(x, ...) {
    lor <- x$dat
    
    logging("Transforming IDs of LOR data into strings with trailing '0's")
    # IDs are in fact strings and have trailing 0s, but they are not
    # recognized as such. So we add a trailing "0" and turn it into a string
    # Here is the offical documentation that PLR_ID is 8 digits, etc...
    # https://www.stadtentwicklung.berlin.de/planen/basisdaten_stadtentwicklung/
    # lor/download/LOR-Schluesselsystematik_2021.docx
    lor$PLR_ID <- stri_pad_left(lor$PLR_ID, width = 8, pad = "0")
    lor$BZR_ID <- stri_pad_left(lor$BZR_ID, width = 6, pad = "0")
    lor$PGR_ID <- stri_pad_left(lor$PGR_ID, width = 4, pad = "0")
    lor$BEZ <- stri_pad_left(lor$BEZ, width = 2, pad = "0")
    
    lor <- lor %>% rename(geometry = "GEOM")
    stopifnot(st_crs(lor) == st_crs(25833)) # CRS must be EPSG:25833!
    
    lor_df <- sf_to_geojson_df(lor)
    
    x$dat <- lor_df
    
    x
  }
