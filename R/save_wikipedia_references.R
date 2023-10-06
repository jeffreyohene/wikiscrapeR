#' Save cleaned references to a text file.
#'
#' This function saves the cleaned references to a specified text file.
#'
#' @param references A character vector of cleaned references.
#' @param output_file The path to the output text file.
#'
#' @return NULL, but the cleaned references are saved to the specified file.
#'
#'
#' @export
save_wikipedia_references <- function(references, output_file) {

  # Save the cleaned references to the specified file
  cat(references, sep='\n', file=output_file)

  cat('References saved as:', output_file, '\n')
}
