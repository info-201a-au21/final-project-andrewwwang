# shiny server file
# libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(rsconnect)
library(plotly)
library(lintr)
library(styler)

# source("aggregate_table.R")

# Importing data set
poverty_data <- read.csv("https://drive.google.com/uc?export=download&id=1Fu7qskDJgFUFfjNd9PDwxEr6HnSE0OOM")

# Poverty by year chart
create_poverty_chart <- function(poverty_data, selected_year, pov_size) {
  new_data <- poverty_data %>%
    filter(Year == selected_year)

  poverty_chart <- ggplot(
    new_data
  ) +
    geom_point(
      mapping = aes(x = Race, y = share),
      size = pov_size
    ) +
    ggtitle("Percentage of Race in Poverty By Year in King County") +
    labs(y = "% of Race in Poverty", x = "Race")
}

server <- function(input, output) {
  output$message <- renderText({
    msg <- paste0("hello there, ", input$textInput)
    return(msg)
  })
  output$poverty_chart <- renderPlotly({
    return(create_poverty_chart(
      poverty_data,
      input$selected_year,
      input$pov_size
    ))
  })
}

lint("app_server.R")
style_file("app_server.R")
