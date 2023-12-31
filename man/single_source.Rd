% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/00_data_sources.R, R/01_single_sources.R
\name{data_sources}
\alias{data_sources}
\alias{single_source}
\title{Data sources to query from fisbroker}
\usage{
data_sources()

single_source(
  name,
  get_data = extract_fisbroker,
  transform_data = transform_fisbroker,
  load_table = paste0("stadtstruktur_", name),
  send_data = send_data_clickhouse,
  ...
)
}
\arguments{
\item{name}{(character) a unique name used as class and to identify target
table on database.}

\item{get_data}{(function)}

\item{transform_data}{(function)}

\item{load_table}{(character) the table in which we load data.}

\item{send_data}{(function)}

\item{...}{arguments used within methods and available for queries}
}
\description{
List data sources. This list defines which data source to extract from fisbroker.
}
