# Tabular and graphical summaries of daily data to support QA/QC

# Add code for the following
# 
# 'azmet-shiny-template.html': <!-- Google tag (gtag.js) -->


# UI --------------------

ui <- 
  htmltools::htmlTemplate(
    "azmet-shiny-template.html",
    
    pageDataViewerDaily = bslib::page(
      title = NULL,
      theme = theme, # `scr##_theme.R`
      #lang = "en",
      
      bslib::layout_sidebar(
        sidebar = pageSidebar, # `scr##_slsSidebar.R`
        navsetCardTab
      ),
      
      shiny::htmlOutput(outputId = "pageBottomText") # Common, regardless of card tab
    )
  )


# Server --------------------

server <- function(input, output, session) {
  shinyjs::useShinyjs(html = TRUE)
  shinyjs::hideElement("pageBottomText")
  
  
  # Observables -----
  
  shiny::observeEvent(input$retrieveDailyData, {
    if (input$startDate > input$endDate) {
      shiny::showModal(datepickerErrorModal) # `scr06_datepickerErrorModal.R`
    }
  })
  
  shiny::observeEvent(dailyData(), {
    shinyjs::showElement("pageBottomText")
    
    shiny::updateSelectInput(
      inputId = "stationGroup",
      label = "Station Group",
      choices = sort(unique(dailyData()$meta_station_group)),
      selected = sort(unique(dailyData()$meta_station_group))[1]
    )
    
    shiny::updateSelectInput(
      inputId = "stationVariable",
      label = "Station Variable",
      choices = c(dailyVarsMeasured, dailyVarsDerived),
      selected = c(dailyVarsMeasured, dailyVarsDerived)[1]
    )
  })
  
  
  # Reactives -----
  
  dailyData <- shiny::eventReactive(input$retrieveDailyData, {
    idRetrievingDailyData <- shiny::showNotification(
      ui = "Retrieving daily data . . .",
      action = NULL,
      duration = NULL,
      closeButton = FALSE,
      id = "idRetrievingDailyData",
      type = "message"
    )
    
    on.exit(
      shiny::removeNotification(id = idRetrievingDailyData), 
      add = TRUE
    )
    
    fxn_dailyData(
      azmetStation = NULL,
      startDate = input$startDate,
      endDate = input$endDate
    )
  })
  
  
  # Outputs -----
  
  output$table <- renderTable({
    dailyData()
  })
  
  output$pageBottomText <- shiny::renderUI({
    #shiny::req(dailyData())
    fxn_pageBottomText()
  })
  
  output$timeseriesGraph <- plotly::renderPlotly({
    fxn_timeseriesGraph(
      inData = dailyData(),
      stationGroup = input$stationGroup,
      stationVariable = input$stationVariable
    )
  })
  
  output$timeseriesGraphFooter <- shiny::renderUI({
    shiny::req(dailyData())
    fxn_timeseriesGraphFooter()
  })
  
  output$timeseriesGraphTitle <- shiny::renderUI({
    shiny::req(dailyData())
    fxn_timeseriesGraphTitle(
      startDate = input$startDate,
      endDate = input$endDate
    )
  })
  
  output$stationGroupsTable <- reactable::renderReactable({
    stationGroupsTable
  })
}


# Run --------------------

shinyApp(ui = ui, server = server)
