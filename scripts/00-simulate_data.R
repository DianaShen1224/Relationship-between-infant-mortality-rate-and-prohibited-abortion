#### Preamble ####
# Purpose: Simulates a dataset of infant death rate across US in 2021 and 2022.
# Author: Diana Shen
# Date: 24 November 2024 
# Contact: diana.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Relationship between_infant_mortality_rate_and_prohibited_abortion` rproj

#### Workspace setup ####
library(tidyverse)

#### Data expected structure ####
# Simulated Data infant death rate:
# - Columns: death_rate, after_injunction, abortion_illegal, state, age_of_mother, mothers_single_race, year_of_death, month
#death_rate = "numeric, between 0 and 50 (representing deaths per 1,000 live births)"
#after_injunction = "binary, 0 (before injunction) or 1 (after injunction)"
#abortion_illegal = "binary, 0 (legal abortion) or 1 (illegal abortion)"
#state = "string, valid US state abbreviations (e.g., TX, CA)"
#age_of_mother = "categorical, one of: '15–19', '20–24', '25–29', '30–34', '35–39', '40–44', '45+'"
#mothers_single_race = "categorical, one of: 'White', 'Black', 'Asian', 'Native American', 'Pacific Islander', 'More than #one race', 'Unknown or Not Stated'"
#year_of_death = "numeric, one of: 2021, 2022"
#month = "numeric, between 1 (January) and 12 (December)"

#### Simulate data ####
# Define states, candidates, and other factors
# Define the list of states where abortion is illegal
illegal_states <- c("AL", "AR", "ID", "IN", "KY", "LA", "MS", "OK", "SD", "TN", "TX", "WV")

set.seed(123) 
# Simulate data
simulated_data <- data.frame(
  death_rate = runif(700, min = 0, max = 50),
  state = factor(sample(state.abb, size = 700, replace = TRUE)), # Use state.abb for state abbreviations
  age_of_mother = sample(c("15–19", "20–24", "25–29", "30–34"), 700, replace = TRUE),
  mothers_single_race = sample(c("White", "Black", "Asian", "Native American", "Pacific Islander", 
                                 "More than one race", "Unknown or Not Stated"), 700, replace = TRUE),
  year_of_death = sample(c(2021, 2022), 700, replace = TRUE),
  month = sample(1:12, 700, replace = TRUE)
) |> 
  mutate(
    after_injunction = as.factor(case_when(year_of_death == 2022 & month >= 6 ~ 1, TRUE ~ 0)),
    abortion_illegal = as.factor(case_when(state %in% illegal_states ~ 1, TRUE ~ 0))
  )

# Display first few rows
head(simulated_data)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")