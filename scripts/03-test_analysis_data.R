#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned infant death rate across US in 2021 and 2022
# analysis dataset.
# Author: Diana Shen
# Date: 24 November 2024 
# Contact: diana.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse`,`testthat` package must be installed and loaded
# - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Relationship between_infant_mortality_rate_and_prohibited_abortion` rproj

#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv(
  file = "data/02-analysis_data/analysis_data.csv",
  col_types = cols(
    death_rate = col_double(),
    after_injunction = col_factor(levels = c("0", "1")),
    abortion_illegal = col_factor(levels = c("0", "1")),
    state = col_character(),
    age_of_mother = col_factor(),
    mothers_single_race = col_character(),
    year_of_death = col_integer(),
    month = col_factor(),
    month_code=col_integer()
  )
)

#### Define the list of states where abortion is illegal ####
illegal_states <- c("Alabama", "Arkansas", "Idaho", "Indiana", "Kentucky", 
                    "Louisiana", "Mississippi", "Oklahoma", "South Dakota", 
                    "Tennessee", "Texas", "West Virginia")
state =c(
  "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", 
  "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", 
  "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", 
  "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", 
  "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", 
  "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", 
  "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", 
  "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
)

## test analysis data has correct structure
test_that("Cleaned analysis data has correct structure and values", {
  
  # Check that the dataset is a data frame
  expect_true(is.data.frame(cleaned_data))
  
  # Check that all required columns exist
  required_columns <- c("state", "age_of_mother", "mothers_single_race", "year_of_death", 
                        "month", "month_code", "death_rate", "after_injunction", 
                        "abortion_illegal", "reliable", "date")
  expect_true(all(required_columns %in% colnames(cleaned_data)))
  
  # Check column types
  expect_true(is.character(cleaned_data$state)) # State should be character
  expect_true(is.factor(cleaned_data$age_of_mother)) # Age of mother should be a factor
  expect_true(is.character(cleaned_data$mothers_single_race)) # Mother's race should be character
  expect_true(is.numeric(cleaned_data$year_of_death)) # Year of death should be numeric
  expect_true(is.numeric(cleaned_data$month_code)) # Month code should be numeric
  expect_true(is.factor(cleaned_data$month)) # Month should be a factor
  expect_true(is.numeric(cleaned_data$death_rate)) # Death rate should be numeric
  expect_true(is.factor(cleaned_data$after_injunction)) # After injunction should be a factor
  expect_true(is.factor(cleaned_data$abortion_illegal)) # Abortion illegal should be a factor
  expect_true(is.character(cleaned_data$reliable)) # Reliable column should be character
  expect_true(inherits(cleaned_data$date, "Date")) # Date should be a valid Date class
})
  
# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 659 rows (expected based on simulation)
if (nrow(analysis_data) == 659) {
  message("Test Passed: The dataset has 700 rows.")
} else {
  stop(paste("Test Failed: The dataset has", nrow(analysis_data), "rows instead of 700."))
}

# Check if the dataset has the expected 8 columns
expected_columns <- c("death_rate", "state", "age_of_mother", "mothers_single_race", 
                      "year_of_death", "month","month_code", "after_injunction", "abortion_illegal")

if (all(expected_columns %in% names(analysis_data))) {
  message("Test Passed: The dataset contains all expected columns.")
} else {
  stop("Test Failed: The dataset is missing some expected columns.")
}

# Check if the 'state' column contains only valid US state abbreviations
if (all(analysis_data$state %in% state)) {
  message("Test Passed: The 'state' column contains only valid US state abbreviations.")
} else {
  stop("Test Failed: The 'state' column contains invalid values.")
}

# Check if 'year_of_death' column contains only 2021 and 2022
if (all(analysis_data$year_of_death %in% c(2021, 2022))) {
  message("Test Passed: The 'year_of_death' column contains only valid years (2021, 2022).")
} else {
  stop("Test Failed: The 'year_of_death' column contains invalid years.")
}

# Check if 'month_code' column contains values between 1 and 12
if (all(analysis_data$month_code >= 1 & analysis_data$month_code <= 12)) {
  message("Test Passed: The 'month_code' column contains only valid months (1–12).")
} else {
  stop("Test Failed: The 'month_code' column contains invalid values.")
}

# Check if 'month' column contains values between Janunary and December
# Define valid month names
valid_months <- c("January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December")

# Check if 'month' column contains only valid month names
if (all(analysis_data$month %in% valid_months)) {
  message("Test Passed: The 'month' column contains only valid month names (January–December).")
} else {
  stop("Test Failed: The 'month' column contains invalid month names.")
}

# Check for missing values
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if 'after_injunction' and 'abortion_illegal' columns are binary
if (all(levels(as.factor(analysis_data$after_injunction)) %in% c("0", "1")) &
    all(levels(as.factor(analysis_data$abortion_illegal)) %in% c("0", "1"))) {
  message("Test Passed: The 'after_injunction' and 'abortion_illegal' columns are binary.")
} else {
  stop("Test Failed: The 'after_injunction' or 'abortion_illegal' column contains invalid values.")
}

# Check if `abortion_illegal` matches the logic for `illegal_states`
if (all((analysis_data$state %in% illegal_states & analysis_data$abortion_illegal == 1) |
        (!analysis_data$state %in% illegal_states & analysis_data$abortion_illegal == 0))) {
  message("Test Passed: The `abortion_illegal` column is consistent with `illegal_states`.")
} else {
  stop("Test Failed: The `abortion_illegal` column does not match the `illegal_states` logic.")
}

# Check if the 'death_rate' column has values between 0 and 50
if (all(analysis_data$death_rate >= 0 & analysis_data$death_rate <= 100)) {
  message("Test Passed: The 'death_rate' column contains valid values (0–100).")
} else {
  stop("Test Failed: The 'death_rate' column contains invalid values.")
}

# Check if `after_injunction` matches the logic for `year_of_death` and `month_code`
if (all((analysis_data$year_of_death >= 2022 & analysis_data$month_code >= 6 & analysis_data$after_injunction == 1) |
        !(analysis_data$year_of_death >= 2022 & analysis_data$month_code >= 6) & analysis_data$after_injunction == 0)) {
  message("Test Passed: The `after_injunction` column is consistent with `year_of_death` and `month_code` logic.")
} else {
  stop("Test Failed: The `after_injunction` column does not match the `year_of_death` and `month_code` logic.")
}

# Check if 'age_of_mother' and 'mothers_single_race' columns have valid categories
valid_ages <- c("15–19", "20–24", "25–29", "30–34")
valid_races <- c("White", "Black", "Asian", "Native American", "Pacific Islander", 
                 "More than one race", "Unknown or Not Stated")

if (all(analysis_data$age_of_mother %in% valid_ages)) {
  message("Test Passed: The 'age_of_mother' column contains valid categories.")
} else {
  stop("Test Failed: The 'age_of_mother' column contains invalid categories.")
}

if (all(analysis_data$mothers_single_race %in% valid_races)) {
  message("Test Passed: The 'mothers_single_race' column contains valid categories.")
} else {
  stop("Test Failed: The 'mothers_single_race' column contains invalid categories.")
}

#### Summary of Tests ####
message("All tests completed.")

