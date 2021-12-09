# shiny server file
# libraries
library("ggplot2")
library("tidyverse")
library("dplyr")
library("plotly")

# source("aggregate_table.R")
salary_table <- aggregate_table %>%
    select("Year", "Asian_mean_salary", "Black_mean_salary", 
           "Hispanic_mean_salary", "Native_mean_salary",
           "Islander_mean_salary", "Two_mean_salary", 
           "Other_mean_salary", "White_not_mean_salary", "White_mean_salary",
           "Total_mean_salary")

pop_table <- aggregate_table %>%
  select("Year", "Total.Pop", "Male.Pop", 
         "Female.Pop", "White.Total.Pop",
         "White.Male.Pop", "White.Female.Pop", 
         "Black.Total.Pop", "Black.Male.Pop", "Black.Female.Pop",
         "AIAN.Total.Pop", "AIAN.Female.Pop", "AIAN.Male.Pop", 
         "Asian.Total.Pop", "Asian.Male.Pop", 
         "Asian.Female.Pop", "NHOPI.Male.Pop", 
         "NHOPI.Total.Pop", "NHOPI.Female.Pop", 
         "Two.or.More.Races.Total.Pop", "Two.or.More.Races.Male.Pop",
         "Two.or.More.Races.Female.Pop")

# plot salary chart
plot_salary_bar_chart <- function(chosen_year) {
  df <- salary_table %>% filter(Year == chosen_year)
  df <- data.frame(t(df))
  df <- cbind(rownames(df), data.frame(df))
  colnames(df) <- data.frame("Race", "Salary")
  df <- df %>% filter(Race != "Year")
  
  figure <- plot_ly(df,
                    x = ~Race, y = ~Salary,
                    name = "Average Salary ($) per Race in King County", type = "bar"
  )
  
  return(figure)
}

# plot pop chart
plot_pop_bar_chart <- function(chosen_year) {
  df <- pop_table %>% filter(Year == chosen_year)
  df <- data.frame(t(df))
  df <- cbind(rownames(df), data.frame(df))
  colnames(df) <- data.frame("Race", "Population")
  df <- df %>% filter(Race != "Year")
  
  figure <- plot_ly(df,
                    x = ~Race, y = ~Population,
                    name = "Population per Race in King County", type = "bar"
  )
  
  return(figure)
}

server <- function(input, output) {
  output$pop_plot <- renderPlotly({plot_pop_bar_chart(input$year_pop)})
  output$salary_plot <- renderPlotly({plot_salary_bar_chart(input$year_salary)})
}
