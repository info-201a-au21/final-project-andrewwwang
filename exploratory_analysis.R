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
# Sarah - Change in Race Over Time

race_change <- wa_data_2 %>% 
  filter(Year == 2014 | Year == 2015) %>%
  filter(Total != ".") %>%
  filter(White.Total != ".") %>%
  filter(Black.Total != ".") %>%
  filter(Asian.Total != ".") %>%
  filter(AIAN.Total != ".") %>%
  filter(NHOPI.Total != ".") %>%
  filter(Two.or.More.Races.Total != ".") %>%
  group_by(Year) %>%
  summarise(total_pop_change = sum(Total, na.rm = T))

# only the summarise functions dont work everything after should work

(total_pop = sum(Total, na.rm = T)),
            total_white = sum(White.Total, na.rm = T),
            total_black = sum(Black.Total, na.rm = T),
            total_asian = sum(Asian.Total, na.rm = T),
            total_AIAN = sum(AIAN.Female, na.rm = T),
            total_NHOPI = sum(NHOPI.Total, na.rm = T),
            total_mixed = sum(Two.or.More.Races.Total, na.rm = T)) %>%
  mutate(total_pop_change = c(NA, diff(total_pop)),
         total_wht_change = c(NA, diff(total_white)),
         total_blk_change = c(NA, diff(total_black)),
         total_asn_change = c(NA, diff(total_asian)),
         total_AIAN_change = c(NA, diff(total_AIAN)),
         total_NHOPI_change = c(NA, diff(total_NHOPI)),
         total_mixed_change = c(NA, diff(total_mixed)))

