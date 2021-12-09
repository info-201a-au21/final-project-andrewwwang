# shiny server file
# libraries
library("ggplot2")
library("tidyverse")
library("dplyr")
library("plotly")

# source("aggregate_table.R")

server <- function(input, output) {
  output$message <- renderText({
    msg <- paste0("hello there, ", input$textInput)
    return(msg)
  })
}