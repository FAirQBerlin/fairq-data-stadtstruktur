% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/00_db_utils.R
\name{send_query_clickhouse}
\alias{send_query_clickhouse}
\title{Send query wrapper}
\usage{
send_query_clickhouse(query, ...)
}
\arguments{
\item{query}{(character) a query as string or a file name.}

\item{...}{arbitrary arguments for parameterized queries.}
}
\description{
This is a wrapper around \link[dbtools]{sendQuery} to easily reference SQL files and
use credentials handled inside the package.
}
