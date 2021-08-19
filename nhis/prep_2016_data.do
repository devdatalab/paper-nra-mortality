clear

/* get 2016 persons data and merge onto adult educations data */ 
use $mdata/raw/nhis//2016_persons, clear
merge 1:1 hhx fmx fpx using  $mdata/raw/nhis//2016_adult
keep if _merge == 3

/* recode education into classes */
tab educ1
gen edclass = 1 if educ1 < 12
replace edclass = 2 if inlist(educ1, 12, 13,14) / GEDs = exactly HS 
replace edclass = 3 if inlist(educ1,15,16,17)
replace edclass = 4 if educ1 > 17

drop if inlist(educ1,97,99) 
          
gen pain = inlist(chpain,2,3,4) 
gen fatigue = inlist(aflhc33,1)
gen depression = inlist(aflhca17,1) 

