first_page <- tabPanel(
  "Page 1",
  textInput(
    inputId = "textInput",
    label = h3("test text input"),
    placeholder = "enter text here"
  ),
  textOutput(
    outputId = "message"
  )
)

second_page <- tabPanel(
  "Page 2",
  textInput(
    inputId = "textInput",
    label = h3("test text input"),
    placeholder = "enter text here"
  ),
  textOutput(
    outputId = "message"
  )
)

third_page <- tabPanel(
  "Page 3",
  textInput(
    inputId = "textInput",
    label = h3("test text input"),
    placeholder = "enter text here"
  ),
  textOutput(
    outputId = "message"
  )
)

ui <- navbarPage(
  "Assignment 4", # title
  first_page, 
  second_page,
  third_page
)