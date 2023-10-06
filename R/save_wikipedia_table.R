#' Save a Data Frame to Various Formats
#'
#' This function saves a dataframe to different file formats, including CSV,
#' Excel (XLSX), TSV (Tab-Separated Values), and JSON. More formats may be
#' supported in the future.
#'
#' @param data_frame The dataframe to be saved.
#' @param file_name The name of the output file (without the file extension).
#' @param format The desired output format ('csv', 'xlsx', 'tsv', or 'json').
#'
#' @return NULL (file is saved to the specified location).
#'
#' @importFrom utils write.csv write.table install.packages installed.packages
#' @importFrom openxlsx write.xlsx
#' @importFrom jsonlite write_json
#'
#'
#' @export
save_wikipedia_table <- function(data_frame, file_name, format) {
  required_pkgs <- c('utils', 'openxlsx', 'jsonlite')
  missing_pkgs <- setdiff(required_pkgs, utils::installed.packages()[, 'Package'])

  if (length(missing_pkgs) > 0) {
    cat('The following required packages are missing:\n')
    cat(paste(missing_pkgs, collapse = ', '), '\n')

    install_missing <- tolower(readline('Do you want to install missing packages? (y/n): '))

    if (install_missing == 'y') {
      utils::install.packages(missing_pkgs)
    } else {
      message('Please install the required packages manually and then try again.')
      return(NULL)
    }
  }


  if (format %in% c('csv', 'xlsx', 'tsv', 'json')) {
    file_ext <- switch(
      format,
      csv = 'csv',
      xlsx = 'xlsx',
      tsv = 'tsv',
      json = 'json'
    )

    # Construct the file name with the appropriate extension
    file_name <- paste0(file_name, '.', file_ext)

    # Export the dataframe to the specified format
    switch(
      format,
      csv = utils::write.csv(data_frame, file_name, row.names = FALSE),
      xlsx = openxlsx::write.xlsx(data_frame, file_name),
      tsv = utils::write.table(data_frame, file_name, sep = '\t', row.names = FALSE),
      json = jsonlite::write_json(data_frame, file_name)
    )

    cat('- Dataframe saved successfully in', format, 'format.\n')
  } else {
    message('Error: Unsupported output format. Supported formats are \'.csv\',
            \'.xlsx\', \'.tsv\', and \'.json\'.
            More formats may be supported in the future.')
  }
}
