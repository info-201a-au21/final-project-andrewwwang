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

# ===========================================
# Population per race containing interactive widgets
first_page <- tabPanel(
  "Population Interaction Tab", # label for the tab in the navbart
  sidebarLayout( sidebarPanel(
    selectInput(inputId = "year_pop", "Select date", choices = c("2013", "2014", "2015", "2016", "2017", "2018", "2019"))
  ), # close sidebarLayout
  
  mainPanel(
    h3("Population"),
    br(), br(),
    plotlyOutput(outputId = "pop_plot"),
    br(), br(),
    
  ) )
)

# ===========================================
# Average salary per race containing interactive widgets
second_page <- tabPanel(
  "Salary Interation Tab", # label for the tab in the navbart
  sidebarLayout( sidebarPanel(
    selectInput(inputId = "year_salary", "Select date", choices = c("2013", "2014", "2015", "2016", "2017", "2018", "2019"))
  ), # close sidebarLayout
  
  mainPanel(
    h3("Salary"),
    br(), br(),
    plotlyOutput(outputId = "salary_plot"),
    br(), br(),
    
  ) )
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
  "Poverty Rates", # title
  first_page,
  second_page,
  third_page
)

lint("app_ui.R")
style_file("app_ui.R")
