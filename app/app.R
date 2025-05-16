# <App description>

# Add code for the following
# 
# 'azmet-shiny-template.html': <!-- Google tag (gtag.js) -->


# Libraries
# library(azmetr)
# library(dplyr)
# library(htmltools)
# library(lubridate)
# library(shiny)
# library(vroom)

# Functions
#source("./R/fxnABC.R", local = TRUE)

# Scripts
#source("./R/scr##DEF.R", local = TRUE)


# UI --------------------

ui <- htmltools::htmlTemplate(
  
  "azmet-shiny-template.html",
  
) # htmltools::htmlTemplate()


# Server --------------------

server <- function(input, output, session) {
  
  # Observables -----
  
  # Reactives -----
  
  # Outputs -----
  
}


# Run --------------------

shinyApp(ui = ui, server = server)
