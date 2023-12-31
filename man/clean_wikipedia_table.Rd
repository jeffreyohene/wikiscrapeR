% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_wikipedia_table.R
\name{clean_wikipedia_table}
\alias{clean_wikipedia_table}
\title{Clean Wikipedia Table Data}
\usage{
clean_wikipedia_table(table)
}
\arguments{
\item{table}{A data frame representing a table.}
}
\value{
A cleaned data frame with the first header row removed if it
contains all empty values.
}
\description{
This function cleans a table returned by get_wikipedia_tables by checking if
the first header row contains all
empty values and, if so, removes that header row.
}
