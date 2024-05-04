# Install required rpackages
install.packages("tidyverse")  # For data manipulation and visualization
install.packages("httr")       # For working with HTTP
install.packages("rvest")      # For web scraping
install.packages("jsonlite")   # For JSON parsing, if API returns JSON
install.packages("dplyr")      # For data wrangling
install.packages("janitor")   # For data cleaning

# Load required libraries
library(tidyverse)
library(httr)
library(rvest)
library(jsonlite)
library(dplyr)
library(janitor)

# Set the URL for data access
url <- "https://sos.ga.gov/election-data-hub"

# Example: Download a CSV file directly if available
data <- read_csv(url("https://sos.ga.gov/path/to/data.csv")) %>%
        clean_names()

# If data needs to be scraped from an HTML page
web_page <- read_html(url)

data <- web_page %>%
        html_nodes("css_selector_of_the_data_table") %>%
        html_table()  %>%
        clean_names()

# Example of data manipulation using dplyr
analysis <- data %>%
            filter(State %in% "Georgia") %>%
            group_by(voter_age_group, voter_registration_status) %>%
            summarise(count = n(), .groups = 'drop')

# Example of data visualization using ggplot2
ggplot(analysis, aes(x = voter_age_group, y = count, fill = voter_registration_status)) +
  geom_col(position = "dodge") +
  theme_minimal() +
  labs(title = "Voter Analysis in Georgia", x = "Age Group", y = "Number of Voters")
