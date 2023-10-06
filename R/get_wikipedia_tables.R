#' Scrape Wikipedia Tables and Choose One
#'
#' This function scrapes all tables with captions from a Wikipedia page
#' specified by its URL, lists them, and allows the user to select one.
#'
#' @param url The URL of the Wikipedia page.
#'
#' @return A dataframe representing the selected table, or NULL if no table
#' was selected.
#'
#' @importFrom rvest read_html html_node html_table
#' @importFrom purrr map compact
#' @importFrom utils install.packages installed.packages
# @importFrom tidyverse |>
#'
#'
#' @export
get_wikipedia_tables <- function(url) {
  required_pkgs <- c('rvest', 'purrr')
  missing_pkgs <- setdiff(required_pkgs, installed.packages()[, 'Package'])

  if (length(missing_pkgs) > 0) {
    cat('The following required packages are missing:\n')
    cat(paste(missing_pkgs, collapse = ', '), '\n')

    install_missing <- tolower(readline('Do you want to install missing packages? (y/n): '))

    if (install_missing == 'y') {
      install.packages(missing_pkgs)
    } else {
      message('Please install the required packages manually and then try again.')
      return(NULL)
    }
  }

  tryCatch({
    # Fetch the page
    page <- rvest::read_html(url)

    # Extract all tables from the page along with their captions
    table_data <- page |>
      rvest::html_nodes('table.wikitable') |>
      purrr::map(function(table) {
        caption <- rvest::html_node(table, 'caption')
        if (!is.null(caption)) {
          caption_text <- rvest::html_text(caption)
          table_data <- rvest::html_table(table)
          list(caption_text = caption_text, table_data = table_data)
        } else {
          NULL
        }
      }) |>
      purrr::compact()

    if (length(table_data) == 0) {
      message('Warning: No tables found on this page.')
      return(NULL)
    }

    # List table captions and ask the user to choose one
    cat('Tables on the page:\n')
    for (i in seq_along(table_data)) {
      cat('Table', i, ': ', table_data[[i]]$caption_text, '\n')
    }

    table_choice <- as.numeric(readline('Which table would you like to scrape? Enter the table number: '))

    if (table_choice < 1 || table_choice > length(table_data)) {
      message('Error: Invalid table number.')
      return(NULL)
    }

    selected_table <- table_data[[table_choice]]$table_data

    return(selected_table)

  }, error = function(e) {
    if (grepl('404 Not Found', conditionMessage(e))) {
      message('Error: Page not found.')
    } else {
      message('Error: Unable to retrieve tables.')
    }

    return(NULL)
  })
}
