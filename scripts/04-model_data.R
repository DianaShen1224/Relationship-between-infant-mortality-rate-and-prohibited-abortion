#### Preamble ####
# Purpose: Model Infant Death Rate in the U.S. across states in year 2021-2022 using Bayesian DID Model Approach.
# Author: Diana Shen
# Date: 20 November 2024 
# Contact: diana.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Cleaned data file `analysis_data.parquet` should be available in the `data/02-analysis_data/` directory.
# - Packages `arrow`, `rstanarm`, and `tidyverse` must be installed and loaded
# Any other information needed? Make sure you are in the `Relationship between_infant_mortality_rate_and_prohibited_abortion` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
first_model <- stan_glmer(
  formula = death_rate ~ after_injunction * abortion_illegal + abortion_illegal + (1 | state) ,
  data = analysis_data,
  family = gaussian(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_aux = exponential(rate = 1, autoscale = TRUE),
  seed = 853
)


second_model <- stan_glmer(
  formula = death_rate ~ after_injunction * abortion_illegal + year_of_death +age_of_mother+ mothers_single_race + (1 | state),
  data = analysis_data,
  family = gaussian(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_aux = exponential(rate = 1, autoscale = TRUE),
  seed = 853
)
#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)
saveRDS(
  second_model,
  file = "models/second_model.rds"
)

