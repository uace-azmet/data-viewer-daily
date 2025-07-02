#' `fxn_timeseriesGraphTitle.R` - Build title for time series graph
#' 
#' @return `timeseriesGraphTitle` - Title for time series graph


fxn_timeseriesGraphTitle <- function() {
  timeseriesGraphTitle <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          bsicons::bs_icon("graph-up"), 
          htmltools::HTML("&nbsp;"),
          htmltools::HTML("&nbsp;"),
          toupper("Daily data from START DATE through END DATE from across the network")
        ),
      ),
      
      class = "timeseries-graph-title"
    )
  
  return(timeseriesGraphTitle)
}
