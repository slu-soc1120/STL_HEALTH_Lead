#' Saving Plots at Pre-specified Size and Resolution
#'
#' This function is a wrapper around \code{ggsave()} that uses pre-specified values which
#' correspond to the possible graphics sizes in my lecture and presentation slides.
#'
#' @usage cp_plotSave(filename, plot, device = "png", preset = c("sm", "med", "lg"), dpi = 300)
#'
#' @param filename File name to create on disk; must be quoted
#' @param plot Plot to save, defaults to last plot displayed if no plot included
#' @param device Device to use. Can be either be a device function (e.g. \code{png}),
#'     or one of "eps", "ps", "tex" (pictex), "pdf", "jpeg", "tiff", "png", "bmp",
#'     "svg" or "wmf" (windows only).
#' @param preset Preset size ("sm", "med", "lg")
#' @param dpi Dots per inch for plot
#'
#' @return Saves a file to the disk in the pre-determined size. \code{preset = "sm"}
#'
#' @importFrom ggplot2 last_plot
#' @importFrom ggplot2 ggsave
#'
cp_plotSave <- function(filename, plot, device = "png", preset = c("sm", "med", "lg"), dpi = 300){

  # identify plot object
  if (missing(plot)) {
    plotDef <- ggplot2::last_plot()
  } else {
    plotDef <- plot
  }

  # set small as default preset
  if (missing(preset)){
    preset <- "sm"
  }

  # save plot
  if (preset == "sm"){

    ggplot2::ggsave(filename, plotDef, device = device,
               width = 960 * 0.352778,
               height = 540 * 0.352778,
               units = "mm", dpi = dpi,
               bg = "transparent")

  } else if (preset == "med"){

    ggplot2::ggsave(filename, plotDef, device = device,
               width = 960 * 0.352778,
               height = 630 * 0.352778,
               units = "mm", dpi = dpi,
               bg = "transparent")

  } else if (preset == "lg"){

    ggplot2::ggsave(filename, plotDef, device = device,
               width = 1024 * 0.352778,
               height = 768 * 0.352778,
               units = "mm", dpi = dpi,
               bg = "transparent")

  }
}
