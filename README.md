# fairq-data-stadtstruktur

This repository contains R code that downloads data from Berlin's official open geodata portal ["FIS Broker"](https://www.berlin.de/sen/sbw/stadtdaten/geoportal/geoportal-daten-und-dienste/) and writes them into the raw schema of the database.


## How to use this package

- Create an `.Renviron` file in the project folder and fill it with credentials, see `.Renviron_template` for the structure.
- Build the R package
- Create database as described in https://github.com/INWT/fairq-data/tree/main/inst/db (schema `fairq_raw`)
- Run `inst/RScripts/main.R` to start the ETL (= download geodata from "FIS Broker", transform geodata, write it to database)


## Input and output

### Input

- Various relevant WFS resources. taken from the ["FIS Broker"](https://fbinter.stadt-berlin.de/fb/index.jsp). See `R/00_data_sources.R` for all resources used. To obtain a working link, replace the <MAP_URL> by the name of the map_url-parameter in data_sources.R in the following link:
 ```https://fbinter.stadt-berlin.de/fb/index.jsp?loginkey=zoomStart&mapId=<MAP_URL>```


### Output

- Database, schema `fairq_raw`. All output tables written to the database follow the naming convention `stadtstruktur_*`.
