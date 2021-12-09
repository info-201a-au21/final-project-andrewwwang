library(shiny)
library(tidyverse)
library(ggplot2)
library(rsconnect)
library(plotly)
library(lintr)
library(styler)

# Loading data set to find years
poverty_data <- read.csv("https://drive.google.com/uc?export=download&id=1Fu7qskDJgFUFfjNd9PDwxEr6HnSE0OOM")
pov_years <- poverty_data$Year

first_page <- tabPanel(
  "Page 1",
  textInput(
    inputId = "1",
    label = h3("test text input"),
    placeholder = "enter text here"
  ),
  textOutput(
    outputId = "3"
  )
)

second_page <- tabPanel(
  "Page 2",
  textInput(
    inputId = "2",
    label = h3("test text input"),
    placeholder = "enter text here"
  ),
  textOutput(
    outputId = "4"
  )
)

# ===========================================
# Sidebar containing interactive widgets
poverty_sidebar <- sidebarPanel(
  p("Find Percentage of Races in Poverty"),
  selectInput(
    inputId = "selected_year",
    label = "Choose year",
    choices = pov_years
  ),
  sliderInput(
    inputId = "pov_size",
    label = "Size of point", min = 1, max = 10, value = 3
  )
)

# Percentage poverty by year chart
pov_chart <- mainPanel(
  plotlyOutput("poverty_chart")
)

third_page <- tabPanel(
  "Page 3",
  titlePanel("Percentage of Race in Poverty"),
  sidebarLayout(poverty_sidebar, pov_chart)
)

ui <- navbarPage(
  "Assignment 4", # title
  first_page,
  second_page,
  third_page
)

lint("app_ui.R")
style_file("app_ui.R")
