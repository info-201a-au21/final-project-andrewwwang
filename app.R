# shiny app file

# Shiny library
# install.packages("shiny")
library("shiny")

# Execute app_server.R and app_ui.R
source("app_server.R")
source("app_ui.R")

# Create shinyApp()
shinyApp(ui = ui, server = server)

