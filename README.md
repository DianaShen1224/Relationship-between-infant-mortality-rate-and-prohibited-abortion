---
language:
- en
license: mit  # MIT license for open collaboration
library_name: rstanarm  # Bayesian modeling in R
tags:
- public-health
- causal-inference
- difference-in-differences
- bayesian-statistics
datasets:
- cdc_wonder  # Data source: Centers for Disease Control and Prevention WONDER database
metrics:
- rmse  # Root Mean Square Error for regression model evaluation
- r2  # R-squared for goodness of fit evaluation
base_model: null  # No pre-trained base model used

model-index:
- name: Impact of Abortion Policies on Infant Mortality
  results:
  - task:
      type: regression
      name: Bayesian Difference-in-Differences Analysis
    dataset:
      type: public-health
      name: CDC WONDER Dataset
      config: infant_mortality_2021_2022
      split: full-dataset
      revision: 202212
    metrics:
      - type: rmse
        value: 0.345  # Example value
        name: Root Mean Square Error
      - type: r2
        value: 0.89  # Example value
        name: R-squared
    source:
      name: GitHub Repository
      url: https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion
---
# Starter folder

## Overview

This repo provides students with a foundation for their own projects associated with *Telling Stories with Data*. You do not need every aspect for every paper and you should delete aspects that you do not need.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The abstract and introduction were written with the help of ChatHorse and the entire chat history is available in inputs/llms/usage.txt.

## Some checks

- [ ] Change the rproj file name so that it's not starter_folder.Rproj
- [ ] Change the README title so that it's not Starter folder
- [ ] Remove files that you're not using
- [ ] Update comments in R scripts
- [ ] Remove this checklist

# Model Card for Bayesian Difference-in-Differences Model

This model examines the impact of restrictive abortion policies in the United States following the Dobbs decision and the overturn of Roe v. Wade. By employing a Bayesian Difference-in-Differences (DID) approach, the model quantifies changes in infant mortality rates across U.S. states.

## Model Details

### Model Description

This Bayesian DID model is designed to evaluate the effects of abortion bans on infant mortality rates across U.S. states. It uses a hierarchical Bayesian framework to account for state-level variation while including predictors such as maternal age, race, and year of death.

-   **Developed by:** Diana Shen
-   **Funded by:** Independent research
-   **Model type:** Bayesian Difference-in-Differences
-   **License:** MIT License
-   **Language(s):** N/A (focus on statistical analysis, not NLP)

### Model Sources

-   **Repository:** [GitHub Link](https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion)
-   **Data Source:** CDC WONDER dataset, updated December 2022

## Uses

### Direct Use

The model is intended for analyzing the impact of policy changes, specifically abortion bans, on infant mortality rates in the United States.

### Downstream Use

Researchers can adapt the model to evaluate other policy changes or health outcomes using similar observational data.

### Out-of-Scope Use

This model is not designed for individual-level predictions or contexts outside the dataset’s temporal and geographic scope.

## Bias, Risks, and Limitations

The model relies on the assumption of parallel trends, which may not hold due to pre-existing differences in healthcare systems or socioeconomic conditions. Additionally, the observational nature of the data limits causal interpretation.

### Recommendations

Results should be interpreted within the context of the dataset and assumptions. Additional qualitative research is recommended to complement the quantitative findings and address unobserved confounders.

## How to Get Started with the Model

``` r
library(rstanarm)

# Load model
first_model <-
  readRDS(file = here::here("models/first_model.rds"))
second_model <-
  readRDS(file = here::here("models/second_model.rds"))

# View summary
summary(first_model)
summary(second_model)
```

# Training Details

## Training Data

The model is trained using data from the CDC WONDER database, which includes variables such as maternal age, race, residence, state, and year and month of infant death.

## Training Procedure

The Bayesian model uses the `rstanarm` package in R with weakly informative priors:

-   Prior for coefficients: Normal(0, 2.5)

-   Prior for random effects: Normal(0, variance)

-   Interaction term: Evaluates the combined effect of abortion legality and post-injunction timing.

# Evaluation

## Testing Data, Factors & Metrics

### Testing Data

A subset of the CDC WONDER dataset was reserved for testing.

Factors

-   Abortion legality (binary)

-   Post-injunction period (binary)

-   Maternal demographics

Metrics

-   Posterior mean estimates

-   Root Mean Square Error (RMSE)

-   $R^2$

Results

The DID analysis revealed a statistically significant increase of 0.285 deaths per 1,000 live births in states with abortion bans after the Dobbs decision. Maternal age and race were significant predictors, with Black mothers facing disproportionately higher rates.

Environmental Impact

-   Hardware Type: Local machine (CPU)
-   Hours Used: \~3 hours
-   Carbon Emitted: Minimal (local computational setup)

Technical Specifications

Model Architecture and Objective

The model employs a hierarchical Bayesian structure with random effects for state-level variation. The objective is to estimate the causal impact of abortion bans on infant mortality rates.

Compute Infrastructure

-   Hardware: 8-core CPU, 16 GB RAM

-   Software: R 4.2.0, rstanarm 2.21.3, tidyverse 1.3.1

Citation

BibTeX:

## Citation [optional]

**BibTeX:** @misc{shen2024dobbs, author = {Diana Shen}, title = {Examining the impact Overturn of Roe v. Wade: Banning of Abortion on Infant Mortality Rates in the United States Using a Difference-in-Differences Approach}, year = {2024}, url = {<https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion>} }

**APA:**

Shen, D. (2024). Examining the impact Overturn of Roe v. Wade: Banning of Abortion on Infant Mortality Rates in the United States Using a Difference-in-Differences Approach. Retrieved from <https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion>.

## Glossary

-   Difference-in-Differences (DID): A statistical method used to estimate causal relationships by comparing changes in outcomes over time between a treatment group and a control group.

-   Infant Mortality Rate (IMR): The number of deaths of infants under one year of age per 1,000 live births in a specified population during a given time period.

-   Abortion Legality: A binary variable indicating whether abortion is legal (0) or illegal (1) in a state.

-   Post-Injunction Period: The time after June 2022 when abortion restrictions were implemented following the Dobbs decision.

-   Interaction Term: A variable created by multiplying abortion legality and the post-injunction period to evaluate their combined impact on infant mortality rates.

-   Parallel Trends Assumption: An assumption in DID analyses that, in the absence of an intervention, the treatment and control groups would have followed similar trends over time.

-   Bayesian Framework: A statistical approach that incorporates prior beliefs and updates them with data to estimate the posterior distribution of model parameters.

-   Random Effects: A statistical modeling component that captures variability across groups, such as states, in a hierarchical framework.

-   Weakly Informative Priors: Priors that provide some guidance without overwhelming the data, commonly used in Bayesian analyses to improve model convergence.


## Model Card Authors

Diana Shen

## Model Card Contact

[diana.shen\@mail.utoronto.ca](mailto:diana.shen@mail.utoronto.ca){.email}
