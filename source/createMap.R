# create lead maps

## dependencies
### tidyverse
library(dplyr)
library(ggplot2)
library(readr)

### mapping
library(ggthemes)
library(sf)

### other
library(prener)

## load data
city <- st_read("data/STL_BOUNDARY_City.shp", stringsAsFactors = FALSE)
tracts <- st_read("data/STL_DEMOS_Tracts.shp", stringsAsFactors = FALSE)
highway <- st_read("data/STL_TRANS_PrimaryRoads.shp", stringsAsFactors = FALSE)
lead <- read_csv("data/STL_HEALTH_Lead.csv",
                 col_types = cols(
                   geoID = col_character()
                 ))

## table join
map <- left_join(tracts, lead, by = c("GEOID" = "geoID"))

## base map
base <- ggplot() + 
  geom_sf(data = map, mapping = aes(fill = cut_number(pctElevated, n = 5, 
          labels = c("0.00 - 4.25", "4.25 - 7.45", "7.45 - 10.90", "10.90 - 16.00", "16.00 - 23.30"))),
          color = NA) + 
  geom_sf(data = highway, mapping = aes(color = "Highways"), size = 1.5, fill = NA) +
  geom_sf(data = city, fill = NA, color = "#000000", size = .25) +
  scale_fill_brewer(palette = "RdPu", name = "% Elevated") +
  scale_colour_manual(name="", values= "black") +
  labs(
    title = "High Blood Lead Level Tests",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters \nMap by Christopher Prener, Ph.D."
  ) 

## map 1 - ggplot2 theme
map1 <- base + 
  theme_gray(base_size = 24) + 
  theme(plot.caption = element_text(hjust = "0"))

cp_plotSave(filename = "results/maps/map01-default.png", plot = map1, preset = "lg", dpi = 500)

## map 2 - ggpthemes theme_map
map2 <- base + 
  theme_map(base_size = 24) + 
  theme(
    plot.background = element_rect(color = "white"),
    legend.position = "right",
    plot.caption = element_text(hjust = "0")
  ) 

cp_plotSave(filename = "results/maps/map02-clean_white.png", plot = map2, preset = "lg", dpi = 500)


## map 3 - ggpthemes theme_map with transparent background
map3 <- base + 
  theme_map(base_size = 24) + 
  theme(
    legend.background = element_rect(colour = NA, fill = NA),
    legend.position = "right",
    plot.caption = element_text(hjust = "0")
  ) 

cp_plotSave(filename = "results/maps/map03-clean_trans.png", plot = map3, preset = "lg", dpi = 500)
