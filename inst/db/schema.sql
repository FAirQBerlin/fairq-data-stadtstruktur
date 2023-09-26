-- fairq_raw.stadtstruktur_network_edifice definition
CREATE TABLE fairq_raw.stadtstruktur_network_edifice
(
    `gml_id` String,
    `bauwerksart` String,
    `bauwerksname` String,
    `okstra_id` String,
    `bauwerksnummer` String,
    `sib_bauwerksnummer` String,
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_network_nodes definition
CREATE TABLE fairq_raw.stadtstruktur_network_nodes
(
    `gml_id` String,
    `verkehrsebene` Int32,
    `okstra_id` String,
    `lon` Float64,
    `lat` Float64,
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_network_streets definition
CREATE TABLE fairq_raw.stadtstruktur_network_streets
(
    `gml_id` String,
    `element_nr` String,
    `strassenschluessel` Int32,
    `strassenname` String,
    `strassenklasse1` String,
    `strassenklasse` String,
    `strassenklasse2` String,
    `verkehrsrichtung` String,
    `bezirk` Nullable(String),
    `stadtteil` Nullable(String),
    `verkehrsebene` Int32,
    `beginnt_bei_vp` Int32,
    `endet_bei_vp` Int32,
    `laenge` Float64,
    `gueltig_von` String,
    `okstra_id` String,
    `str_bez` Nullable(String),
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_buildings_density definition
CREATE TABLE fairq_raw.stadtstruktur_buildings_density
(
    `gml_id` String,
    `schl5` Float64,
    `flalle` Float64,
    `gfz_19_2` Float64,
    `grz_19_2` Float64,
    `grz_19_4` Float64,
    `woz_name` Nullable(String),
    `typklar` String,
    `grz_name` Nullable(String),
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_buildings_height definition
CREATE TABLE fairq_raw.stadtstruktur_buildings_height
(
    `gml_id` String,
    `role_txt` Nullable(String),
    `hoehe` Float64,
    `dachart` Nullable(Int32),
    `dachart_txt` Nullable(String),
    `geschosse` Nullable(Int32),
    `quellebodenhoehe` Nullable(Int32),
    `quellebodenhoehe_txt` Nullable(String),
    `quelledachhoehe` Int32,
    `quelledachhoehe_txt` Nullable(String),
    `quellelage` Nullable(Int32),
    `quellelage_txt` Nullable(String),
    `grundrissaktualitaet` Nullable(String),
    `gemeinde_txt` Nullable(String),
    `strasse` Nullable(String),
    `hnr` Nullable(String),
    `name` Nullable(String),
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_emissions definition
CREATE TABLE fairq_raw.stadtstruktur_emissions
(
    `gml_id` String,
    `idnr_1km` Int32,
    `x_max` Int32,
    `x_min` Int32,
    `y_max` Int32,
    `y_min` Int32,
    `area` Int32,
    `nox_h_15` Float64,
    `nox_i_15` Float64,
    `nox_v_gn15` Float64,
    `nox_v_hn15` Float64,
    `nox_v_nn15` Float64,
    `nox_ge_15` Float64,
    `pm10_h_15` Float64,
    `pm10_i_15` Float64,
    `pm10_vgn15` Float64,
    `pm10_vhn15` Float64,
    `pm10_vnn15` Float64,
    `pm10_ge_15` Float64,
    `pm2_5_h_15` Float64,
    `pm2_5_i_15` Float64,
    `pm25_vgn15` Float64,
    `pm25_vhn15` Float64,
    `pm25_vnn15` Float64,
    `pm25_ge15` Int32,
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_land_use definition
CREATE TABLE fairq_raw.stadtstruktur_land_use
(
    `gml_id` String,
    `schl5` Float64,
    `bez` Int32,
    `bezirk` String,
    `woz` Nullable(Int32),
    `woz_name` Nullable(String),
    `ststrnr` Nullable(Int32),
    `ststrname` String,
    `typ` Int32,
    `typklar` String,
    `nutz` Int32,
    `nutzung` String,
    `nutz_bauvor` Int32,
    `nutzung_bauvor` String,
    `flalle` Float64,
    `grz` Nullable(Int32),
    `grz_name` Nullable(String),
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_traffic definition
CREATE TABLE fairq_raw.stadtstruktur_traffic
(
    `gml_id` String,
    `link_id` String,
    `elem_nr` String,
    `vnp` Int32,
    `nnp` Int32,
    `vst` Int32,
    `bst` Int32,
    `vricht` String,
    `ebene` Int32,
    `str_typ` String,
    `strklasse1` String,
    `strklasse` String,
    `strklasse2` String,
    `str_name` String,
    `bezirk` Nullable(String),
    `stadtteil` Nullable(String),
    `dtvw_kfz` Int32,
    `dtvw_lkw` Int32,
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_trees_park definition
CREATE TABLE fairq_raw.stadtstruktur_trees_park
(
    `gml_id` String,
    `baumid` String,
    `standortnr` Nullable(String),
    `kennzeich` Nullable(String),
    `namenr` Nullable(String),
    `art_dtsch` Nullable(String),
    `art_bot` Nullable(String),
    `gattung_deutsch` Nullable(String),
    `gattung` Nullable(String),
    `pflanzjahr` Nullable(Int32),
    `standalter` Nullable(Float64),
    `stammumfg` Nullable(Int32),
    `bezirk` String,
    `eigentuemer` String,
    `kronedurch` Nullable(Float64),
    `baumhoehe` Nullable(Float64),
    `lon` Float64,
    `lat` Float64,
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_trees_street definition
CREATE TABLE fairq_raw.stadtstruktur_trees_street
(
    `gml_id` String,
    `baumid` String,
    `standortnr` Nullable(String),
    `kennzeich` String,
    `namenr` String,
    `art_dtsch` Nullable(String),
    `art_bot` Nullable(String),
    `gattung_deutsch` Nullable(String),
    `gattung` Nullable(String),
    `strname` Nullable(String),
    `hausnr` Nullable(String),
    `pflanzjahr` Nullable(Int32),
    `standalter` Nullable(Float64),
    `stammumfg` Nullable(Int32),
    `baumhoehe` Nullable(Float64),
    `bezirk` String,
    `eigentuemer` String,
    `zusatz` Nullable(String),
    `kronedurch` Nullable(Float64),
    `lon` Float64,
    `lat` Float64,
    `geometry` String
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_berlin_lor definition
CREATE TABLE fairq_raw.stadtstruktur_berlin_lor
(
    `gml_id` String comment 'fisbroker id',
    `PLR_ID` String comment 'Planungsraum id (low level) - 8 digits',
    `PLR_NAME` String comment 'Planungsraum name (low level)',
    `BZR_ID` String comment 'Bezirksregion id (mid level) - 6 digits',
    `BZR_NAME` String comment 'Bezirksregion name (mid level)',
    `PGR_ID` String comment 'Prognoseraum id (high level) - 4 digits',
    `PGR_NAME` String comment 'Prognoseraum name (high level)',
    `BEZ` String comment 'Bezirk id (equivalent to GEM in Bezirk system) - 2 digits',
    `FINHALT` Float64 comment 'area in square metres',
    `STAND` String comment 'last updated by authorities',
    `geometry` String comment 'geodata geometries'
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_berlin_bezirke definition
CREATE TABLE fairq_raw.stadtstruktur_berlin_bezirke
(
    `gml_id` String comment 'fisbroker id',
    `GEM` Int32 comment 'Bezirk id (equivalent to BEZ in LOR system)',
    `NAMGEM` String comment 'Bezirk name',
    `NAMLAN` String comment 'Bundesland name',
    `LAN` Int32 comment 'Bundesland id',
    `NAME` Int32 comment 'LOR key id',
    `geometry` String comment 'geodata geometries'
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- fairq_raw.stadtstruktur_measuring_stations definition
CREATE TABLE fairq_raw.stadtstruktur_measuring_stations
(
    `gml_id` String comment 'fisbroker id',
    `id` String comment 'measuring station id',
    `link` String comment 'url to measuring station details website ',
    `messnetz` String comment 'type of measuring network',
    `stand` String comment 'in use / out of order',
    `stattyp` String comment 'type of measuring station',
    `plz` Int32 comment 'address/location of measuring station',
    `adresse` String comment 'address/location of measuring station',
    `lon` Float64 comment 'longitude',
    `lat` Float64 comment 'latitude',
    `geometry` String comment 'geodata geometries'
)
ENGINE = ReplacingMergeTree()
ORDER BY gml_id;

-- stadtstruktur_measuring_stations destination table for materialized view
CREATE TABLE fairq_raw.stadtstruktur_measuring_stations_processed
(

    `gml_id` String COMMENT 'fisbroker id',

    `id` String COMMENT 'measuring station id',

    `link` String COMMENT 'url to measuring station details website ',

    `messnetz` String COMMENT 'type of measuring network',

    `stand` String COMMENT 'in use / out of order',

    `stattyp` String COMMENT 'type of measuring station',

    `plz` Int32 COMMENT 'address/location of measuring station',

    `adresse` String COMMENT 'address/location of measuring station',

    `lon` Float64 COMMENT 'longitude',

    `lat` Float64 COMMENT 'latitude',

    `geometry` String COMMENT 'geodata geometries',
    
    `lat_int` Int32 COMMENT 'latitude integer (factor 100000)',

    `lon_int` Int32 COMMENT 'longitude integer (factor 100000)'
)
ENGINE = ReplacingMergeTree
ORDER BY gml_id
SETTINGS index_granularity = 8192;

-- stadtstruktur_measuring_stations materialized view
CREATE MATERIALIZED VIEW fairq_raw.stadtstruktur_measuring_stations_mv
TO fairq_raw.stadtstruktur_measuring_stations_processed
AS SELECT
   	`gml_id`,
	`id`,
	`link`,
	`messnetz`,
	`stand`,
	`stattyp`,
	`plz`,
	`adresse`,
	`lon`,
	`lat`,
	`geometry`,
	toInt32(round(`lat` * 100000)) as lat_int,
	toInt32(round(`lon` * 100000)) as lon_int
FROM fairq_raw.stadtstruktur_measuring_stations
ORDER BY gml_id;

-- initial insert into destination (MV only triggered by inserts into base table stadtstruktur_measuring_stations)
INSERT INTO fairq_raw.stadtstruktur_measuring_stations_processed
SELECT
 	`gml_id`,
	`id`,
	`link`,
	`messnetz`,
	`stand`,
	`stattyp`,
	`plz`,
	`adresse`,
	`lon`,
	`lat`,
	`geometry`,
	toInt32(round(`lat` * 100000)) as lat_int,
	toInt32(round(`lon` * 100000)) as lon_int
FROM fairq_raw.stadtstruktur_measuring_stations
ORDER BY gml_id;
