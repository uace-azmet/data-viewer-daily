#' `fxn_dailyData.R` Download AZMet daily data from API-based database
#' 
#' @param azmetStation - AZMet station name
#' @param startDate - Start date of period of interest
#' @param endDate - End date of period of interest
#' @return `dailyData` - Table of downloaded, transformed daily data


fxn_dailyData <- function(azmetStation, startDate, endDate) {
  dailyData <- azmetr::az_daily(
    station_id = azmetStation,
    start_date = startDate, 
    end_date = endDate
  ) %>% 
    dplyr::select(all_of(c(dailyVarsID, dailyVarsMeasured, dailyVarsDerived))) %>%
    
    dplyr::mutate(
      temp_soil_10cm_maxC = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_10cm_maxC
      ),
      temp_soil_10cm_meanC = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_10cm_meanC
      ),
      temp_soil_10cm_minC = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_10cm_minC
      ),
      temp_soil_50cm_maxC = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_50cm_maxC
      ),
      temp_soil_50cm_meanC = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_50cm_meanC
      ),
      temp_soil_50cm_minC = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_50cm_minC
      ),
      temp_soil_10cm_maxF = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_10cm_maxF
      ),
      temp_soil_10cm_meanF = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_10cm_meanF
      ),
      temp_soil_10cm_minF = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_10cm_minF
      ),
      temp_soil_50cm_maxF = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_50cm_maxF
      ),
      temp_soil_50cm_meanF = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_50cm_meanF
      ),
      temp_soil_50cm_minF = dplyr::if_else(
        meta_station_name == "Test",
        NA_real_,
        temp_soil_50cm_minF
      )
    ) |>
    
    dplyr::mutate(
      dplyr::across("wind_2min_timestamp", as.character)
    ) %>% 
    
    dplyr::mutate(
      meta_station_group = dplyr::if_else(
        meta_station_name %in% c("Ft Mohave CA", "Mohave", "Mohave ETo", "Mohave-2", "Parker", "Parker-2"),
        "Group 1",
        dplyr::if_else(
          meta_station_name %in% c("Roll", "Wellton ETo", "Yuma N.Gila", "Yuma South", "Yuma Valley", "Yuma Valley ETo"),
          "Group 2",
          dplyr::if_else(
            meta_station_name %in% c("Aguila", "Buckeye", "Harquahala", "Paloma", "Salome"),
            "Group 3",
            dplyr::if_else(
              meta_station_name %in% c("Chino Valley", "Desert Ridge", "Payson", "Phoenix Encanto", "Phoenix Greenway"),
              "Group 4",
              dplyr::if_else(
                meta_station_name %in% c("Coolidge", "Maricopa", "Queen Creek", "Sahuarita", "Test", "Tucson"),
                "Group 5",
                "Group 6"
              )
            )
          )
        )
      )
    )
  
  return(dailyData)
}
