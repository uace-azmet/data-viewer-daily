# Tabular and graphical summaries of daily data to support QA/QC

# Add code for the following
# 
# 'azmet-shiny-template.html': <!-- Google tag (gtag.js) -->


# UI --------------------

ui <- 
  htmltools::htmlTemplate(
    "azmet-shiny-template.html",
    
    pageSidebar = bslib::page_sidebar(
      title = NULL,

      sidebar = sidebar, # `scr##_sidebar.R`

      navsetCardTab, # `scr##_navsetCardTab.R`

      # shiny::htmlOutput(outputId = "figureHelpText"),
      # shiny::htmlOutput(outputId = "figureFooter"),

      fillable = TRUE,
      fillable_mobile = FALSE,
      theme = theme, # `scr##_theme.R`
      lang = NULL,
      window_title = NA
    )
  )


# Server --------------------

server <- function(input, output, session) {
  
  # Observables -----
  
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
  
  # Outputs -----
  
  output$stationGroupsTable <- reactable::renderReactable({
    stationGroupsTable
  })
}


# Run --------------------

shinyApp(ui = ui, server = server)
