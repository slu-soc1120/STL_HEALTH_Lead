#' ggplot2 Theme for Sequoia Keynote Template
#'
#' @description \code{cp_sequoiaTheme} is built on top of the \code{ggthemes}
#' package. It makes specific design changes to the \code{theme_fivethirtyeight} so
#' that the theme blends in seamlessly with the Alt slides in my Sequoia template
#' for Apple's Keynote. Among the changes completed are matching backgrounds, an
#' altered legend position and direction, a much larger default font size.
#'
#' @usage cp_sequoiaTheme(base_size = 28, base_family = "sans",
#'     background = c("transparent", "white", "gray"), legend_size = 1.5, map = FALSE)
#'
#' @param base_size Base font size
#' @param base_family Base font family
#' @param background A choice of either transparent, white, or gray (gray available for plots only)
#' @param legend_size Size of the legend items (in centimeters)
#' @param map A logical scalar. Is the plot a map?
#'
#' @source \href{https://cran.r-project.org/web/packages/ggthemes/index.html}{\code{ggthemes} package} (\href{https://cran.r-project.org/web/licenses/GPL-2}{source code released under GPL-2 license})
#'
#' @importFrom ggthemes theme_foundation
#'
cp_sequoiaTheme <-function(base_size = 28, base_family = "sans", background = c("transparent", "white", "gray"), legend_size = 1.5, map = FALSE) {

  if (map == FALSE) {

    if (background == "gray"){

      (ggthemes::theme_foundation(base_size = base_size, base_family = base_family)
       + theme(
         line = element_line(colour = "black"),
         rect = element_rect(fill = '#F0F0F0', linetype = 0, colour = NA),
         text = element_text(colour = '#3C3C3C'),
         axis.title = element_text(),
         axis.text = element_text(),
         axis.ticks = element_blank(),
         axis.line = element_blank(),
         legend.background = element_rect(fill = '#EBEBEB'),
         legend.key = element_rect(fill = '#EBEBEB'),
         legend.key.size = unit(1.5, units="cm"),
         legend.position = "right",
         legend.direction = "vertical",
         legend.box = "vertical",
         panel.grid = element_line(colour = NULL),
         panel.grid.major =
           element_line(colour = '#D2D2D2'),
         panel.grid.minor = element_blank(),
         panel.background = element_rect(fill = '#EBEBEB'),
         plot.background = element_rect(fill = '#EBEBEB'),
         plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
         plot.margin = unit(c(1, 1, 1, 1), "lines"),
         plot.caption = element_text(hjust = "0"),
         strip.background = element_rect()))


    } else if (background == "white"){

      (ggthemes::theme_foundation(base_size = base_size, base_family = base_family)
       + theme(
         line = element_line(colour = "black"),
         rect = element_rect(fill = '#F0F0F0', linetype = 0, colour = NA),
         text = element_text(colour = '#3C3C3C'),
         axis.title = element_text(),
         axis.text = element_text(),
         axis.ticks = element_blank(),
         axis.line = element_blank(),
         legend.background = element_rect(fill = '#FFFFFF'),
         legend.key = element_rect(fill = '#FFFFFF'),
         legend.key.size = unit(1.5, units="cm"),
         legend.position = "right",
         legend.direction = "vertical",
         legend.box = "vertical",
         panel.grid = element_line(colour = NULL),
         panel.grid.major =
           element_line(colour = '#D2D2D2'),
         panel.grid.minor = element_blank(),
         panel.background = element_rect(fill = '#FFFFFF'),
         plot.background = element_rect(fill = '#FFFFFF'),
         plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
         plot.margin = unit(c(1, 1, 1, 1), "lines"),
         plot.caption = element_text(hjust = "0"),
         strip.background = element_rect()))

    } else if (background == "transparent"){

      (ggthemes::theme_foundation(base_size = base_size, base_family = base_family)
       + theme(
         line = element_line(colour = "black"),
         rect = element_rect(fill = '#F0F0F0', linetype = 0, colour = NA),
         text = element_text(colour = '#3C3C3C'),
         axis.title = element_text(),
         axis.text = element_text(),
         axis.ticks = element_blank(),
         axis.line = element_blank(),
         legend.background = element_rect(colour = NA, fill = NA),
         legend.key = element_blank(),
         legend.key.size = unit(1.5, units="cm"),
         legend.position = "right",
         legend.direction = "vertical",
         legend.box = "vertical",
         panel.grid = element_line(colour = NULL),
         panel.grid.major =
           element_line(colour = '#D2D2D2'),
         panel.grid.minor = element_blank(),
         panel.background = element_blank(),
         plot.background = element_blank(),
         plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
         plot.margin = unit(c(1, 1, 1, 1), "lines"),
         plot.caption = element_text(hjust = "0"),
         strip.background = element_rect()))

    }

  } else if (map == TRUE){

    if (background == "transparent"){

      (ggthemes::theme_foundation(base_size = base_size, base_family = base_family) +
        theme(
          line = element_line(colour = "black"),
          rect = element_rect(fill = NA, linetype = 1, colour = '#898989'),
          text = element_text(colour = '#3C3C3C'),
          axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          panel.background = element_blank(),
          panel.border = element_blank(),
          panel.grid = element_blank(),
          panel.spacing = unit(0, "lines"),
          plot.background = element_blank(),
          legend.justification = c(0, 0),
          legend.background = element_rect(colour = NA, fill = NA),
          legend.key.size = unit(legend_size, units="cm"),
          legend.position = "right",
          legend.direction = "vertical",
          legend.box = "vertical",
          plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
          plot.caption = element_text(hjust = "0")))

    } else if (background == "white"){

      (ggthemes::theme_foundation(base_size = base_size, base_family = base_family) +
        theme(
          line = element_line(colour = "black"),
          rect = element_rect(fill = NA, linetype = 1, colour = '#898989'),
          text = element_text(colour = '#3C3C3C'),
          axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          panel.background = element_rect(fill = '#FFFFFF', color = NA),
          panel.border = element_blank(),
          panel.grid = element_blank(),
          panel.spacing = unit(0, "lines"),
          plot.background = element_rect(fill = '#FFFFFF', color = NA),
          legend.justification = c(0, 0),
          legend.background = element_rect(fill = '#FFFFFF'),
          legend.key = element_rect(fill = '#FFFFFF'),
          legend.key.size = unit(legend_size, units="cm"),
          legend.position = "right",
          legend.direction = "vertical",
          legend.box = "vertical",
          plot.title = element_text(hjust = 0, size = rel(1.5), face = "bold"),
          plot.caption = element_text(hjust = "0")))

    }
  }
}
