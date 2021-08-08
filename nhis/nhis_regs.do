global std $mdataint

global data $mdata/int/nhis/clean 
use $data/collapsed_nhis_mort, clear

/* combine men and women */
collapse (mean) mort_* (sum) tpop [aw=tpop], by(race ed year age_gp)

/* get standard errors on the 1- and 5-year trends */
/* ED LEVEL 1 */
reg mort_1 year if race == 1 & ed == 1 & age == 25
sum mort_1 if year == 1997 & ed == 1 & age == 25
local  growth_mid_ed1_1 = (_b["year"]) / `r(mean)'
local  growth_low_ed1_1 = (_b["year"] - 1.96*_se["year"]) / `r(mean)'
local growth_high_ed1_1 = (_b["year"] + 1.96*_se["year"]) / `r(mean)'

reg mort_5 year if race == 1 & ed == 1 & age == 25
sum mort_5 if year == 1997 & ed == 1 & age == 25
local  growth_mid_ed1_5 = (_b["year"]) / `r(mean)'
local  growth_low_ed1_5 = (_b["year"] - 1.96*_se["year"]) / `r(mean)'
local growth_high_ed1_5 = (_b["year"] + 1.96*_se["year"]) / `r(mean)'

/* ED LEVEL 2 */
reg mort_1 year if race == 1 & ed == 2 & age == 25
sum mort_1 if year == 1997 & ed == 2 & age == 25
local  growth_mid_ed2_1 = (_b["year"]) / `r(mean)'
local  growth_low_ed2_1 = (_b["year"] - 1.96*_se["year"]) / `r(mean)'
local growth_high_ed2_1 = (_b["year"] + 1.96*_se["year"]) / `r(mean)'

reg mort_5 year if race == 1 & ed == 2 & age == 25
sum mort_5 if year == 1997 & ed == 2 & age == 25
local  growth_mid_ed2_5 = (_b["year"]) / `r(mean)'
local  growth_low_ed2_5 = (_b["year"] - 1.96*_se["year"]) / `r(mean)'
local growth_high_ed2_5 = (_b["year"] + 1.96*_se["year"]) / `r(mean)'

di "Change in 1-year mortality for least educated whites: "%6.3f (`growth_mid_ed1_1') " (" %6.3f (`growth_low_ed1_1') ", "%6.3f (`growth_high_ed1_1') ")"
di "Change in 1-year mortality for HS whites: "%6.3f (`growth_mid_ed2_1') " (" %6.3f (`growth_low_ed2_1') ", "%6.3f (`growth_high_ed2_1') ")"
di "Change in 5-year mortality for least educated whites: "%6.3f (`growth_mid_ed1_5') " (" %6.3f (`growth_low_ed1_5') ", "%6.3f (`growth_high_ed1_5') ")"
di "Change in 5-year mortality for HS whites: "%6.3f (`growth_mid_ed2_5') " (" %6.3f (`growth_low_ed2_5') ", "%6.3f (`growth_high_ed2_5') ")"


/*************************************/
/* compare to raw numbers from NCHS  */
/*************************************/

/* recreate standardized mortality file, so we have control over the age in sample */
use $mdataint/nchs/appended_rank_mort, clear
drop _merge
ren age_gp age
merge m:1 age using $std/std-pop-79-5

/* charlie's years -- 25 to 54 */
keep if inrange(age, 25, 54)
assert _merge == 3
drop _merge
keep if age <= 54
collapse (mean) tmortrate dmortrate [aw=std_pop], by(sex race edclass year)
save $std/mort_std_5_25_54, replace

/* to match NHIS, look at 97->09 */
reg tmortrate year if sex == 0 & ed == 1 & race == 1 & inrange(year, 1996, 2009)
sum tmortrate  if sex == 0 & ed == 1 & race == 1 & year == 1996
local  growth_mid_ed1 = (_b["year"]) / `r(mean)'
local  growth_low_ed1 = (_b["year"] - 1.96*_se["year"]) / `r(mean)'
local growth_high_ed1 = (_b["year"] + 1.96*_se["year"]) / `r(mean)'

reg tmortrate year if sex == 0 & ed == 2 & race == 1 & inrange(year, 1996, 2009)
sum tmortrate  if sex == 0 & ed == 2 & race == 1 & year == 1996
local  growth_mid_ed2 = (_b["year"]) / `r(mean)'
local  growth_low_ed2 = (_b["year"] - 1.96*_se["year"]) / `r(mean)'
local growth_high_ed2 = (_b["year"] + 1.96*_se["year"]) / `r(mean)'

di "Change in mortality for least educated whites: "%6.3f (`growth_mid_ed1') " (" %6.3f (`growth_low_ed1') ", "%6.3f (`growth_high_ed1') ")"
di "Change in mortality for HS whites: "%6.3f (`growth_mid_ed2') " (" %6.3f (`growth_low_ed2') ", "%6.3f (`growth_high_ed2') ")"
