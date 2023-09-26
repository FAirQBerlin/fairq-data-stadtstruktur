
test_that("extract_fisbroker returns an sf object",
          {
            # Arrange
            wfs_resource_example <- "s_vms_detailnetz_spatial_bauwerke"
            # Act
            res <- extract_fisbroker(wfs_resource_example)
            # Assert
            expect_true("sf" %in% class(res))
            expect_true(nrow(res) > 0)
          })
