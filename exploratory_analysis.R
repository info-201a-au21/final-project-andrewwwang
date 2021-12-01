# Library imports
library("ggplot2")
library("dplyr")
library("tidyverse")

# import the tables:
housing_prices <- read.csv("https://drive.google.com/uc?export=download&id=13YmSnSbW9oZ6kmRD5bsbq3oDi2Z_Swf8")
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
gender_data <- read.csv("data/Wage by Gender in Common Jobs.csv")
poverty_data <- read.csv("data/Poverty by Race and Ethnicity.csv")

# ------------------------------------------------------
# Mean Household Income per race in King County

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
# Change in Race Over Time

race_change <- wa_data_2 %>% 
  filter(Year != ".") %>%
  filter(Total != ".") %>%
  filter(White.Total != ".") %>%
  filter(Black.Total != ".") %>%
  filter(Asian.Total != ".") %>%
  filter(AIAN.Total != ".") %>%
  filter(NHOPI.Total != ".") %>%
  filter(Two.or.More.Races.Total != ".") %>%
  mutate(numeric_total = as.numeric(sub(" ", "", Total, fixed = TRUE)),
         numeric_white = as.numeric(sub(" ", "", White.Total, fixed = TRUE)),
         numeric_black = as.numeric(sub(" ", "", Black.Total, fixed = TRUE)),
         numeric_asian = as.numeric(sub(" ", "", Asian.Total, fixed = TRUE)),
         numeric_AIAN = as.numeric(sub(" ", "", AIAN.Total, fixed = TRUE)),
         numeric_NHOPI = as.numeric(sub(" ", "", NHOPI.Total, fixed = TRUE)),
         numeric_mixed = as.numeric(sub(" ", "", Two.or.More.Races.Total, fixed = TRUE))) %>%
  group_by(Year) %>%
  summarise(total_pop = sum(numeric_total, na.rm = T),
            total_white = sum(numeric_white, na.rm = T),
            total_black = sum(numeric_black, na.rm = T),
            total_asian = sum(numeric_asian, na.rm = T),
            total_AIAN = sum(numeric_AIAN, na.rm = T),
            total_NHOPI = sum(numeric_NHOPI, na.rm = T),
            total_mixed = sum(numeric_mixed, na.rm = T)) %>%
  mutate(total_pop_change = c(NA, diff(total_pop)),
       total_wht_change = c(NA, diff(total_white)),
       total_blk_change = c(NA, diff(total_black)),
       total_asn_change = c(NA, diff(total_asian)),
       total_AIAN_change = c(NA, diff(total_AIAN)),
       total_NHOPI_change = c(NA, diff(total_NHOPI)),
       total_mixed_change = c(NA, diff(total_mixed)))

# ------------------------------------------------------
# Change in income per race

income_change_white <- mutate(mean_king_white_data, c(NA, diff(mean)))
income_change_black <- mutate(mean_king_black_data, c(NA, diff(mean)))
income_change_asian <- mutate(mean_king_asian_data, c(NA, diff(mean)))
income_change_hispanic <- mutate(mean_king_hispanic_data, c(NA, diff(mean)))
income_change_pacific <- mutate(mean_king_pacific_data, c(NA, diff(mean)))
income_change_twoplus <- mutate(mean_king_twoplus_data, c(NA, diff(mean)))
income_change_other <- mutate(mean_king_other_data, c(NA, diff(mean)))
income_change_white_nonhispanic <- mutate(mean_king_white_nonhispanic_data, c(NA, diff(mean)))
income_change_total <- mutate(mean_king_total_data, c(NA, diff(mean)))

# ------------------------------------------------------
# Average difference in wage between males and females of similar occupation

# Average income by gender and occupation
avg_income_gender <- gender_data %>%
  group_by(Gender, Detailed.Occupation) %>%
  summarize(mean_wage = mean(Average.Wage))

# Splitting into male only
male_only <- subset(avg_income_gender, Gender == "Male")

# Splitting into male only
female_only <- subset(avg_income_gender, Gender == "Female")

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

# ------------------------------------------------------
# Race with the highest percentage in poverty

# Average poverty percentage across years
poverty_by_race <- poverty_data %>%
  group_by(Race) %>%
  summarize(mean_percent = round(mean(share), 2))

# Race with highest percentage of poverty
highest_poverty_rate <- poverty_by_race %>%
  filter(mean_percent == max(mean_percent)) %>%
  pull(Race)
