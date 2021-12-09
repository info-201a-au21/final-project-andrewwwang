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

third_page <- tabPanel(
  "Page 3",
  textInput(
    inputId = "textInput3",
    label = h3("test text input"),
    placeholder = "enter text here"
  ),
  textOutput(
    outputId = "message3"
  )
)

ui <- navbarPage(
  "Poverty Rates", # title
  first_page, 
  second_page,
  third_page
)