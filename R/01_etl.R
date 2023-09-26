etl <- function(x, ...) {
  # nolint start
  logging("--- Extract ---        %s", x$name)
  x <- extract(x, ...)
  logging("--- Transform ---      %s", x$name)
  x <- transform(x, ...)
  logging("--- Load ---           %s", x$name)
  lload(x, ...)
  logging("~~~ Finished ~~~       %s", x$name)
  # nolint end
  return(x)
}

extract <- function(x, ...)
  UseMethod("extract")
transform <- function(x, ...)
  UseMethod("transform")
# to avoid name clash with base::load -> l(ocal)load:
lload <- function(x, ...)
  UseMethod("load")

extract.NULL <- function(x, ...) {
  log_debug("Skipping extract because of NULL value")
  NULL
}
transform.NULL <- function(x, ...) {
  log_debug("Skipping transform because of NULL value")
  NULL
}
load.NULL <- function(x, ...) {
  log_debug("Skipping load because of NULL value")
  NULL
}

extract.default <- function(x, ...) {
  log_debug("Entering 'default' extract method for '%s'", x$name)
  
    params <- x[unlist(lapply(x, Negate(is.function)))]

    x$dat <- do.call(x$get_data, params, ...)
    
  if (nrow(x$dat) == 0)
    x <- NULL
  
  
  return(x)
}

transform.default <- function(x, ...) {
  log_debug("Entering 'default' transform method for '%s'", x$name)
  
  x$dat <- x$transform_data(sf_obj = x$dat)
  if (nrow(x$dat) == 0)
    x <- NULL
  
  return(x)
}

load.default <- function(x, ...) {
  log_debug("Entering 'default' lload method for '%s'", x$name)
  do.call(x$send_data,
          list(
            df = x$dat,
            table = x$load_table,
            title = x$title
          ))
}
