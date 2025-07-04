navsetCardTab <- bslib::navset_card_tab(
  id = "navsetCardTab",
  selected = "reporting",
  title = NULL,
  sidebar = NULL,
  header = NULL,
  footer = NULL,
  height = 700,
  full_screen = TRUE,
  #wrapper = card_body,
  
  bslib::nav_panel(
    title = "Reporting",
    value = "reporting"#,
    #tableOutput("table")
    #plotly::plotlyOutput("scatterplot")
  ),
  
  bslib::nav_panel(
    title = "Time Series",
    value = "timeSeries",
    
    bslib::layout_sidebar(
      sidebar = timeseriesSidebar, # `scr##_timeseriesSidebar.R`
      
      shiny::htmlOutput(outputId = "timeseriesGraphTitle"),
      shiny::htmlOutput(outputId = "timeseriesGraphHelpText"),
      plotly::plotlyOutput("timeseriesGraph"),
      shiny::htmlOutput(outputId = "timeseriesGraphFooter")
    )
  ),
  
  bslib::nav_panel(
    title = "Validation",
    value = "validation"#,
    #plotly::plotlyOutput("scatterplot")
  )
) |>
  htmltools::tagAppendAttributes(
    #https://getbootstrap.com/docs/5.0/utilities/api/
    class = "border-0 rounded-0 shadow-none"
  )
