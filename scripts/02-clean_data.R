#### Preamble ####
# Purpose: Cleans the raw dataset of infant death rate across US in 2021 and 2022.
# Author: Diana Shen
# Date: 24 November 2024
# Contact: diana.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites:  
# - The `tidyverse`, `janitor`,`lubridate`,`arrow` packages must be installed and loaded
# - Linked_Birth_Infant_Death_Records_2017-2022_Expanded.txt must have been downloaded and uploaded to the data/01-raw_data
# Any other information needed?  Make sure you are in the `Relationship between_infant_mortality_rate_and_prohibited_abortion` rproj

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(arrow)

#### Clean data ####
# Specify the input file path
input_file <- "data/01-raw_data/Linked_Birth_Infant_Death_Records_2017-2022_Expanded.txt"

# Specify the output CSV file path
output_file <- "data/02-analysis_data/cleaned_infant_death_record.csv"

# Read the tab-separated file, allowing for irregular lines
data <- read.delim(input_file, header = TRUE, sep = "\t", stringsAsFactors = FALSE, fill = TRUE)

# Write the data to a CSV file
write.csv(data, output_file, row.names = TRUE)

raw_data <- data

cleaned_data <-
  raw_data |>
  janitor::clean_names() 
cleaned_data <-cleaned_data|> select(state,age_of_mother_9_code,mother_s_single_race_6,year_of_death,month_code,month,death_rate)|>
  tidyr::drop_na()

# List of states where abortion is illegal after June 2022
illegal_states <- c("Alabama", "Arkansas", "Idaho", "Indiana", "Kentucky", 
                    "Louisiana", "Mississippi", "Oklahoma", "South Dakota", 
                    "Tennessee", "Texas", "West Virginia")

cleaned_data<-cleaned_data|>
  mutate(after_injunction=as.factor(case_when(year_of_death == 2022 & month_code >= 6 ~ 1, TRUE ~ 0)))|>
  mutate(abortion_illegal = as.factor(case_when(state %in% illegal_states ~ 1, TRUE ~ 0)))|> mutate(
    reliable = if_else(grepl("Unreliable", death_rate), "Unreliable", "Reliable"), # Add reliability column
    death_rate = gsub(" \\(Unreliable\\)", "", death_rate), # Clean the death_rate column
    death_rate = as.numeric(death_rate),
    date = as.Date(paste(year_of_death, month_code, "01", sep = "-"))
  )|> rename( age_of_mother = age_of_mother_9_code )|>
rename(mothers_single_race = mother_s_single_race_6)

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
