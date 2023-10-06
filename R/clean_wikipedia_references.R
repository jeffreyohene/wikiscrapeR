#' Clean Wikipedia References
#'
#' This function cleans a character vector of references by removing
#' unnecessary characters such as quotation marks and apostrophes.
#'
#' @param references A character vector of references.
#'
#' @return Null but a message is printed to the console with cleaned references.
#'
#'
#' @export

clean_wikipedia_references <- function(references) {

  cleaned_references <- gsub('^"(.*)"$', '\\1', references)
  cleaned_references <- gsub('["]', '', cleaned_references)

  return(cat(cleaned_references, sep='\n'))
}
