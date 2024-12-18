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
- CDC Wonder  # Data source: Centers for Disease Control and Prevention WONDER database
metrics:
- rmse  
- r2  
base_model: Bayesian

model-index:
- name: Impact of Abortion Policies on Infant Mortality
  results:
  - task:
      type: regression
      name: Bayesian Difference-in-Differences Analysis
    dataset:
      type: public-health
      name: Infant Deaths Data Summary
      description: Linked Birth / Infant Death Records (Expanded) 2017 - 2022
      configuration: infant_mortality_2021_2022
      subset: partial-dataset
      version: 202212
      note: This download includes only a portion of the full dataset relevant to the analysis.
    source:
      name: GitHub Repository
      url: https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion
---

# Impact of the Dobbs Decision Overturning Roe v. Wade and Abortion Bans on Infant Mortality Rates in the United States (2021–2022)

## Overview

This repository contains the analysis and methodology used to examine the impact of abortion bans following the 2022 Dobbs decision on infant mortality rates in the United States. The primary objective is to quantify the changes in infant mortality rates in states where abortion is restricted compared to states where abortion is protected. The analysis employs Bayesian Difference-in-Differences (DID) models, incorporating both policy factors and demographic variables, to understand these changes in-depth.

The project draws on data from the CDC WONDER database (2021–2022) and explores the implications of policy changes on public health. It also discusses the data preparation process, statistical modeling, and the limitations of using observational data for causal inference. This repository provides all the necessary data, R scripts, and documentation for readers to reproduce and understand the study’s findings on the intersection of reproductive policy and infant health outcomes.

## File Structure

The repository is structured as follows:

