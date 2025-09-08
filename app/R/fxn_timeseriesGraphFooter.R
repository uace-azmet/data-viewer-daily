#' `fxn_timeseriesGraphFooter.R` - Build footer for time series graph
#' 
#' @return `timeseriesGraphFooter` - Footer for time series graph


fxn_timeseriesGraphFooter <- function() {
  timeseriesGraphFooter <- 
    htmltools::p(
      htmltools::HTML(
        "<strong>Time series graph:</strong> footer; <strong>Time series graph:</strong> footer"
      ), 
      
      class = "timeseries-graph-footer"
    )
  
  return(timeseriesGraphFooter)
}
