Create Maps and Plots of High Blood Lead Level Rates
================
Christopher Prener, Ph.D.
(August 20, 2019)

## Introduction

This notebook creates maps and plots related to high blood lead level
rates in the City of St. Louis. One of the maps appears in Lecture-01
for my sections of SOC 1120.

## Packages

This notebook requires the following packages:

``` r
# tidyverse packages
library(dplyr)          # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)        # create plots
library(readr)          # read csv files

# spatial packages
library(ggthemes)       # base theme
library(sf)             # spatial data tools
```

    ## Linking to GEOS 3.6.1, GDAL 2.1.3, PROJ 4.9.3

``` r
library(RColorBrewer)   # color palettes

# other packages
library(here)           # manage file paths
```

    ## here() starts at /Users/chris/GitHub/slu-soc1120/STL_HEALTH_Lead

Two functions from the `source/` directory are also needed:

``` r
# plot theme
source(here("source", "cp_sequoiaTheme.R"))

# save plots
source(here("source", "cp_plotSave.R"))

# calculate breaks
source(here("source", "cp_breaks.R"))
```

## Load Data

All of the raw data for these plots were obtained from …

They are in separate `.csv` files that we’ll load individually:

``` r
# load spatial data
city <- st_read(here("data", "STL_BOUNDARY_City.shp"), stringsAsFactors = FALSE)
```

    ## Reading layer `STL_BOUNDARY_City' from data source `/Users/chris/GitHub/slu-soc1120/STL_HEALTH_Lead/data/STL_BOUNDARY_City.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 1 feature and 17 fields
    ## geometry type:  POLYGON
    ## dimension:      XY
    ## bbox:           xmin: -90.32052 ymin: 38.53185 xmax: -90.16657 ymax: 38.77443
    ## epsg (SRID):    NA
    ## proj4string:    +proj=longlat +ellps=GRS80 +no_defs

``` r
tracts <- st_read(here("data", "STL_DEMOS_Tracts.shp"), stringsAsFactors = FALSE)
```

    ## Reading layer `STL_DEMOS_Tracts' from data source `/Users/chris/GitHub/slu-soc1120/STL_HEALTH_Lead/data/STL_DEMOS_Tracts.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 106 features and 12 fields
    ## geometry type:  POLYGON
    ## dimension:      XY
    ## bbox:           xmin: -90.32052 ymin: 38.53185 xmax: -90.16657 ymax: 38.77443
    ## epsg (SRID):    NA
    ## proj4string:    +proj=longlat +ellps=GRS80 +no_defs

``` r
highway <- st_read(here("data", "STL_TRANS_PrimaryRoads.shp"), stringsAsFactors = FALSE)
```

    ## Reading layer `STL_TRANS_PrimaryRoads' from data source `/Users/chris/GitHub/slu-soc1120/STL_HEALTH_Lead/data/STL_TRANS_PrimaryRoads.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 9 features and 4 fields
    ## geometry type:  MULTILINESTRING
    ## dimension:      XY
    ## bbox:           xmin: -90.31897 ymin: 38.55184 xmax: -90.17253 ymax: 38.76759
    ## epsg (SRID):    4269
    ## proj4string:    +proj=longlat +datum=NAD83 +no_defs

``` r
# load tabular data
lead <- read_csv(here("data", "STL_HEALTH_Lead.csv"), 
                 col_types = cols(geoID = col_character()))
```

## Clean Data

First, we’ll tidy up the data so that it is ready for visualization:

``` r
lead_sf <- left_join(tracts, lead, by = c("GEOID" = "geoID"))
```

## Histogram

First, we’ll create a histogram of the distribution high blood level
rates across census tracts:

``` r
# create plot
plot <- ggplot() +
  geom_histogram(data = lead, mapping = aes(pctElevated), fill = "#7570B3", bins = 30) +
  labs(
    title = "High Blood Lead Level Tests by Census Tract",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters",
    x = "% Elevated"
  ) +
  cp_sequoiaTheme(background = "gray")

# save plot
cp_plotSave(here("results", "lead_histogram.png"), plot, preset = "lg", dpi = 500)
```

## Poverty and Lead Poisoning

Next, we’ll create a scatterplot of poverty and high blood lead level
rates:

``` r
# create plot
plot <- ggplot(data = lead, mapping = aes(x = (povertyTot/totalPop)*100, y = pctElevated)) +
  geom_smooth(method = lm, se = FALSE, color = "#D95F02", size = 2) +
  geom_point(color = "#1B9E77", position = "jitter", size = 6) +
  geom_point(shape = 1, color = "black", size = 6) +
  labs(
    title = "High Blood Lead Level Tests and \nPoverty by Census Tract",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters",
    x = "% Under Federal Poverty Line",
    y = "% Elevated"
  ) +
  cp_sequoiaTheme(background = "gray") 

# save plot
cp_plotSave(here("results", "lead_poverty.png"), plot, preset = "lg", dpi = 500)
```

## Race and Lead Poisoning

We’ll replicate the scatterplot, but use the percent of African
Americans as opposed to poverty:

``` r
# create plot
plot <- ggplot(data = lead, mapping = aes(x = (black/totalPop)*100, y = pctElevated)) +
  geom_smooth(method = lm, se = FALSE, color = "#017a04", size = 2) +
  geom_point(color = "#7570B3", position = "jitter", size = 6) +
  geom_point(shape = 1, color = "black", size = 6) +
  labs(
    title = "High Blood Lead Level Tests and \nRace by Census Tract",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters",
    x = "% African American",
    y = "% Elevated"
  ) +
  cp_sequoiaTheme(background = "gray") 

# save plot
cp_plotSave(here("results", "lead_race.png"), plot, preset = "lg", dpi = 500)
```

## Map

Finally, we’ll map these high blood lead level rates by census tracts:

``` r
# calculate jenks natural breaks
lead_sf <- cp_breaks(lead_sf, var = pctElevated, newvar = jenksElevated, classes = 5, style = "jenks")

#  map
plot <- ggplot() + 
  geom_sf(data = lead_sf, mapping = aes(fill = jenksElevated), color = NA) + 
  geom_sf(data = highway, mapping = aes(color = "Highways"), size = 1.5, fill = NA) +
  geom_sf(data = city, fill = NA, color = "#000000", size = .25) +
  scale_fill_brewer(palette = "RdPu", name = "% Elevated",
                    labels = c("0.00 - 5.24", "5.25 - 8.82", "8.83 - 12.70", "12.71 - 17.70", "17.71 - 23.30")) +
  scale_colour_manual(name="", values= "black") +
  labs(
    title = "High Blood Lead Level Tests",
    subtitle = "Children in St. Louis, MO (2010-2015)",
    caption = "Data via Reuters"
  ) +
  cp_sequoiaTheme(background = "transparent", map = TRUE)

# save plot
cp_plotSave(here("results", "lead_map.png"), plot, preset = "lg", dpi = 500)
```
