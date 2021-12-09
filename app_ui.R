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

intro_page <- tabPanel(
  "Intro tab",
  titlePanel("Poverty Rates in King County"),
  
  p("Poverty is defined as \"the state of being extremely poor\". Across the US
    , low-income BIPOC communities have an increased risk of experiencing poverty
    in comparison to white middle-class families. Living in the U-District, our
    team has witnessed the ways in which poverty and low-income levels have 
    affected houseless folks within our area. As a result, our project aims to
    analyze how factors such as household income, race, and gender 
    impact the poverty line."),
  
  img(src = "https://atlantablackstar.com/wp-content/uploads/2015/03/seattle_homeless_tent_020615-e1427288992871.jpg",
      width = "320px", height = "188px"),
  
  br(), br(),
  
  p("Some questions we considered when formatting our analysis was “How does 
    income vary by race?”, “Are there major differences in income between males
    and females of similar occupation”, and “Which race has the highest 
    percentage in poverty?"),
  
  p("To answer these questions, we consulted data from the US Census and 
    Data USA. The US Census", 
    a(href="https://data.census.gov/cedsci/profile?g=0500000US53033",
      "(Census - Geography Profile)"), 
    "gathers data 
    pertaining to race, income, gender, household information, and various 
    living factors that help government officials make informed policy 
    decisions."),
  
  p("Data USA",
    a(href="https://datausa.io/profile/geo/king-county-wa?fbclid=IwAR3juQdZmWa9S33Or2imCHCi5NVHOsNi0bcjL5yAlA_-c7IHaN9LHGwZYiM",
      "(King County, WA | Data USA)")
    ,
    "was founded by Deloitte, Datawheel,
    and Cesar Hidalgo, Professor at the MIT Media Lab and Director of 
    Collective Learning. Its primary mission is to collect public US Government
    data and organize it into a visualization search engine for public use. 
    Both data sources are organized by credible public and private sources and
    rely on survey data collected from residents of the US."),
  
  p("We hope this report allows users to be more aware of the demographics 
    largely impacted by poverty and encourages a more empathetic disposition 
    towards our community members. "),
  
  img(src = "https://mltoday.com/wp-content/uploads/2017/12/poverty-1280x640.jpg",
      width = "320px", height = "188px"),
  
  
)

summary_page <- tabPanel(
  "Summary tab",
  titlePanel("Anaylsis of Poverty Rates in King County"),
  
  p("Based on our data analysis, we can conclude that the Asian population had 
    the highest average household income of $118,856 from 2013 to 2019 in King 
    County. On the other hand, Native American and Black households had the 
    lowest average income with $60,598 and $67,939 respectively. "),
  
  p("In analyzing the average household income within King County, we then 
    conducted research on the change in race over time. By doing so, we were
    able to see the ways in which that race affected the average household 
    income. In recent years, there has been a decrease in the white population
    with -2,271 from 2019 to 2020. Compared to the mixed population, however,
    there has been an increase with +2,275 from 2019 to 2020. Afterward, we
    honed in on the aspects of race and their change in income. We found that
    the Pacific Islander population not only had the highest increase in income
    with $11,943 from 2015, but they also had the highest decrease two years
    later with -$4,112 from 2017. "),
  
  p("In further evaluating the impacts of income on marginalized communities 
    of color, we examined the average difference in men’s and women’s income
    from similar occupations. We found that men and women earned about the
    same for similar occupations, however, women earned more as software
    developers, and men earned more as retail salespersons. "),
  
  p("Lastly, we looked into the racial demographics of which groups had the
    highest poverty rates. White populations have the highest rate of poverty
    at 43%, whereas the Native American and Pacific Islander populations had
    the lowest rate of poverty at 1%. While this may be the case, it is highly
    imperative to note that white populations tend to be overrepresented in US
    Census statistics. Many marginalized groups, especially those coming from 
    immigrant backgrounds, are not knowledgeable about issues related to the 
    importance of population information. In addition, residents may not be 
    proficient in English or live in accessible communities that allow them 
    to be interviewed for the Census Bureau. Marginalized groups are historically
    underrepresented and for this reason, much of the public funding doesn’t 
    directly go to communities in need. More specifically, marginalized 
    communities of color. "),
  
  p("To conclude our research, countless factors come into play when it comes
    to analyzing the poverty line within the greater King County area.
    While much of it involves the assumption that poverty occurs because
    people are out of jobs, it is also important to recognize that poverty
    is structural violence. It is the ways in which that social structures
    and institutions harm people by preventing them from meeting their basic
    needs. People moving in and out of poverty isn’t solely because they’re
    “lazy” to find jobs, it’s because of capitalism and how within this
    economic system, people aren’t given a sustainable income to make
    a living for themselves.")
)

# ===========================================
# Population per race containing interactive widgets
first_page <- tabPanel(
  "Population Interaction Tab", # label for the tab in the navbart
  sidebarLayout( sidebarPanel(
    selectInput(inputId = "year_pop", "Select date", choices = c("2013", "2014", "2015", "2016", "2017", "2018", "2019")),
    br("Change the year to see how the population of different races in King County vary by year.")
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
    selectInput(inputId = "year_salary", "Select date", choices = c("2013", "2014", "2015", "2016", "2017", "2018", "2019")),
    br("Change the year to see how the average salary of different races in King County vary by year.")
    ),
  
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
  ),
  br("Change the year to see how the percentage of different races in King County vary by year. 
     Additionally, you can adjust the size of the points for easier viewing.")
)

# Percentage poverty by year chart
pov_chart <- mainPanel(
  plotlyOutput("poverty_chart")
)

third_page <- tabPanel(
  "Percentage of Race in Poverty Interaction Tab",
  titlePanel("Percentage of Race in Poverty"),
  sidebarLayout(poverty_sidebar, pov_chart)
)


ui <- navbarPage(
  title = span( "Poverty Rates in King County", style = "font-size:40px;" ),
  tags$style(type = 'text/css', 
             '.navbar { background-color: #d6dbde;}',
             '.navbar-default .navbar-brand{color: #465055;}',
             '.tab-panel{ background-color: black; color: white}',
             '.nav navbar-nav li.active:hover a, .nav navbar-nav li.active a {
                        background-color: blue ;
                        border-color: blue;
                        }'
             
  ),
  intro_page,
  summary_page,
  first_page,
  second_page,
  third_page
)


# lint("app_ui.R")
# style_file("app_ui.R")
