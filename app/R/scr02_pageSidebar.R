pageSidebar <-
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
      id = "pageAccordion",
      #open = "DATE SELECTION",
      #multiple = TRUE,
      class = NULL,
      width = "auto",
      height = "auto",
      
      # Visible elements
      
      htmltools::p(
        htmltools::HTML(
          paste0(
            bsicons::bs_icon("calendar-event"), 
            htmltools::HTML("&nbsp;"),
            htmltools::HTML("&nbsp;"),
            toupper("DATE SELECTION")
          ),
        ),
        
        class = "page-sidebar"
      ),
      
      shiny::helpText(shiny::em(
        "Set start and end dates of the period of interest. Then, click or tap 'RETRIEVE DATA'. Once data appear, click or tap the above chevron to toggle sidebar visibility."
      )),
      
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
      
      #selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
      shiny::actionButton(
        inputId = "retrieveDailyData",
        label = "RETRIEVE DAILY DATA",
        class = "btn btn-block btn-blue"
      )
    ) # bslib::accordion()
  ) # bslib::sidebar()
