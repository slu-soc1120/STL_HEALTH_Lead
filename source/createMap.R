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

## calculate jenks natural breaks
map <- cp_breaks(map, var = pctElevated, newvar = jenksElevated, classes = 5, style = "jenks")

## base map
base <- ggplot() + 
  geom_sf(data = map, mapping = aes(fill = jenksElevated), color = NA) + 
  geom_sf(data = highway, mapping = aes(color = "Highways"), size = 1.5, fill = NA) +
  geom_sf(data = city, fill = NA, color = "#000000", size = .25) +
  scale_fill_brewer(palette = "RdPu", name = "% Elevated",
                    labels = c("0.00 - 5.24", "5.25 - 8.82", "8.83 - 12.70", "12.71 - 17.70", "17.71 - 23.30")) +
  scale_colour_manual(name="", values= "black") +
  labs(
    title = "High Blood Lead Level Tests",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters \nMap by Christopher Prener, Ph.D."
  ) 

## map 1 - ggplot2 theme
map01 <- base + 
  theme_gray(base_size = 24) + 
  theme(plot.caption = element_text(hjust = "0"))

cp_plotSave(filename = "results/maps/leadMap-base.png", plot = map01, preset = "lg", dpi = 500)

## map 2 - sequoia theme with white background
map02 <- base + 
  cp_sequoiaTheme(background = "white", base_size = 24, map = TRUE)

cp_plotSave(filename = "results/maps/leadMap-white.png", plot = map02, preset = "lg", dpi = 500)


## map 3 - sequoia theme with transparent background
map03 <- base + 
  cp_sequoiaTheme(background = "transparent", base_size = 24, map = TRUE)
  
cp_plotSave(filename = "results/maps/leadMap-trans.png", plot = map03, preset = "lg", dpi = 500)
