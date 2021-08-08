/****************************************************************/
/* This dofile makes the stats referenced in the data appendix  */
/****************************************************************/

/*********************************************/
/* Share of deaths with specific educations  */
/*********************************************/
use $mdata/int/nchs/mort_8918, clear

keep if inrange(age,25,69) 

/* missing white and black */ 
tab edclass if year >= 1992 & ind_WNH == 1 & !inlist(fipsstr,13,40,44,46), mi
tab edclass if year >= 1992 & ind_BNH == 1 & !inlist(fipsstr,13,40,44,46), mi

/* share reassigned is the total fraction of deaths, among non-missing */ 
tab edclass if year >= 1992 & ind_WNH == 1 & !inlist(fipsstr,13,40,44,46) & edclass != 99, mi
tab edclass if year >= 1992 & ind_BNH == 1 & !inlist(fipsstr,13,40,44,46) & edclass != 99, mi

/**********************************/
/* Institutionalized populations  */
/**********************************/
use $mdata/int/nchs/appended_rank_mort, clear

gen pop = inst + non_inst
bys year sex race: egen entire_pop = total(pop)
bys year sex race: egen entire_inst = total(inst)
bys year sex race: egen entire_non_inst = total(non_inst)

gen share_inst = entire_inst / entire_pop
list share_inst if year == 2018 & sex == 1 & race == 1
list share_inst if year == 2018 & sex == 1 & race == 2
list share_inst if year == 2018 & sex == 2 & race == 1
list share_inst if year == 2018 & sex == 2 & race == 2

/**************************************************************/
/* This counts the people who are reassigned to 12-no diploma */
/**************************************************************/
use $mdata/raw/acs/acs_2018_P_raw, clear

gen educ = . 
replace educ=1 if schl<=14 
replace educ=2 if schl==16 | schl==17 | schl == 15 
replace educ=3 if 18<=schl & schl<=20 /*includes Associate's*/
replace educ=4 if schl==21
replace educ=5 if 22<=schl & schl~=.

/* get number of people who have 12th no diploma */ 
sum pwgtp if schl == 15, d
di `r(sum)'
local nodip12 = `r(sum)'

sum pwgtp if educ== 1, d
di `r(sum)'
local dropout = `r(sum)'

sum pwgtp if educ== 2 & schl != 15, d
di `r(sum)'
local hswdegree = `r(sum)'

di `nodip12' / `dropout'
di `nodip12' / `hswdegree'
