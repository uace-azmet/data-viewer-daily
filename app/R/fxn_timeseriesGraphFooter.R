#' `fxn_timeseriesGraphFooter.R` - Build footer for time series graph
#' 
#' @return `timeseriesGraphFooter` - Footer for time series graph


fxn_timeseriesGraphFooter <- function() {
  timeseriesGraphFooter <- 
    htmltools::p(
      htmltools::HTML(
        "<strong>Since midnight local time:</strong> precip_total_in; temp_air_maxF; temp_air_minF; wind_2min_spd_max_mph_daily; wind_2min_vector_dir_max_daily; wind_spd_max_mph; <strong>Since the top of the hour:</strong> wind_2min_spd_max_mph_hourly; wind_2min_vector_dir_max_hourly"
      ), 
      
      class = "timeseries-graph-footer"
    )
  
  return(timeseriesGraphFooter)
}
