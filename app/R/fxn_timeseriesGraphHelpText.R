#' `fxn_timeseriesGraphHelpText.R` - Build help text for time series graph
#' 
#' @return `timeseriesGraphHelpText` - Help text for time series graph


fxn_timeseriesGraphHelpText <- function() {
  timeseriesGraphHelpText <- 
    htmltools::p(
      htmltools::HTML(
        "Hover over data for variable values and click or tap on legend items to toggle data visibility. Select from the icons to the right of the graph for additional functionality."
      ), 
      
      class = "timeseries-graph-help-text"
    )
  
  return(timeseriesGraphHelpText)
}
