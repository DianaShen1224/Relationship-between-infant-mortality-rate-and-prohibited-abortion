#### Preamble ####
# Purpose: Tests the structure and validity of the infant death rate across US in 2021 and 2022
# simulated dataset.
# Author: Diana Shen
# Date: 24 November 2024 
# Contact: diana.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `Relationship between_infant_mortality_rate_and_prohibited_abortion` rproj

#### Workspace setup ####
library(tidyverse)

#### Define the list of states where abortion is illegal ####
illegal_states <- c("AL", "AR", "ID", "IN", "KY", "LA", "MS", "OK", "SD", "TN", "TX", "WV")
#### Load data ####
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 700 rows (expected based on simulation)
if (nrow(simulated_data) == 700) {
  message("Test Passed: The dataset has 700 rows.")
} else {
  stop(paste("Test Failed: The dataset has", nrow(simulated_data), "rows instead of 700."))
}

# Check if the dataset has the expected 8 columns
expected_columns <- c("death_rate", "state", "age_of_mother", "mothers_single_race", 
                      "year_of_death", "month", "after_injunction", "abortion_illegal")

if (all(names(simulated_data) %in% expected_columns)) {
  message("Test Passed: The dataset contains all expected columns.")
} else {
  stop("Test Failed: The dataset is missing some expected columns.")
}

# Check if the 'state' column contains only valid US state abbreviations
if (all(simulated_data$state %in% state.abb)) {
  message("Test Passed: The 'state' column contains only valid US state abbreviations.")
} else {
  stop("Test Failed: The 'state' column contains invalid values.")
}

# Check if 'year_of_death' column contains only 2021 and 2022
if (all(simulated_data$year_of_death %in% c(2021, 2022))) {
  message("Test Passed: The 'year_of_death' column contains only valid years (2021, 2022).")
} else {
  stop("Test Failed: The 'year_of_death' column contains invalid years.")
}

# Check if 'month' column contains values between 1 and 12
if (all(simulated_data$month >= 1 & simulated_data$month <= 12)) {
  message("Test Passed: The 'month' column contains only valid months (1–12).")
} else {
  stop("Test Failed: The 'month' column contains invalid values.")
}

# Check for missing values
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if 'after_injunction' and 'abortion_illegal' columns are binary
if (all(levels(as.factor(simulated_data$after_injunction)) %in% c("0", "1")) &
    all(levels(as.factor(simulated_data$abortion_illegal)) %in% c("0", "1"))) {
  message("Test Passed: The 'after_injunction' and 'abortion_illegal' columns are binary.")
} else {
  stop("Test Failed: The 'after_injunction' or 'abortion_illegal' column contains invalid values.")
}

# Check if `abortion_illegal` matches the logic for `illegal_states`
if (all((simulated_data$state %in% illegal_states & simulated_data$abortion_illegal == 1) |
        (!simulated_data$state %in% illegal_states & simulated_data$abortion_illegal == 0))) {
  message("Test Passed: The `abortion_illegal` column is consistent with `illegal_states`.")
} else {
  stop("Test Failed: The `abortion_illegal` column does not match the `illegal_states` logic.")
}

# Check if the 'death_rate' column has values between 0 and 50
if (all(simulated_data$death_rate >= 0 & simulated_data$death_rate <= 100)) {
  message("Test Passed: The 'death_rate' column contains valid values (0–100).")
} else {
  stop("Test Failed: The 'death_rate' column contains invalid values.")
}

# Check if `after_injunction` matches the logic for `year_of_death` and `month`
if (all((simulated_data$year_of_death >= 2022 & simulated_data$month >= 6 & simulated_data$after_injunction == 1) |
        !(simulated_data$year_of_death >= 2022 & simulated_data$month >= 6) & simulated_data$after_injunction == 0)) {
  message("Test Passed: The `after_injunction` column is consistent with `year_of_death` and `month` logic.")
} else {
  stop("Test Failed: The `after_injunction` column does not match the `year_of_death` and `month` logic.")
}

# Check if 'age_of_mother' and 'mothers_single_race' columns have valid categories
valid_ages <- c("15–19", "20–24", "25–29", "30–34")
valid_races <- c("White", "Black", "Asian", "Native American", "Pacific Islander", 
                 "More than one race", "Unknown or Not Stated")

if (all(simulated_data$age_of_mother %in% valid_ages)) {
  message("Test Passed: The 'age_of_mother' column contains valid categories.")
} else {
  stop("Test Failed: The 'age_of_mother' column contains invalid categories.")
}

if (all(simulated_data$mothers_single_race %in% valid_races)) {
  message("Test Passed: The 'mothers_single_race' column contains valid categories.")
} else {
  stop("Test Failed: The 'mothers_single_race' column contains invalid categories.")
}

#### Summary of Tests ####
message("All tests completed.")

