#### Preamble ####
# Purpose: Install necessary packages.
# Author: Diana Shen
# Date: 24 November 2024
# Contact: diana.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? Make sure you are in the `Relationship between_infant_mortality_rate_and_prohibited_abortion` rproj

# Install necessary packages
# List of packages used in the study
required_packages <- c(
  "tidyverse", "arrow", "modelsummary", "knitr", "kableExtra", 
  "usmap", "dplyr", "testthat", "here", "janitor", 
  "lubridate", "ggplot2", "rstanarm", "fixest", "caret"
)

# Install any packages not already installed
installed_packages <- installed.packages()
for (pkg in required_packages) {
  if (!(pkg %in% installed_packages[, "Package"])) {
    install.packages(pkg)
  }
}