#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


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

