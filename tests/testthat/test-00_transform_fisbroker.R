


test_that("transform_fisbroker returns correctly transformed tibble",
          {
            # Arrange
            ### Points
            set.seed(123)
            n <- 100
            df <- data.frame(x = runif(n, 0, 100),
                             y = runif(n, 0, 50),
                             f1 = rnorm(n))
            sf_points1 <- sf::st_as_sf(df, coords = c("x", "y")) %>%
              sf::st_set_crs(25833)
            # Same object, but with a geometry column called "geom"
            sf_points2 <- sf_points1 %>% 
              rename(geom = "geometry")
            
            ### Lines
            sf_lines <- data.frame(
              ID = c("A", "A", "A", "B", "B", "C", "C"),
              X = c(647851, 647875, 647875, 647766, 647766, 647826, 647822),
              Y = c(6859335, 6859318, 6859319, 6859028, 6859030, 6859314, 6859316)
            ) %>%
              sf::st_as_sf(coords = c("X", "Y")) %>%
              dplyr::group_by(ID) %>%
              dplyr::summarize() %>%
              sf::st_cast("MULTILINESTRING") %>%
              sf::st_set_crs(25833)
            ### Polygons
            sf_polygons <-
              sf::st_read(system.file(file.path("shape", "nc.shp"),
                                      package = "sf"))
            
            # Act
            res_points1 <- transform_fisbroker(sf_points1)
            res_points2 <- transform_fisbroker(sf_points2)
            res_lines <- transform_fisbroker(sf_lines)
            res_polygons <- transform_fisbroker(sf_polygons)
            res <- list(res_points1, res_points2, res_lines, res_polygons)
            
            # Assert
            for (res_geom in res) {
              expect_true(!"sf" %in% class(res_geom))# should not be an sf object anymore
              expect_true("data.frame" %in% class(res_geom))
              expect_true(nrow(res_geom) > 0)
            }
            
            # Testing expected columns
            expect_equal(names(res_points1), c("f1", "lon", "lat", "geometry"))
            expect_equal(names(res_points2), c("f1", "lon", "lat", "geometry"))
            expect_equal(names(res_lines), names(sf_lines)) # no lon/lat here
            expect_equal(names(res_polygons), names(sf_polygons)) # no lon/lat here
            
            # Testing if geojson was created correctly as chracter in geometry column
            expect_match(res_points1$geometry, "Point", fixed = TRUE)
            expect_match(res_points2$geometry, "Point", fixed = TRUE)
            expect_match(res_lines$geometry, "MultiLineString", fixed =
                           TRUE)
            expect_match(res_polygons$geometry, "MultiPolygon", fixed =
                           TRUE)
            
            # Testing if reprojection was correct using first point:
            expect_match(res_points1$geometry[1],
                         "[10.511513756213715,0.00027057639142313107]",
                         fixed = TRUE)
            
          })
