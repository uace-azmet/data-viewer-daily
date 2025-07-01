sidebar <-
  bslib::sidebar(
    width = 300,
    position = "left",
    open = list(desktop = "open", mobile = "always-above"),
    id = "sidebar",
    title = NULL,
    bg = "#FFFFFF",
    fg = "#191919",
    class = NULL,
    max_height_mobile = NULL,
    gap = NULL,
    padding = NULL,

    bslib::accordion(
      id = "accordion",
      #open = "DATE SELECTION",
      #multiple = TRUE,
      class = NULL,
      width = "auto",
      height = "auto",
      
      htmltools::p(
        htmltools::HTML(
          paste0(
            bsicons::bs_icon("calendar-event"), 
            htmltools::HTML("&nbsp;"),
            htmltools::HTML("&nbsp;"),
            toupper("DATE SELECTION")
          ),
        ),
        
        class = "sls-graph-title"
      ),

      #bslib::accordion_panel(
        #title = "DATE SELECTION",
        #value = "dateSelection",
        #icon = bsicons::bs_icon("calendar-event"),

        shiny::helpText(shiny::em(
          "Set start and end dates of the period of interest. Then, click or tap 'RETRIEVE DATA'."
        )),

        htmltools::br(),

        shiny::dateInput(
          inputId = "startDate",
          label = "Start Date",
          value = lubridate::today(tzone = "America/Phoenix") - lubridate::dmonths(x = 3),
          min = apiStartDate,
          max = lubridate::today(tzone = "America/Phoenix") - 1,
          format = "MM d, yyyy",
          startview = "month",
          weekstart = 0, # Sunday
          width = "100%",
          autoclose = TRUE
        ),

        shiny::dateInput(
          inputId = "endDate",
          label = "End Date",
          value = lubridate::today(tzone = "America/Phoenix") - 1,
          min = apiStartDate,
          max = lubridate::today(tzone = "America/Phoenix") - 1,
          format = "MM d, yyyy",
          startview = "month",
          weekstart = 0, # Sunday
          width = "100%",
          autoclose = TRUE
        ),

        htmltools::br(),

        shiny::actionButton(
          inputId = "retrieveData",
          label = "RETRIEVE DATA",
          class = "btn btn-block btn-blue"
        )#,

        #htmltools::br()
      #)#,

      # bslib::accordion_panel(
      #   title = "DATA DISPLAY",
      #   value = "dataDisplay",
      #   icon = bsicons::bs_icon("sliders"),
      # 
      #   shiny::helpText(
      #     shiny::em(
      #       "Specify a station group to highlight and variable to show in the graph."
      #     )
      #   ),
      # 
      #   htmltools::br(),
      # 
      #   shiny::selectInput(
      #     inputId = "azmetStationGroup",
      #     label = "AZMet Station Group",
      #     choices = NULL, # see `app.R`, shiny::updateSelectInput(inputId = "azmetStationGroup")
      #     selected = NULL # see `app.R`, shiny::updateSelectInput(inputId = "azmetStationGroup")
      #   ),
      # 
      #   shiny::selectInput(
      #     inputId = "stationVariable",
      #     label = "Station Variable",
      #     choices = NULL, # see `app.R`, shiny::updateSelectInput(inputId = "stationVariable")
      #     selected = NULL # see `app.R`, shiny::updateSelectInput(inputId = "stationVariable")
      #   ),
      # 
      #   htmltools::br(),
      #   htmltools::br(),
      # 
      #   shiny::helpText(
      #     shiny::em(
      #       "We group stations by general proximity, as listed below. Scroll or swipe over the table to view additional columns."
      #     )
      #   ),
      # 
      #   htmltools::br(),
      #   
      #   reactable::reactableOutput(outputId = "stationGroupsTable")
      # ) # bslib::accordion_panel()
    ), # bslib::accordion()
  ) # bslib::sidebar()
