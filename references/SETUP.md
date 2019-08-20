# template Setup
The following packages are required for this repo. Base `R` packages are not included here since they are pre-installed.

## First Steps

1. Ensure that `R` is up to date - you can download it [here](https://cloud.r-project.org)
2. Ensure that RStudio is up to date - you can download it [here](https://www.rstudio.com/products/rstudio/download/#download)

## Packages
### Quick Start
The following syntax can be copied into your console to quickly get up and running with this repo:

```
install.packages(c("tidyverse", "here", "knitr", "rmarkdown"))
```

### Tidyverse Packages
*These are most easily installed by installing the entire tidyverse.*

* `dplyr` - tools for data wrangling
* `ggplot2` - tools for plotting
* `readr` - reading `.csv` files

### Literate Programming
*These will not be referred to directly during the session but are needed for the notebook to work correctly.*

* `knitr` - create documents from R notebooks
* `rmarkdown` - write in Markdown syntax

### Other Packages

* `here` - easy file path management
