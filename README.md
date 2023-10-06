---
title: wikiscrapeR 1.0.0
---

![](https://img.icons8.com/carbon-copy/100/spiderweb.png)

`wikiscrapeR` is an R package that simplifies the process of working with 
Wikipedia data. It provides functionality to scrape tables, retrieve page 
summaries, and extract various types of information from Wikipedia pages.

### Installation

You can install `wikiscrapeR` directly from GitHub using `devtools`.
Ensure you have devtools installed before running the installation command.

```R
# How to install wikiscrapeR
install.packages('devtools')
devtools::install_github('jeffreyohene/wikiscrapeR')
```


### Usage

#### Scrape Wikipedia Tables

The `get_wikipedia_tables()` function extracts tables from a Wikipedia page, 
It fetches tables and captions, listing them for user selection. Users input 
the table number which is printed along with the table caption if available, 
and the chosen table is returned as a data frame. Limitations include 
reliance on 'wikitable' class formatting and potential issues with changing 
page structures, this will be addressed in future versions.

```R
library(wikiscrapeR)

# Define a Wikipedia URL from which to extract tables
wikipedia_url <- 'https://en.wikipedia.org/wiki/Example_Wikipedia_Page'

# Fetch tables from the Wikipedia page
wikipedia_tables <- get_wikipedia_tables(wikipedia_url)

# Select a specific table (e.g., the first table)
# User number input, 1, 2,3...

```

#### Clean Wikipedia Tables

The `clean_wikipedia_table()` function is a helper for the get_wikipedia_tables() 
function. It cleans Wikipedia tables by addressing specific issues. It renames 
unlabeled columns that are automatically labeled with "X" followed by digits 
`X1, X2, X3, X4, X5..` Its output is a cleaned table. The function improves the 
quality of tables obtained using get_wikipedia_tables() but is specific to 
those issues and may not handle all table cleaning needs. We are still testing
more pages and will expand this to add more helpful table cleaning functions

```R
# Create a sample table with 'X1' 'X2', and 'X3' headers
sample_table <- data.frame(
  X1 = c('A', 'B', 'C'),
  X2 = c(1, 2, 3),
  X3 = c(4, 5, 6)
)

# Print the original sample table
print(sample_table)

# Clean the sample table (empty header row removed)
cleaned_table <- clean_wikipedia_table(sample_table)

# Expected output:
#   A B C
# 1 1 4
# 2 2 5
# 3 3 6

```

#### Save Wikipedia Tables

The `save_wikipedia_table()` function allows you to save scraped tables in 
various formats. Formats supported now are json, csv, tsv and xlsx.

```R
# Define a Wikipedia URL from which to extract tables
wikipedia_url <- 'https://en.wikipedia.org/wiki/Example_Wikipedia_Page'

# Fetch tables from the Wikipedia page
wikipedia_tables <- get_wikipedia_tables(wikipedia_url)

# Select a specific table (e.g., the first table)
# selected_table - user table choice

# Save the table as CSV
save_wikipedia_table(selected_table, 'table_data', 'csv')

# You can also save the table in other formats, e.g., JSON, TSV, XLSX
# Example: save_wikipedia_table(selected_table, 'table_data', 'json')
```

#### Retrieve Page Summaries

The `summarize_wikipedia_article()` function extracts page summaries from 
Wikipedia URLs. The output is the text summary of the Wikipedia page url that 
was provided. 

```R
# Define a Wikipedia URL for the page you want to summarize
wikipedia_url <- 'https://en.wikipedia.org/wiki/Example_Wikipedia_Page'

# Get a summary of the Wikipedia page
summary <- summarize_wikipedia_article(wikipedia_url)

```

#### Extract References

The `get_wikipedia_references()` function extracts references from a Wikipedia page.
The function prints the first 15 references and offers the choice to print all 
references as a character vector. 

```R
# Define a Wikipedia URL for the page with references
wikipedia_url <- "https://en.wikipedia.org/wiki/Example_Wikipedia_Page"

# Get references from the Wikipedia page
references <- get_wikipedia_references(wikipedia_url)
```

#### Clean References
The `clean_wikipedia_references()` function cleans Wikipedia references by 
removing quotation marks and apostrophes. Its output is the cleaned references 
as a character vector.

```R
# Define a Wikipedia URL for a page with references
wikipedia_url <- 'https://en.wikipedia.org/wiki/UEFA_Champions_League'

# Get references from the Wikipedia page
references <- get_wikipedia_references(wikipedia_url)
# Expected Output
print(references)
 [1] "1. West Germany"                                                 
 [2] "2. East Germany"                                                 
 [3] "3. SR Serbia"                                                    
 [4] "4. \"Football's premier club competition\""                      
 [5] "5. UEFA"                                                         
 [6] "6. Archived"                                                     
 [7] "7. \"Clubs\""                                                    
 [8] "8. \"UEFA Europa League further strengthened for 2015–18 cycle\""
 [9] "9. \"UEFA Executive Committee approves new club competition\""   
[10] "10. \"Matches\""                                                 
[11] "11. \"Club competition winners do battle\""                      
[12] "12. \"FIFA Club World Cup\""                                     
[13] "13. FIFA"                                                        
[14] "14. \"European Champions' Cup\""                                 
[15] "15. Rec.Sport.Soccer Statistics Foundation"

# Clean the references using clean_wikipedia_references()
clean_wikipedia_references(references)
 clean_references(selected_references)
1. West Germany
2. East Germany
3. SR Serbia
4. Football's premier club competition
5. UEFA
6. Archived
7. Clubs
8. UEFA Europa League further strengthened for 2015–18 cycle
9. UEFA Executive Committee approves new club competition
10. Matches
11. Club competition winners do battle
12. FIFA Club World Cup
13. FIFA
14. European Champions' Cup
15. Rec.Sport.Soccer Statistics Foundation
```


#### Save References
`save_references()` is a helper function designed to save cleaned Wikipedia 
references as a text file. Given a character vector of cleaned references and 
an output file path, it writes the references to the specified file. This 
function can be used after obtaining and cleaning references using other 
functions. It uses the `cat()` function to write the references with newline 
separators, and it provides feedback by displaying the path where the 
references are saved. Typically, it's used in conjunction with the previous 
functions that fetch and preprocess Wikipedia references, allowing users to 
conveniently store the results as a text file for further analysis or 
documentation.

```R
# Get references from a Wikipedia page
wikipedia_url <- 'https://en.wikipedia.org/wiki/Example_Wikipedia_Page'
references <- get_wikipedia_references(wikipedia_url)

# Clean the references
cleaned_references <- clean_wikipedia_references(references)

# Specify the output file path with a .txt extension
output_file <- 'cleaned_references.txt'

# Save the cleaned references as a text file
save_references(cleaned_references, output_file)
```

### Contributing
If you would like to contribute to this project, please follow our [Contributing 
Guidelines](https://jeffreyohene.github.io/Contributions)

### Reporting Issues
We regularly monitor the packages' functions' performance and functionality and 
release updates as needed to ensure its reliability. If you encounter any 
issues or have suggestions for improvements, please don't hesitate to open an 
issue on our [GitHub repository](https://github.com/jeffreyohene/wikiscrapeR/issues) and provide as much detail as possible to help us understand and address the issue.

### License
This project is licensed under the MIT License - see the LICENSE file for 
details.


This package was created and is maintained by:
[Jeffrey Ohene](https://jeffreyohene.github.io/). 

You can reach out with any questions, feedback, or suggestions:
1. [Send an E-mail!](mailto:jeffrey.ohene@aol.com)
2. [LinkedIn](https://www.linkedin.com/in/jeffreyohene/)
3. [Twitter](https://twitter.com/jeffrstats)
