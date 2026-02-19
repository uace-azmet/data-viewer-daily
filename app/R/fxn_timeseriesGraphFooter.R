#' `fxn_timeseriesGraphFooter.R` - Build footer for time series graph
#' 
#' @return `timeseriesGraphFooter` - Footer for time series graph


fxn_timeseriesGraphFooter <- function() {
  timeseriesGraphFooter <- 
    htmltools::p(
      htmltools::HTML(
        ""
      ), 
      
      class = "timeseries-graph-footer"
    )
  
  return(timeseriesGraphFooter)
}
