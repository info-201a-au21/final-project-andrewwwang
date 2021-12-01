library("tidyverse")
library("ggplot2")
library("lintr")
library("styler")
library("mapproj")

gender_data <- read.csv("data/Wage by Gender in Common Jobs.csv")

# Average income by gender and occupation
avg_income_gender <- gender_data %>%
  group_by(Gender, Detailed.Occupation) %>%
  summarize(mean_wage = mean(Average.Wage))

# Splitting into male only
male_only <- subset(avg_income_gender, Gender == "Male")

# Splitting into male only
female_only <- subset(avg_income_gender, Gender == "Female")

# Rejoin data
merged_data <- merge(male_only, female_only, by = "Detailed.Occupation")

# Finding average wage for male workers
male_avg <- male_only %>%
  summarize(mean = mean(mean_wage)) %>%
  pull(mean)

# Finding average wage for male workers
female_avg <- female_only %>%
  summarize(mean = mean(mean_wage)) %>%
  pull(mean)

# Average difference in wage
difference_in_wage_between_genders <- male_avg - female_avg

# Creating scatterplot for data
avg_income <- ggplot(merged_data, aes(color = Detailed.Occupation)) +
  geom_point(aes(
    x = mean_wage.x,
    y = mean_wage.y
  )) +
  labs(
    title = "Average Wage For Female and Male Workers For Same Occupation",
    x = "Male Wage (USD)",
    y = "Female Wage (USD)"
  )

avg_income

# lint("difference_in_wage_by_gender.R")
# style_file("difference_in_wage_by_gender.R")
