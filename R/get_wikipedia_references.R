#' Get Wikipedia References
#'
#' This function scrapes and displays references from a valid Wikipedia page.
#'
#' @param url The URL of the Wikipedia page.
#'
#' @return A character vector of formatted references.
#'
#'
#' @importFrom rvest read_html html_nodes html_text
#' @importFrom stats na.omit
#' @importFrom utils install.packages installed.packages
# @importFrom tidyverse |>
#'
#'
#' @export
get_wikipedia_references <- function(url) {
  required_pkg <- 'rvest'
  if (!requireNamespace(required_pkg, quietly = TRUE)) {
    cat('The required package', required_pkg, 'is missing. Do you want to install it? (y/n): ')
    install_missing <- tolower(readline())

    if (install_missing == 'y') {
      utils::install.packages(required_pkg)
    } else {
      message('Please install the required package "', required_pkg, '" manually and then try again.')
      return(NULL)
    }
  }

  # Read the HTML content of the Wikipedia page
  page <- rvest::read_html(url)

  # Extract the references using the "reference text" class
  references <- page |>
    rvest::html_nodes("span.reference-text a") |>
    rvest::html_text()

  # Remove empty and duplicate references
  references <- unique(stats::na.omit(references))

  formatted_references <- sapply(seq_along(references), function(i) {
    paste(i, ". ", references[i], sep = "")
  })

  # Print the first 15 references
  cat(formatted_references[1:15], sep = "\n")
  cat("\n")

  # Ask to print all references
  print_all <- tolower(readline("Do you want to print all references? (y/n): "))

  if (print_all == "y") {
    return(formatted_references)
  } else {
    return(formatted_references[1:15])
  }
}
