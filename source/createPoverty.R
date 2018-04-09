# create lead and poverty scatterplot

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

## base scatterplot 
base <- ggplot(data = lead, mapping = aes(x = (povertyTot/totalPop)*100, y = pctElevated)) +
  geom_smooth(method = lm, se = FALSE, color = "#017a04", size = 2) +
  geom_point(color = "#7A0177", position = "jitter", size = 6) +
  geom_point(shape = 1, color = "black", size = 6) +
  labs(
    title = "High Blood Lead Level Tests and \nPoverty by Census Tract",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters \nPlot by Christopher Prener, Ph.D.",
    x = "% Under Federal Poverty Line",
    y = "% Elevated"
  ) 

## plot 1 - base theme
plot1 <- base +
  theme_gray(base_size = 28)

cp_plotSave(filename = "results/plots/scatter-poverty01-default.png", plot = plot1, preset = "lg", dpi = 500)

## plot 2 - sequoia theme
plot2 <- base +
  cp_sequoiaTheme()

cp_plotSave(filename = "results/plots/scatter-poverty02-prener.png", plot = plot2, preset = "lg", dpi = 500)
