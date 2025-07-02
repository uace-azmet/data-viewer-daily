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
  
  shiny::observeEvent(input$retrieveData, {
    if (input$startDate > input$endDate) {
      shiny::showModal(datepickerErrorModal) # `scr06_datepickerErrorModal.R`
    }
  })
  
  shiny::observeEvent(dataETL(), {
    shinyjs::showElement("pageBottomText")
  })
  
  shiny::updateSelectInput(
    inputId = "azmetStationGroup",
    label = "AZMet Station Group",
    choices = c("Apples", "Bananas", "Carrots"), #sort(unique(dataETL()$meta_station_group)),
    selected = "Carrots" #sort(unique(dataETL()$meta_station_group))[1]
  )
  
  shiny::updateSelectInput(
    inputId = "stationVariable",
    label = "Station Variable",
    choices = c("Apples", "Bananas", "Carrots"),
      # sort(
      #   colnames(
      #     dplyr::select(
      #       dataETL(), !c(datetime, meta_station_group, meta_station_name)
      #     )
      #   )
      # ),
    selected = "Bananas"
      # sort(
      #   colnames(
      #     dplyr::select(
      #       dataETL(), !c(datetime, meta_station_group, meta_station_name)
      #     )
      #   )
      # )[1]
  )
  
  
  # Reactives -----
  
  dataETL <- shiny::eventReactive(input$retreiveData, {
    # shiny::validate(
    #   shiny::need(
    #     expr = input$startDate <= input$endDate, 
    #     message = FALSE
    #   )
    # )
    # 
    # idPreview <- shiny::showNotification(
    #   ui = "Preparing data preview . . .", 
    #   action = NULL, 
    #   duration = NULL, 
    #   closeButton = FALSE,
    #   id = "idPreview",
    #   type = "message"
    # )
    # 
    # on.exit(shiny::removeNotification(id = idPreview), add = TRUE)
    
    fxn_dataETL(
      azmetStation = NULL, 
      timeStep = "Daily", 
      startDate = input$startDate, 
      endDate = input$endDate
    )
  })
  
  
  # Outputs -----
  
  output$pageBottomText <- shiny::renderUI({
    #shiny::req(dataETL())
    fxn_pageBottomText()
  })
  
  output$timeseriesGraphFooter <- shiny::renderUI({
    #shiny::req(dataETL()) - NEED THIS LATER
    fxn_timeseriesGraphFooter()
  })
  
  output$timeseriesGraphHelpText <- shiny::renderUI({
    #shiny::req(dataETL()) - NEED THIS LATER
    fxn_timeseriesGraphHelpText()
  })
  
  output$timeseriesGraphTitle <- shiny::renderUI({
    #shiny::req(dataETL()) - NEED THIS LATER
    fxn_timeseriesGraphTitle()
  })
  
  output$stationGroupsTable <- reactable::renderReactable({
    stationGroupsTable
  })
}


# Run --------------------

shinyApp(ui = ui, server = server)
