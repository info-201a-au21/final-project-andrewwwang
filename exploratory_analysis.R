# Library imports
library("ggplot2")
library("dplyr")
library("tidyverse")
library("here")

# import your data set using its local path on your computer. My example is below:
# wa_data_2 <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/washington_counties_2010_to_2020.csv")
# king_asian_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Asian.csv")
# king_black_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Black.csv")
# king_hispanic_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Hispanic.csv")
# king_native_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Native American.csv")
# king_pacific_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Pacific Islander.csv")
# king_twoplus_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Two Or More.csv")
# king_other_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Other.csv")
# king_white_nonhispanic_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location White Non-Hispanic.csv")
# king_white_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location White.csv")
# king_total_data <- read.csv("C:/Users/endur/OneDrive/Documents/GitHub/final-project-andrewwwang/data/Income By Race/Income by Location Total.csv")

# ------------------------------------------------------
# Andrew - Mean Household Income per race in King County

#king_county_data_years <- wa_data %>% filter(Area.Name == "King")
mean_king_asian_data <- king_asian_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_black_data <- king_black_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_hispanic_data <- king_hispanic_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_native_data <- king_native_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_pacific_data <- king_pacific_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_twoplus_data <- king_twoplus_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_other_data <- king_other_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_white_nonhispanic_data <- king_white_nonhispanic_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_white_data <- king_white_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))
mean_king_total_data <- king_total_data %>% group_by(Race, Year) %>% summarise(mean = mean(Household.Income.by.Race))

# ------------------------------------------------------