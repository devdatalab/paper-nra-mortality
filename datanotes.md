# How to add a new year to the mortality data 

## Denominator (total populations):
1. We obtain the CPS data directly from the prepared CEPR files. 
2. We add institutionalized races from the ACS raw CEPR extract. 

* Instead of downloading the prepared data, we need to download the raw
data and CEPR cleaning files. That is because the ACS denominators
from the CEPR extract are not exactly comparable to the CPS denominators, and we need to make
some manual adjustments to the CEPR build.

* to get the raw data, you need to go to the Census ftp site. This is
  linked from CEPR
  [here](https://www2.census.gov/programs-surveys/acs/data/pums/)

* For each year, you need to download csv_pus (Persons) and csv_hus
  (Households) and put in the appropriate year's subdirectory in `acs/'

3. Copy and paste the current cepr_acs_educ.do file and update to the desired
year (e.g., copy-and-pasting 2018 to 2019). We made some manual changes to this dofile, and those need to
get pushed through the CEPR build. 

* In particular, we re-assign ``12 grade, no diploma'' to be people
who complete HS, per Jaeger (1997). But this is already implemented. 

## Numerator (mortality): 
1. Add the mortality data from NCHS to the nchs_data folder. 
2. Copy and paste the insheet commands from previous year (as long as the
NCHS data README says the coding is the same from 2005--current
year). 

# Key issues to be aware of 
1. The 12th grade, no diploma issue documented in the data appendix. 
2. The rolling denominators for population totals (in the data
appendix). 
* Summary of imputation procedure is in the data appendix. 
* Note that it doesn't matter that we do the imputation and then sum to get race, but impute sex at the same time. These are equivalent. Can show this by noting that the imputed value of the population is the linear projection of the cell onto the year. But the sum of the linear projections is the linear projection of the sum, due to the distributive property. Proof by Stata confirms, albeit with floating point error. 
* For the granular age data, we need to implement a couple more steps. In several cases, we have a few missing observations of the denominator (because the specific granular age-race-sex-year-edclass cell doesn't appear in the CPS). We still take the average of the non-missing denominators.
* We drop the `race = 0` (all races) from the granular age (`granage`) version of `append_rank_mort.dta`, for the following reason. Because we obtain the 
denominator for the `race = 0` by summing after the imputation, but we obtain the denominator for the `sex = 0` as a part of the imputation, we would be 
treating these cases not equivalently. Note that this `race = 0` for 
granular ages is not used in the analysis. 
* For 1992, there are a few demo cells where we only see one year in {1992, 1993, 1994}, so we can't run a regression. In that case, we just take the rolling average of 1992--1994. 