-   `data/01-raw_data` contains the raw infant death data as obtained from [CDC Wonder](https://wonder.cdc.gov/controller/datarequest/D159), The process for selecting the query parameters and downloading the dataset is outlined in the <ins>Data Download </ins>. This ensures the traceability and reproducibility of the data acquisition process. To open these data through GitHub, they can be downloaded. Alternatively, to view these files within RStudio, they can be imported using the library `read.delim`.
-   `data/02-analysis_data` contains the cleaned dataset constructed in `scripts/03-clean_data`.
-   The `scripts` folder contains the R scripts and code that simulated, tested, and cleaned the data.
-   `model` contains fitted models.
-   `other` contains details about LLM chat interactions and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.

## Data Download

One way to download the Query Criteria, the same as the raw data, is to use the [saved request](https://wonder.cdc.gov/controller/saved/D159/D414F912) to get the exact same query criteria. After clicking the link, please read the terms of data use and click the "I Agree" button below to access the saved request. Once the processing requests are completed (about 5-7 minutes), click the "Results" tab at the top of the page to see the result table.

Then, you can explore the table of data. Please scroll to the bottom and read the "Notes" section to learn about the "Caveats" of the dataset. Additionally, you can review the "Query Criteria" section to see the selected query range. Once you are done with the exploration, click the "Export" button at the top of the page and download the `.txt` file of the dataset. This will be our raw data. Import and save the file in the `data/01-raw_data` folder.

If you’d prefer to recreate the process yourself, you can follow these steps to build the query manually:

1.  Go to [Linked Birth / Infant Death Records for 2017-2022 with ICD 10 codes (expanded)](https://wonder.cdc.gov/lbd-current-expanded.html). Read the terms of data use and click the "I Agree" button.

2.  In the Organize Table Layout section, choose to group results by the following variables:

-   **Age of Mother 9**
-   **Mother's Single Race 6**
-   **Year of Death**
-   **Month**
-   **State**

3.  Scroll down the page to find the variable query section. Use the following steps to select variables (Hint: Use Ctrl + Click for multiple selections, or Shift + Click for a range):

-   Select maternal characteristics:
    -   **Age of Mother 9**: Under 15 years; 15-19 years; 20-24 years; 25-29 years; 30-34 years.
    -   **Mother's Single Race 6**: American Indian or Alaska Native; Asian; Black or African American; Native Hawaiian or Other Pacific Islander; White; More than one race; Unknown or Not Stated.
-   Select infant characteristics:
    -   **Year of Death**: 2021; 2022.

4.  Send your data request to be processed on the CDC WONDER database. The "Send" buttons are located at the bottom of the Request page and in the upper-right corner of each section for easy access.

5.  Keep all table settings at default. Once the table is ready, click the "Export" button at the top of the page to download the `.txt` file of the dataset.

6.  Import and save the file in the `data/01-raw_data` folder.

## Statement on LLM usage

Aspects of the code were written with the help of ChatGPT4o. Part of the writing process, including generating and polishing was written with the help of ChatGPT4o, and the entire chat history is available in `other/llms/usage.txt`.

# Model Card for Infant Mortality and Abortion Policy Analysis Model

This model analyzes the impact of abortion bans resulting from the Dobbs v. Jackson Women’s Health Organization decision on infant mortality rates in the United States using data from 2021–2022. It incorporates policy factors, such as abortion legality and the timing of the Dobbs decision, as well as demographic variables, through Bayesian Difference-in-Differences (DID) regression models. The analysis focuses on the health disparities linked to restrictive abortion policies post-Dobbs.

## Model Details

### Model Description

This model predicts the impact of abortion injunctions on infant mortality rates in the United States using a Difference-in-Differences (DID) approach. The architecture incorporates Bayesian regression with random effects, allowing for robust analysis of state-level variations and demographic factors. The model leverages data from the CDC WONDER Infant Deaths Data Summary (2017–2022) and was developed as part of a public health research initiative. The training process employed partial datasets to focus on relevant periods (2021–2022) and policy-related impacts.

-   **Developed by:** Diana Shen
-   **Funded by:** Independent research
-   **Model type:** Bayesian Difference-in-Differences
-   **License:** MIT License
-   **Language(s):** N/A (focus on statistical analysis, not NLP)

### Model Sources

-   **Repository:** [GitHub Link](https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion)
-   **Paper**: [Impact of Roe v. Wade’s Overturn: Abortion Restrictions and Infant Mortality in the U.S. Using a Difference-in-Differences Analysis](https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion/blob/main/paper/ExaminingtheimpactOverturnofRoev.Wade-BanningofAbortiononInfantMortalityRatesintheUnitedStatesUsingaDifference-in-DifferencesApproach.pdf)

## Uses

This section provides an overview of the model’s intended applications, discusses who may use the model and in what contexts, and specifies out-of-scope or misuse scenarios.

### Direct Use

The model is designed to assess the relationship between restrictive abortion policies and infant mortality rates using observational data. Users can utilize the pre-trained model without additional fine-tuning or post-processing for tasks such as:

-   **Policy Analysis**: Evaluating the public health impacts of abortion laws on infant mortality across different states.
-   **Research Applications**: Supporting studies in public health, social policy, and demographic analysis.
-   **Educational Use**: Demonstrating applications of Bayesian Difference-in-Differences (DID) methods in data analysis.

#### Example Code Snippet:

``` r
# Load pre-trained model
library(rstanarm)

# Example prediction for new data
illegal_states <- c("AL", "AR", "ID", "IN", "KY", "LA", "MS", "OK", "SD", "TN", "TX", "WV")
new_data <- data.frame(
  death_rate = runif(700, min = 0, max = 50),
  state = factor(sample(state.abb, size = 700, replace = TRUE)), 
  age_of_mother = sample(c("15–19", "20–24", "25–29", "30–34"), 700, replace = TRUE),
  mothers_single_race = sample(c("White", "Black", "Asian"), 700, replace = TRUE),
  year_of_death = sample(c(2021, 2022), 700, replace = TRUE),
  month = sample(1:12, 700, replace = TRUE)
) |> 
  mutate(
    after_injunction = as.factor(case_when(year_of_death == 2022 & month >= 6 ~ 1, TRUE ~ 0)),
    abortion_illegal = as.factor(case_when(state %in% illegal_states ~ 1, TRUE ~ 0))
  )
predictions <- posterior_predict(pre_trained_model, newdata = new_data)
print(predictions)
```

### Downstream Use

The model can be fine-tuned or integrated into broader systems for tasks such as:

-   Predictive Analysis: Enhancing forecasts of infant mortality rates by incorporating additional socioeconomic or healthcare variables.

-   Policy Decision Support Systems: Embedding the model into tools that simulate the effects of different abortion policy scenarios on public health outcomes.

-   Visualization Dashboards: Using the model’s outputs to create visual tools for policymakers or researchers.

#### Example Code Snippet:

## Fine-tune the model with additional data

``` r
fine_tuned_model <- stan_glm( death_rate ~ after_injunction * abortion_illegal + age_of_mother + mothers_single_race + year_of_death + (1|state), data = extended_data, family = gaussian(link = "identity") )

# Generate predictions using the fine-tuned model

new_predictions <- posterior_predict(fine_tuned_model, newdata = new_data)
```

### Out-of-Scope Use

The following scenarios are considered out-of-scope or inappropriate for this model:

-   Medical decision-making without expert oversight.

-   Analysis beyond the scope of the U.S. context or the training data period (2021–2022).

-   Use for real-time systems requiring instantaneous predictions.

For ethical and technical considerations, users are strongly advised to evaluate the appropriateness of the model for their specific use case.

## Bias, Risks, and Limitations

The model relies on the assumption of parallel trends, which may not hold due to pre-existing differences in healthcare systems or socioeconomic conditions. Additionally, the observational nature of the data limits causal interpretation.

### Recommendations

Results should be interpreted within the context of the dataset and assumptions. Additional qualitative research is recommended to complement the quantitative findings and address unobserved confounders.

## How to Get Started with the Model

``` r
# Load necessary libraries
library(rstanarm)
library(tidyverse)

# Load the model
model1 <- readRDS("file = here::here("models/first_model.rds"))
model2 <- readRDS("file = here::here("models/second_model.rds"))
# Summarize the model
summary(model1)
summary(model2)

# Generate posterior predictive checks
pp_check(model1)
pp_check(model2)
```

Here’s a detailed and formatted response based on your training process and requirements:

## Training Details

### Training Data

The training data originates from the Linked Birth/Infant Death Records (2017-2022) dataset, which contains vital statistics on infant mortality in the United States. The dataset provides information on maternal demographics, infant death rates, and various temporal and geographic factors. Key features include:

-   State of Residence: Identifies the mother’s state of residence during childbirth.
-   Maternal Age: Categorized into groups such as 15-19, 20-24, 25-29, and 30-34 years.
-   Maternal Race: Recorded as a categorical variable (e.g., Asian, Black or African American, White).
-   Year of Death, Month: Specifies when the infant death occurred.
-   Death Rate: Continuous variable indicating the number of infant deaths per 1,000 live births, with reliability labels.

The dataset underwent cleaning and feature engineering, as described in the preprocessing steps, to ensure readiness for analysis and modeling.

#### Training Procedure

##### Preprocessing

1.  Input Data: The raw dataset was read from `data/01-raw_data/Linked_Birth_Infant_Death_Records_2017-2022_Expanded.txt`, a tab-delimited file, using the `read.delim()` function.
2.  Data Cleaning:

-   Column Renaming: Standardized column names for consistency.
-   Missing Values: Rows with missing values were removed.
-   Data Transformation: Converted death_rate to numeric, extracting and separating reliability information.

3.  Feature Engineering:

-   Time Indicator (`after_injunction`): Created a binary variable indicating whether the infant death occurred after June 2022.
-   Policy Indicator (`abortion_illegal`): A binary variable indicating whether abortion was illegal in the state of residence.
-   Date Consolidation: Combined year and month into a Date object for analysis.

4.  Output Data: Saved the cleaned data in CSV and Parquet formats for compatibility with modeling tools in`data/02-analysis_data`.

##### Training Hyperparameters

The training process used the Stan Generalized Linear Mixed Model (GLMM) framework implemented through the `rstanarm` library in R. Two models were trained:

-   First Model:

``` r

first_model <- stan_glmer( formula = death_rate \~ after_injunction \* abortion_illegal + abortion_illegal + (1 \| state), data = analysis_data, family = gaussian(), prior = normal(location = 0, scale = 2.5, autoscale = TRUE), prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE), prior_aux = exponential(rate = 1, autoscale = TRUE), seed = 853 )
```

-   Second Model (with additional covariates):

``` r

second_model <- stan_glmer( formula = death_rate \~ after_injunction \* abortion_illegal + abortion_illegal + year_of_death + age_of_mother + mothers_single_race + (1 \| state), data = analysis_data, family = gaussian(), prior = normal(location = 0, scale = 2.5, autoscale = TRUE), prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE), prior_aux = exponential(rate = 1, autoscale = TRUE), seed = 853 )
```

##### Speeds, Sizes, Times

-   Model Training Time: Approximately 5-10 minutes per model on an 8-core CPU with 16 GB of RAM.
-   Dataset Size: The cleaned dataset contains 659 rows and 11 variables.
-   Model Complexity: Included a random effect for the state to account for state-specific variations.

The preprocessing and modeling steps ensure robustness, interpretability, and reproducibility of the findings.

Here is a detailed response for the evaluation section based on your project requirements:

## Evaluation

### Testing Data, Factors Metrics

#### Testing Data

The testing data is a subset of the Linked Birth/Infant Death Records (2017-2022) dataset, focusing on infant mortality trends after 2021 and up to 2022. This subset includes demographic, temporal, and geographic factors relevant to evaluating the causal impact of abortion bans. 
Key attributes include: 
-  States with and without abortion bans post-June 2022.
-  Temporal data: Infant deaths categorized before and after the abortion injunctions.
-  Demographic data: Maternal age and race.

#### Factors

Evaluation of the model’s performance was disaggregated across the following factors: 
1. **Policy Factors**:
 -  States categorized based on abortion legality (`abortion_illegal`).
 -  Timing relative to the abortion injunction (`after_injunction`).
2. **Demographic Factors**:
 -  Maternal race (`mothers_single_race`).
 -  Maternal age group (`age_of_mother`).
3. **Temporal Factors**:
 -  Year of death (`year_of_death`).

#### Metrics

The evaluation metrics used to assess the models include: 
1. **Root Mean Square Error (RMSE)**: 
   -  Measures the average prediction error. 
   -  Lower RMSE indicates better model fit.
2. **R-squared ($R^2$)**: 
   -  Indicates the proportion of variance explained by the model. 
   -  Higher $R^2$ values represent a better fit.
3. **Posterior Predictive Checks**:
   -  Examines the alignment of predicted and observed values to assess model calibration.

#### Results

1.  **Model 1: Focuses on policy factors (after_injunction and abortion_illegal) and their interaction.**

-   RMSE: 4.21 deaths per 1,000 live births.
-   $R^2$: 0.256.
-   The interaction term (after_injunction \* abortion_illegal) was significant, indicating an increase in infant mortality rates in states with abortion bans after June 2022.

2.  **Model 2: Incorporates additional demographic factors (age_of_mother, mothers_single_race).**

-   RMSE: 2.36 deaths per 1,000 live births.
-   $R^2$: 0.793.
-   Older maternal age groups were associated with lower infant mortality rates, while Black mothers experienced disproportionately higher rates.

#### Summary

The models effectively captured the impact of abortion bans on infant mortality rates, with significant differences observed in states with restrictive abortion policies. Demographic disparities, such as race and maternal age, further influenced mortality rates, highlighting the compounded effects of policy and social factors.

#### Model Examination

The models underwent extensive posterior predictive checks and comparisons between prior and posterior distributions. The posterior predictive checks indicated a strong alignment between the predicted and observed infant mortality rates, highlighting the model’s ability to capture general trends but limited precision. The comparison of prior and posterior distributions demonstrated that the data substantially informed the posterior estimates, particularly for key predictors such as the interaction term between restrictive abortion laws and the timing of the Dobbs decision. These results validate the model’s capacity to explore the effects of restrictive abortion policies on maternal mental health and infant outcomes, offering a sound basis for policy recommendations.

#### Environmental Impact

The computational resources used to train and evaluate the models were minimal: 
- Hardware Type: Standard 8-core CPU with 16 GB RAM.
- Hours used: Approximately 1-2 hours for training and evaluation.
- Cloud Provider: Local machine; no external cloud services were used. 
- Compute Region: N/A for local computation. 
- Carbon Emitted: Negligible, as computations were performed on energy-efficient hardware.

## Technical Specifications

### Model Architecture and Objective

The model is a hierarchical Bayesian regression framework designed to assess the impact of abortion restrictions on infant mortality rates across U.S. states. The setup includes two models:

1.  A baseline model to estimate direct and interaction effects.

2.  An extended model incorporating demographic and temporal controls.

### Mathematical Model Setup

The models are defined as follows:

$$y_i|\mu_i,\sigma \sim \mbox{Normal}(\mu_i, \sigma)$$ $$\text{First Model}: \mu_i = \beta_0 + \beta_1\cdot\text{After Injunction} + \beta_2\cdot\text{Abortion Illegal}+\beta_3\cdot\text{After Injunction}\cdot\text{Abortion Illegal}_i+\gamma_j$$ $$
\begin{aligned}
\text{Second Model}:\mu_i &= \beta_0 + \beta_1\cdot\text{After Injunction}_i + \beta_2\cdot\text{Abortion Illegal}_i+\beta_3\cdot\text{After Injunction}_i\cdot\text{Abortion Illegal}_i \\
&+\beta_4\cdot\text{Year of Death}_i+\beta_5\cdot\text{Age of Mother}_i+\beta_6\cdot\text{Mother's Single Race}_i+\gamma_j
\end{aligned}
$$ $$\beta_0 \sim \mbox{Normal}(0, 2.5)$$ $$\beta_1 \sim \mbox{Normal}(0, 2.5)$$ $$\beta_2 \sim \mbox{Normal}(0, 2.5)$$ $$\beta_3 \sim \mbox{Normal}(0, 2.5)$$ $$\beta_4 \sim \mbox{Normal}(0, 2.5)$$ $$\beta_5 \sim \mbox{Normal}(0, 2.5)$$ $$\beta_6 \sim \mbox{Normal}(0, 2.5)$$ $$\gamma_j\sim \text{Normal}(0, \sigma_j^2)$$ $$\sigma \sim \mbox{Exponential}(1)$$

### Justification for the Model

The model incorporates:

-   **Interaction Terms**: Capturing the combined effects of time and policy changes on infant mortality.

-   **Random Effects**: Adjusting for unobserved heterogeneity across states.

-   **Demographic and Temporal Controls**: Ensuring robust estimates that account for maternal age, race, and year of death.

This approach leverages Difference-in-Differences (DID) to isolate causal effects while quantifying uncertainty through Bayesian inference.

### Compute Infrastructure

The models were implemented using the `rstanarm` package in R, leveraging its default priors for both Gaussian and hierarchical Bayesian models.

## Citation

**BibTeX:**

@misc{shen2024dobbs, author = {Diana Shen}, title = {Examining the impact Overturn of Roe v. Wade: Banning of Abortion on Infant Mortality Rates in the United States Using a Difference-in-Differences Approach}, year = {2024}, url = {<https://github.com/DianaShen1224/Relationship-between-infant-mortality-rate-and-prohibited-abortion>} }

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

[diana.shen\@mail.utoronto.ca](mailto:diana.shen@mail.utoronto.ca)

## Reference

Ozoani, Ezi and Gerchick, Marissa and Mitchell, Margaret. Model Card Guidebook. Hugging Face, 2022. https://huggingface.co/docs/hub/en/model-card-guidebook
