# Library imports
library("ggplot2")
library("dplyr")
library("tidyverse")

# import the tables:
wa_data_2 <- read.csv("https://drive.google.com/uc?export=download&id=1rOSIxDwHOdv0Z2yo_6vxJGaHQNrqVJxi")
king_asian_data <- read.csv("https://drive.google.com/uc?export=download&id=13JFnaN3hqnLI3eTluHEX_2r4sW8yIsde")
king_black_data <- read.csv("https://drive.google.com/uc?export=download&id=1Mq__cWrO1Vgocxg121-62BPtaWLeMxs8")
king_hispanic_data <- read.csv("https://drive.google.com/uc?export=download&id=1wrdNRBs2U63PLvDDgrTAZYFP9GtO0202")
king_native_data <- read.csv("https://drive.google.com/uc?export=download&id=1vkNeD2sOQynob5R6ua7oXxOepohpLVW9")
king_pacific_data <- read.csv("https://drive.google.com/uc?export=download&id=15VoJ4CN7Pnl1XB0dsMcp14-vaMWN1V4X")
king_twoplus_data <- read.csv("https://drive.google.com/uc?export=download&id=14tznF8F9S_RX6gYdwVm6o4JgqUYs0T5s")
king_other_data <- read.csv("https://drive.google.com/uc?export=download&id=1vfqDaBQrcHUYbAJJsMuz_tGmlWGUxRXs")
king_white_nonhispanic_data <- read.csv("https://drive.google.com/uc?export=download&id=1EWXFOx89j6WO7X4sejnv7DUsRMqlyYPu")
king_white_data <- read.csv("https://drive.google.com/uc?export=download&id=1AolYNhHYC_Vt9T4CBXSqZ8aIf9fwEnWY")
king_total_data <- read.csv("https://drive.google.com/uc?export=download&id=1VLUAA8vDQtg_RJLedd-SUlkGA7q2Kl0i")

king_pop_data_years <- wa_data_2 %>% filter(Area.Name == "King") %>% filter(Age.Group == "Total")
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

mean_all_race <- merge(mean_king_asian_data, mean_king_black_data, by = "Year") %>%
  merge(mean_king_hispanic_data, by = "Year") %>%
  merge(mean_king_native_data, by = "Year") %>%
  merge(mean_king_pacific_data, by = "Year") %>%
  merge(mean_king_twoplus_data, by = "Year") %>%
  merge(mean_king_other_data, by = "Year") %>%
  merge(mean_king_white_nonhispanic_data, by = "Year") %>%
  merge(mean_king_white_data, by = "Year") %>%
  merge(mean_king_total_data, by = "Year")

colnames(mean_all_race) <- c("Year", "Asian", "Asian_mean_salary", "Black", "Black_mean_salary", "Hispanic", "Hispanic_mean_salary", "Native", "Native_mean_salary", "Islander", "Islander_mean_salary", "Two", "Two_mean_salary", "Other", "Other_mean_salary", "White_not", "White_not_mean_salary", "White", "White_mean_salary", "Total", "Total_mean_salary")
aggregate_table <- mean_all_race %>% select("Year", "Asian_mean_salary", "Black_mean_salary", "Hispanic_mean_salary", "Native_mean_salary", "Islander_mean_salary", "Two_mean_salary", "Other_mean_salary", "White_not_mean_salary", "White_mean_salary", "Total_mean_salary")
king_pop_data_years <- king_pop_data_years %>% select("Year", "Total", "Male", "Female", "White.Total", "White.Male", "White.Female", "Black.Total", "Black.Male", "Black.Female", "AIAN.Total", "AIAN.Male", "AIAN.Female", "Asian.Total", "Asian.Male", "Asian.Female", "NHOPI.Total", "NHOPI.Male", "NHOPI.Female", "Two.or.More.Races.Total", "Two.or.More.Races.Male", "Two.or.More.Races.Female")
colnames(king_pop_data_years) <- c("Year", "Total.Pop", "Male.Pop", "Female.Pop", "White.Total.Pop", "White.Male.Pop", "White.Female.Pop", "Black.Total.Pop", "Black.Male.Pop", "Black.Female.Pop", "AIAN.Total.Pop", "AIAN.Male.Pop", "AIAN.Female.Pop", "Asian.Total.Pop", "Asian.Male.Pop", "Asian.Female.Pop", "NHOPI.Total.Pop", "NHOPI.Male.Pop", "NHOPI.Female.Pop", "Two.or.More.Races.Total.Pop", "Two.or.More.Races.Male.Pop", "Two.or.More.Races.Female.Pop")
aggregate_table <- merge(aggregate_table, king_pop_data_years, by = "Year")

aggregate_table
