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

# ------------------------------------------------------
# Time Chart to visualize disparities
mean_race_salaries <- ggplot(mean_all_race) + 
  geom_line(aes(Year, Asian_mean_salary, colour = "Asian")) + 
  geom_line(aes(Year, Black_mean_salary, colour = "Black")) + 
  geom_line(aes(Year, Hispanic_mean_salary, colour = "Hispanic")) + 
  geom_line(aes(Year, Native_mean_salary, colour = "Native American")) +
  geom_line(aes(Year, Islander_mean_salary, colour = "Pacific Islander")) +
  geom_line(aes(Year, Two_mean_salary, colour = "Two or plus")) +
  geom_line(aes(Year, Other_mean_salary, colour = "Other")) +
  geom_line(aes(Year, White_mean_salary, colour = "White")) +
  geom_line(aes(Year, White_not_mean_salary, colour = "White non-Hispanic")) +
  geom_line(aes(Year, Total_mean_salary, colour = "Total")) +
  xlab("Year") + ylab("Dollars (USD)") + 
  scale_color_manual(name = "Legend", values = c("Asian" = "yellow", "Black" = "black", "Hispanic" = "brown", "Native American" = "red", "Pacific Islander" = "orange", "Two or plus" = "grey", "Other" = "blue", "White" = "pink", "White non-Hispanic" = "purple", "Total" = "cyan")) +
  ggtitle("Mean Race Salaries over Time in King County")
mean_race_salaries
