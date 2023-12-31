#' Send data wrapper
#'
#' This is a wrapper around \link[dbtools]{sendData} to easily reference SQL files and
#' use credentials handled inside the package.
#'
#' @param df (data.frame) a data frame with the data.
#' @param table (str) name of the table in the database.
#' @param mode (str) "replace" (default), "insert" or "truncate".
#' @param ... arbitrary arguments for parameterized queries.
#' For "replace", the data is sent with "insert" and then the table is optimized to remove
#' duplicates w.r.t. the order statement (only if the sent data has more than 0 rows).
#' For "truncate", the table is first truncated (even if the new data is empty).
#'
#' @export
send_data_clickhouse <-
  function(df,
           table,
           mode = "replace",
           ...) {
    stopifnot(mode %in% c("insert", "truncate", "replace"))
    
    if (mode == "replace") {
      check_for_replacing_merge_tree(table)
    }
    
    if (mode == "truncate") {
      logging("Truncating table as mode is 'truncate'")
      send_query_clickhouse("truncate table {{ table_name }};", table_name = table)
    }
    
    if (nrow(df) == 0) {
      logging("Skipping sendData as nrow(df) == 0")
    } else {
      l_send_data(settings$creds(), df, table)
      if (mode == "replace") {
        optimize_table_final(table = table)
      }
      if (materialized_view_exists(table = table)) {
        logging("Optimize table processed by materialized view...")
        optimize_table_final(table = paste0(table, "_processed"))
      }
    }
  }


l_send_data <- function(cred, df, table) {
  logging("Sending to %s@%s@%s -- %s rows",
          table,
          cred$dbname,
          cred$host,
          nrow(df))
  chunk_size <- settings$chunk_size
  df_split_group <-
    list(rep(1:ceiling(nrow(df) / chunk_size), length.out = nrow(df)))
  dfs <- split(df, df_split_group)
  lapply(
    dfs,
    FUN = function(df) {
      logging("Sending chunk -- %s rows", nrow(df))
      dbtools::sendData(cred,
                        df,
                        table,
                        tries = settings$db_retries,
                        intSleep = settings$db_int_sleep)
    }
  )
}


check_for_replacing_merge_tree <- function(table) {
  table_engine <- send_query_clickhouse("table_engine",
                                        db_name = settings$creds()$db,
                                        table_name = table)[["engine"]]
  if (table_engine != "ReplacingMergeTree") {
    stop(
      sprintf(
        "Can't use mode 'replace' for table %s since as table engine is not ReplacingMergeTree",
        table
      )
    )
  }
}


optimize_table_final <- function(table) {
  # Optimize table to drop duplicates w.r.t. order statement
  # Works only if engine is "ReplacingMergeTree"
  logging("Optimizing %s...", table)
  send_query_clickhouse("Optimize table {{ table_name }} final;", table_name = table)
  if (materialized_view_exists(table)) {
    check_for_replacing_merge_tree(paste0(table, "_processed"))
    logging("Optimizing materialized view of %s...", table)
    send_query("Optimize table {{ table_name }}_processed final;", table_name = table)
  }
}

materialized_view_exists <- function(table) {
  # Check if a materialized view of a table exists, i.e., a table with the same name plus suffix
  # _processed
  mv_exists <- send_query("mv_exists",
                          db_name = settings$creds()$db,
                          table_name = table)
  mv_exists[[1]] == 1
}
