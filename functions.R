
#loads core tidyverse package
library(tidyverse) #loads multiple packages (see https://tidyverse.tidyverse.org/)

#core tidyverse packages loaded:
# ggplot2, for data visualisation. https://ggplot2.tidyverse.org/
# dplyr, for data manipulation. https://dplyr.tidyverse.org/
# tidyr, for data tidying. https://tidyr.tidyverse.org/
# readr, for data import. https://readr.tidyverse.org/
# purrr, for functional programming. https://purrr.tidyverse.org/
# tibble, for tibbles, a modern re-imagining of data frames. https://tibble.tidyverse.org/
# stringr, for strings. https://stringr.tidyverse.org/
# forcats, for factors. https://forcats.tidyverse.org/
# lubridate, for date/times. https://lubridate.tidyverse.org/

#also loads the following packages (less frequently used):
# Working with specific types of vectors:
#     hms, for times. https://hms.tidyverse.org/
# Importing other types of data:
#     feather, for sharing with Python and other languages. https://github.com/wesm/feather
#     haven, for SPSS, SAS and Stata files. https://haven.tidyverse.org/
#     httr, for web apis. https://httr.r-lib.org/
#     jsonlite for JSON. https://arxiv.org/abs/1403.2805
#     readxl, for .xls and .xlsx files. https://readxl.tidyverse.org/
#     rvest, for web scraping. https://rvest.tidyverse.org/
#     xml2, for XML. https://xml2.r-lib.org/
# Modelling
#     modelr, for modelling within a pipeline. https://modelr.tidyverse.org/
#     broom, for turning models into tidy data. https://broom.tidymodels.org/

# Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors




#setting viridis theme for colors
scale_colour_continuous <- scale_colour_viridis_c
scale_colour_discrete   <- scale_colour_viridis_d
scale_colour_binned     <- scale_colour_viridis_b
#setting viridis theme for fill
scale_fill_continuous <- scale_fill_viridis_c
scale_fill_discrete   <- scale_fill_viridis_d
scale_fill_binned     <- scale_fill_viridis_b




#function to save csv files in a directory. If directory does not exist, creates it
f_save_csv_files <- function(file_to_save, output_path, file_name){
  
  # Create the directory recursively if it doesn't exist
  if (!file.exists(output_path)) {
    dir.create(output_path, recursive = TRUE)
  }
  
  # Write the CSV file
  write_csv(file_to_save, file = file.path(output_path, file_name))
}

f_get_urls_to_process <- function(csv_file, all_version, nb_urls_to_process, column_versions){
  
  # Check if the CSV file exists and load processed Versions
  if (file.exists(csv_file)) {
    processed_data <- read_csv(csv_file)
    processed_versions <- unique(processed_data[[column_versions]])
  } else {
    #otherwise get an empty version vector
    processed_versions <- character(0)
  }
  
  # Identify unprocessed Versions
  versions_to_process <- setdiff(all_version[[column_versions]], processed_versions)
  
  #only get a subset of the unprocessed version
  versions_to_process <- head(versions_to_process, nb_urls_to_process)
  
  return(versions_to_process)
  
}

f_get_html_page <- function(version_url){
  
  # Get the HTML page and parse it
  response <- GET(url, user_agent("Mozilla/5.0"))
  doc <- content(response, as = "parsed", encoding = "UTF-8")
  
  return(doc)
}