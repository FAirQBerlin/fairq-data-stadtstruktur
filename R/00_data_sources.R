#' Data sources to query from fisbroker
#'
#' List data sources. This list defines which data source to extract from fisbroker.
#'
#' @export
#' @rdname single_source
data_sources <- function() {
  # Create an object for all data sources
  list(
    ## DETAILNETZ ###
    # Description of all network wfs_resources:
    # https://fbinter.stadt-berlin.de/fb_daten/beschreibung/detailnetz.html
    single_source(
      name = "network_edifice",
      title = "Detailnetz Bauwerke",
      wfs_resource = "s_vms_detailnetz_spatial_bauwerke",
      map_url = build_map_url("k_vms_detailnetz_wms_spatial")
    ),
    single_source(
      name = "network_streets",
      title = "Detailnetz Strassenabschnitte",
      wfs_resource = "s_vms_detailnetz_spatial_gesamt",
      map_url = build_map_url("k_vms_detailnetz_wms_spatial")
    ),
    single_source(
      name = "network_nodes",
      title = "Detailnetz Verbindungspunkte",
      wfs_resource = "s_vms_detailnetz_spatial_verbpunkte",
      map_url = build_map_url("k_vms_detailnetz_wms_spatial")
    ),
    ### BAUMBESTAND ###
    single_source(
      name = "trees_street",
      title = "Baumbestand Berlin - Strassenbaeume",
      wfs_resource = "s_wfs_baumbestand",
      map_url = build_map_url("k_wfs_baumbestand")
    ),
    single_source(
      name = "trees_park",
      title = "Baumbestand Berlin - Anlagenbaeume",
      wfs_resource = "s_wfs_baumbestand_an",
      map_url = build_map_url("k_wfs_baumbestand")
    ),
    ### BAULICHE DICHTE ###
    single_source(
      name = "buildings_density",
      title = "Staedtebauliche Dichte - GFZ/GRZ 2019 (Umweltatlas)",
      wfs_resource = "s06_09gfz_grz2015",
      map_url = build_map_url("k06_09_01gfz2015")
    ),
    ### GEBAEUDEHOEHEN ###
    single_source(
      name = "buildings_height",
      title = "Gebaeudehoehen (Umweltatlas)",
      wfs_resource = "s_06_10_1gebhoehen2021",
      map_url = build_map_url("k_06_10_1gebhoehen")
    ),
    ### VERKEHRSMENGEN ###
    single_source(
      name = "traffic",
      title = "Verkehrsmengen DTVw 2019",
      wfs_resource = "s_vmengen2019",
      map_url = build_map_url("k_vmengen2019")
    ),
    ### FLAECHENNUTZUNG ###
    single_source(
      name = "land_use",
      title = "Flaechennutzung und Stadtstruktur 2020",
      # contains "Reale Nutzung und Vegetationsbedeckung 2020 (Umweltatlas)"
      wfs_resource = "sach_nutz2020_nutzsa",
      map_url = build_map_url("k06_02_1nutz_vegbestand2020")
    ),
    ### EMISSIONEN ###
    single_source(
      name = "emissions",
      title = "Entwicklung Luftqualitaet - Emissionen 2015 (Umweltatlas)",
      wfs_resource = "s03_12_2emissionen",
      map_url = build_map_url("wmsk_03_12_2emissionen")
    ),
    ### Berlin LOR ###
    single_source(
      name = "berlin_lor",
      title = "Lebensweltlich orientierte Raeume (LOR) (01.01.2021)",
      wfs_resource = "s_lor_plr_2021",
      map_url = build_map_url("k_lor_2021"),
      transform_data = transform.berlin_lor
    ),
    ### Berlin Bezirke ###
    single_source(
      name = "berlin_bezirke",
      title = "ALKIS Berlin Bezirke",
      wfs_resource = "s_wfs_alkis_bezirk",
      map_url = build_map_url("k_alkis_bezirke")
    ),
    ### MESSSTATIONEN ###
    single_source(
      name = "measuring_stations",
      title = "BLUME Mesststationen",
      wfs_resource = "s_messpunkte",
      map_url = build_map_url("messpunkte")
    )
  ) %>%
    name_data_sources()
  
}


#' Name elements of a list of data sources
#'
#' Use the $name of a single source to name its element in a
#' a list of data sources.
#'
#'@param data_sources_list (list) an unnamed list of single sources
#'@return list of named single sources, names correspond to elements'
#'        $name slot.
#'
name_data_sources <- function(data_sources_list) {
  names <- lapply(data_sources_list, `[[`, "name") %>% unlist
  names(data_sources_list) <- names
  return(data_sources_list)
}
