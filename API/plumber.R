library(plumber)
library(tidyverse)

model <- readRDS(file = here::here("models/first_model.rds"))

version_number <- "0.0.1"

variables <- list(
  death_rate = "The number of deaths per 1,000 live births, a continuous variable.",
  after_injunction = "A binary variable indicating whether the infant's death occurred after the implementation of abortion injunctions (1 = Yes, 0 = No).",
  abortion_illegal = "A binary variable indicating the legality of abortion in the state of the mother's residence (1 = Illegal, 0 = Legal).",
  state = "The state of the mother's residence, included as a random effect in the model."
)

#* Predict infant death rate based on inputs
#* @param after_injunction Whether the death occurred after the injunction (0 = No, 1 = Yes)
#* @param abortion_illegal Whether abortion is illegal in the state (0 = No, 1 = Yes)
#* @param state The state of the mother's residence
#* @get /predict_death_rate
# Prediction function
predict_infant_death_rate <- function(after_injunction = 0, abortion_illegal = 0, state = "unknown") {
  # Create payload based on input
  payload <- data.frame(
    after_injunction = as.integer(after_injunction),
    abortion_illegal = as.integer(abortion_illegal),
    state = as.factor(state)
  )
  
  # Ensure input state matches model levels
  if (!state %in% levels(model$data$state)) {
    stop("State not recognized. Please provide a valid state.")
  }
  
  # Make prediction
  prediction <- predict(first_model, payload)
  
  # Return results
  result <- list(
    input = list(payload),
    response = list("estimated_death_rate" = prediction),
    status = 200,
    model_version = "1.0.0"
  )
  
  return(result)
}