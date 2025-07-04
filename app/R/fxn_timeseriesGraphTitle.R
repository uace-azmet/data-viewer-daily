#' `fxn_timeseriesGraphTitle.R` - Build title for time series graph
#' 
#' @param startDate - Start date of period of interest
#' @param endDate - End date of period of interest
#' @return `timeseriesGraphTitle` - Title for time series graph


fxn_timeseriesGraphTitle <- function(startDate, endDate) {
  timeseriesGraphTitle <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          bsicons::bs_icon("graph-up"), 
          htmltools::HTML("&nbsp;"),
          htmltools::HTML("&nbsp;"),
          toupper(
            paste0(
              "Daily data from ", 
              gsub(" 0", " ", format(startDate, "%B %d, %Y")), 
              " through ", 
              gsub(" 0", " ", format(endDate, "%B %d, %Y")), 
              " from across the network"
            )
          )
        ),
      ),
      
      class = "timeseries-graph-title"
    )
  
  return(timeseriesGraphTitle)
}
