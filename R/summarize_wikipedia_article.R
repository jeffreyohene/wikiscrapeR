#' Summarize Wikipedia Article
#'
#' This function retrieves a summary of a Wikipedia page from an API
#' using the article's URL.
#'
#' @param url The URL of the Wikipedia page.
#'
#' @return A character vector containing the summary of the Wikipedia page.
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom utils install.packages installed.packages
#'
#'
#' @export
summarize_wikipedia_article <- function(url) {
  required_pkgs <- c('httr', 'jsonlite')
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

  # Extract the title from the URL
  title_match <- regmatches(url, regexpr('/wiki/([^/]+)', url))

  if (length(title_match) == 0) {
    cat('Error: Invalid Wikipedia URL.\n')
    return(NULL)
  }

  title <- sub('/wiki/', '', title_match)

  # Define the Wikipedia API endpoint
  base_url <- 'https://en.wikipedia.org/w/api.php'

  # Define parameters for the API request
  params <- list(
    action = 'query',
    format = 'json',
    titles = title,
    prop = 'extracts',
    exintro = '1',
    explaintext = '1'
  )

  # Make the API request
  response <- tryCatch({
    GET(url = base_url, query = params)
  }, error = function(e) {
    cat('Error: Unable to make the HTTP request.\n')
    return(NULL)
  })

  if (is.null(response)) {
    return(NULL)
  }

  # Parse the JSON response
  data <- content(response, 'text', encoding = 'UTF-8')
  parsed_data <- fromJSON(data)

  # Check if the 'query' key exists in the response
  if ('query' %in% names(parsed_data) && 'pages' %in% names(parsed_data$query)) {
    # Extract the page summary
    page_id <- as.character(names(parsed_data$query$pages))
    summary <- parsed_data$query$pages[[page_id]]$extract


    return(summary)
  } else {
    cat('Error: Unable to fetch Wikipedia page summary.\n')
    return(NULL)
  }
}
