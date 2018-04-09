# create lead histogram

## dependencies
### tidyverse
library(dplyr)
library(ggplot2)
library(readr)

### other
library(prener)

## load data
lead <- read_csv("data/STL_HEALTH_Lead.csv",
                 col_types = cols(
                   geoID = col_character()
                 ))

## base histogram
base <- ggplot() +
  geom_histogram(data = lead, mapping = aes(pctElevated), fill = "#7A0177", bins = 30) +
  labs(
    title = "High Blood Lead Level Tests by Census Tract",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters \nPlot by Christopher Prener, Ph.D.",
    x = "% Elevated"
  ) 

## plot 1 - base theme
plot1 <- base +
  theme_gray(base_size = 28)

cp_plotSave(filename = "results/plots/histogram01-default.png", plot = plot1, preset = "lg", dpi = 500)

## plot 2 - sequoia theme
plot2 <- base +
  cp_sequoiaTheme()

cp_plotSave(filename = "results/plots/histogram02-prener.png", plot = plot2, preset = "lg", dpi = 500)
