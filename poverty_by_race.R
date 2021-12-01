library("tidyverse")
library("ggplot2")
library("lintr")
library("styler")
library("mapproj")

poverty_data <- read.csv("data/Poverty by Race and Ethnicity.csv")

# Average poverty percentage across years
poverty_by_race <- poverty_data %>%
  group_by(Race) %>%
  summarize(mean_percent = round(mean(share), 2))

highest_poverty_rate <- poverty_by_race %>%
  filter(mean_percent == max(mean_percent)) %>%
  pull(Race)

# Creating bar chart for data
bar_plot <- ggplot(data=poverty_by_race, aes(x=Race, y=mean_percent)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=mean_percent), vjust=-0.3, size=3.5) +
  theme_minimal() + 
  labs(
    title = "Percentage of Race in Poverty in King County",
    x = "Races & Ethnicities",
    y = "Percentage of Race in Poverty"
  )

bar_plot

lint("difference_in_wage_by_gender.R")
style_file("difference_in_wage_by_gender.R")
