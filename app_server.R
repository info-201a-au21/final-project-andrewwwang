# shiny server file
# libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(rsconnect)
library(plotly)
library(lintr)
library(styler)

source("aggregate_table.R")
salary_table <- aggregate_table %>%
    select("Year", "Asian_mean_salary", "Black_mean_salary", 
           "Hispanic_mean_salary", "Native_mean_salary",
           "Islander_mean_salary", "Two_mean_salary", 
           "Other_mean_salary", "White_not_mean_salary", "White_mean_salary",
           "Total_mean_salary")

colnames(salary_table) <- c("Year", "Asian Mean Salary", "Black Mean Salary", 
                            "Hispanic Mean Salary", "Native Mean Salary",
                            "Islander Mean Salary", "Two Mean Salary", 
                            "Other Mean Salary", "White Not Mean Salary", "White Mean Salary",
                            "Total Mean Salary")

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

pop_table <- data.frame(apply(apply(pop_table, 2, gsub, patt=",", replace=""), 2, as.numeric))

colnames(pop_table) <- c("Year", "Total Pop", "Male Pop", 
                         "Female Pop", "White Total Pop",
                         "White Male Pop", "White Female Pop", 
                         "Black Total Pop", "Black Male Pop", "Black Female Pop",
                         "AIAN Total Pop", "AIAN Female Pop", "AIAN Male Pop", 
                         "Asian Total Pop", "Asian Male Pop", 
                         "Asian Female Pop", "NHOPI Male Pop", 
                         "NHOPI Total Pop", "NHOPI Female Pop", 
                         "Two or More Races Total Pop", "Two or More Races Male Pop",
                         "Two or More Races Female Pop")

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
  output$pop_plot <- renderPlotly({plot_pop_bar_chart(input$year_pop)})
  output$salary_plot <- renderPlotly({plot_salary_bar_chart(input$year_salary)})
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

# lint("app_server.R")
# style_file("app_server.R")
 