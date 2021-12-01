library("ggplot2")
library("dplyr")
library("tidyverse")
library("maps")
library("mapdata")
library("stringr")
library("ggmap")
library("mapproj")

housing_prices <- read.csv("https://drive.google.com/uc?export=download&id=13YmSnSbW9oZ6kmRD5bsbq3oDi2Z_Swf8")

states_loc <- map_data("state")
counties_loc <- map_data("county")
wash_loc_data <- states_loc %>% filter(region == "washington")
wash_county <- counties_loc %>% filter(region == "washington") %>% filter(subregion == "king")

# Draw the state
washington <- ggplot(data = wash_loc_data, aes(x = long, y = lat, group = group)) + 
  coord_map() + 
  geom_polygon(color = "black", fill = "gray") 
washington

# Remove axis titles, background and grids for minimalistic look
minimalistic_theme <- theme(
  axis.line = element_blank(), 
  axis.text = element_blank(), 
  axis.ticks = element_blank(), 
  plot.background = element_blank(),
  panel.grid = element_blank(), 
  panel.border = element_blank(),
  axis.title = element_blank(),
)

# Draw the map setting the `fill` of each state
washington_housing_map <- washington + 
  geom_polygon(data = housing_prices, aes(fill = prices), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  scale_fill_gradientn(colours = rev(rainbow(7))) +
  labs(title="Housing Prices",
       subtitle="Washington, 2014-2015") +
  theme_bw() + minimalistic_theme

washington_housing_map

