settings <- modules::module({
  creds <- function() {
    dbtools::Credentials(
      drv = RClickhouse::clickhouse,
      user = Sys.getenv("DB_USERNAME"),
      password = Sys.getenv("DB_PASSWORD"),
      db = Sys.getenv("DB_NAME"),
      host = Sys.getenv("DB_HOST"),
      port = as.integer(Sys.getenv("DB_PORT"))
    )
  }
  db_retries <- 2
  db_int_sleep <- 10
  chunk_size <- 1e5
})
