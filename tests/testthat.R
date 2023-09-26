library(testthat)
library(lintr)
library(fairqDataStadtstruktur)

Sys.setenv(NOT_CRAN = "true")

test_check("fairqDataStadtstruktur")
