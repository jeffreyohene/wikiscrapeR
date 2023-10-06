#' Clean Wikipedia Table Data
#'
#' This function cleans a table returned by get_wikipedia_tables by checking if
#' the first header row contains all
#' empty values and, if so, removes that header row.
#'
#' @param table A data frame representing a table.
#'
#' @return A cleaned data frame with the first header row removed if it
#' contains all empty values.
#'
#' @export
clean_wikipedia_table <- function(table) {
  # Check if any column name matches "X" followed by one or more digits
  if (any(grepl("^X\\d+$", colnames(table)))) {


    colnames(table) <- table[1, ]

    # Check if all rows are empty in the data portion (excluding the header)
    data_rows <- table[-1, ]
    if (all(apply(data_rows, 1, function(row) all(is.na(row) | row == "")))) {

      table <- data_rows

    }
  }

  return(table)
}
