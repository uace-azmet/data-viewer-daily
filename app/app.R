# Tabular and graphical summaries of daily data to support QA/QC


# UI --------------------


ui <- 
  htmltools::htmlTemplate(
    "azmet-shiny-template.html",
    
    pageDataViewerDaily = 
      bslib::page(
        title = NULL,
        theme = theme, # `scr##_theme.R`
        #lang = "en",
        
        bslib::layout_sidebar(
          sidebar = pageSidebar, # `scr##_slsSidebar.R`
          shiny::uiOutput(outputId = "navsetCardTab")
        ),
      
      shiny::htmlOutput(outputId = "pageBottomText") # Common, regardless of card tab
      )
  )


# Server --------------------


server <- function(input, output, session) {
  
  shinyjs::useShinyjs(html = TRUE)
  shinyjs::hideElement(id = "pageBottomText")
  
  
  # Observables -----
  
  shiny::observeEvent(input$retrieveDailyData, {
    if (input$startDate > input$endDate) {
      shiny::showModal(datepickerErrorModal) # `scr##_datepickerErrorModal.R`
    }
  })
  
  shiny::observeEvent(dailyData(), {
    shinyjs::showElement(id = "navsetCardTab")
    shinyjs::showElement(id = "pageBottomText")
    showNavsetCardTab(TRUE)
    showPageBottomText(TRUE)
    
    shiny::updateTabsetPanel(
      session = shiny::getDefaultReactiveDomain(),
      inputId = "navsetCardTab",
      selected = "timeSeries"
    )
  })
  
  
  # Reactives -----
  
  dailyData <- 
    shiny::eventReactive(input$retrieveDailyData, {
      shiny::validate(
        shiny::need(
          expr = input$startDate <= input$endDate,
          message = FALSE # Failing validation test
        )
      )
      
      idRetrievingDailyData <- 
        shiny::showNotification(
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
  
  timeseriesGraphTitle <- 
    shiny::eventReactive(dailyData(), {
      fxn_timeseriesGraphTitle(
        startDate = input$startDate,
        endDate = input$endDate
      )
    })
  
  
  # Outputs -----
  
  output$navsetCardTab <- 
    shiny::renderUI({
      shiny::req(showNavsetCardTab())
      navsetCardTab # `scr##_navsetCardTab.R`
    })
  
  output$pageBottomText <- 
    shiny::renderUI({
      #shiny::req(dailyData())
      fxn_pageBottomText()
    })
  
  output$reportingText <- 
    shiny::renderUI({
      shiny::req(dailyData())
      htmltools::HTML(
        paste0(
          "<br>", htmltools::span("Coming soon", style = "font-family: monospace;")
        )
      )
    })
  
  output$stationGroupsTable <- 
    reactable::renderReactable({
      stationGroupsTable
    })
  
  output$table <- 
    renderTable({
      dailyData()
    })
  
  output$timeseriesGraph <- 
    plotly::renderPlotly({
      fxn_timeseriesGraph(
        inData = dailyData(),
        stationGroup = input$stationGroup,
        stationVariable = input$stationVariable
      )
    })
  
  output$timeseriesGraphFooter <- 
    shiny::renderUI({
      shiny::req(dailyData())
      fxn_timeseriesGraphFooter()
    })
  
  output$timeseriesGraphTitle <- 
    shiny::renderUI({
      timeseriesGraphTitle()
    })
  
  output$validationText <- 
    shiny::renderUI({
      shiny::req(dailyData())
      htmltools::HTML(
        paste0(
          "<br>", htmltools::span("Coming soon", style = "font-family: monospace;")
        )
      )
    })
}


# Run --------------------


shinyApp(ui = ui, server = server)
