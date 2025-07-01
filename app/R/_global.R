# Libraries --------------------

library(azmetr)
library(bslib)
library(bsicons)
library(dplyr)
# library(english)
library(htmltools)
library(lubridate)
library(plotly)
library(reactable)
# library(reshape2)
library(shiny)
library(vroom)
library(tibble)


# Files --------------------

# Functions. Loaded automatically at app start if in `R` folder
#source("./R/fxn_functionName.R", local = TRUE)

# Scripts. Loaded automatically at app start if in `R` folder
#source("./R/scr_scriptName.R", local = TRUE)

azmetStationMetadata <- 
  vroom::vroom(
    file = "aux-files/azmet-station-metadata.csv", 
    delim = ",", 
    col_names = TRUE, 
    show_col_types = FALSE
  )


# Variables --------------------

apiStartDate <- as.Date("2021-01-01")

azmetStationMetadata <- azmetStationMetadata |>
  dplyr::mutate(
    end_date = dplyr::if_else(
      status == "active",
      lubridate::today(tzone = "America/Phoenix") - 1,
      end_date
    )
  )

# selectedTab <- shiny::reactiveVal(value = "Time Series")

stationGroups <-
  tibble::tibble(
    group1 = c("Ft Mohave CA", "Mohave", "Mohave ETo", "Mohave-2", "Parker", "Parker-2"),
    group2 = c("Roll", "Wellton ETo", "Yuma N.Gila", "Yuma South", "Yuma Valley", "Yuma Valley ETo"),
    group3 = c("Aguila", "Buckeye", "Harquahala", "Paloma", "Salome", NA),
    group4 = c("Chino Valley", "Desert Ridge", "Payson", "Phoenix Encanto", "Phoenix Greenway", NA),
    group5 = c("Coolidge", "Maricopa", "Queen Creek", "Sahuarita", "Test", "Tucson"),
    group6 = c("Bonita", "Bowie", "Elgin", "Safford", "San Simon", "Willcox Bench")
  )
