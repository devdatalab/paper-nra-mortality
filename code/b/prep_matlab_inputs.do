/*******************************************************/
/* create average mortality by year/cause/sex/race/age */
/*******************************************************/
use $mdata/appended_rank_mort, clear

ren age_gp age

/* add cd/cl into other */
egen o = rowtotal(omort cdmort clmort)
drop omort cdmort clmort
ren o omort

/* create a non-despair category */
gen nmort = tmort - dmort
replace nmort = tmort if mi(dmort)

collapse (sum) tpop_rolling cmort tmort hmort dmort amort omort nmort, by(year age sex race)

/* reshape wide */
ren *mort mort*
reshape long mort, j(cause) i(year age sex race tpop_rolling) string

/* divide mortality by population (since we summed across 4 ed groups) */
replace mort = mort * 100000 / tpop_rolling

/* set all races from 0 to 5, b/c our matlab code is dumb about zeroes */
recode race 0=5

drop tpop_rolling
sort year age sex race cause mort
order year age sex race cause mort
export delimited using $mdata/mort_means.csv, replace

/* collapse to 3 year bins */
egen year_bin = cut(year), at(1992(3)2019)
collapse (mean) mort, by(year_bin age sex race cause)
ren year_bin year
export delimited using $mdata/mort_means_3.csv, replace

/**************************************************/
/* create short CSV version of appended_rank_mort */
/**************************************************/
use $mdata/appended_rank_mort, clear

ren age_gp age
keep year edclass age sex cum_ed_*_sex race *mortrate ed_*_sex tpop_rolling tmort

drop pmortrate smortrate lmortrate lungcmortrate rmortrate ormortrate ovmortrate

/* add cd/cl into other */
egen o = rowtotal(omortrate cdmortrate clmortrate)
drop omortrate cdmortrate clmortrate
ren o omortrate

/* create nmort -- non despair */
gen nmortrate = tmortrate - dmortrate
replace nmortrate = tmortrate if mi(dmortrate)

/* set all races from 0 to 5, b/c our matlab code is dumb about zeroes */
recode race 0=5

export delimited using $mdata/appended_rank_mort.csv, replace

/* collapse to 3-year bins */
egen year_bin = cut(year), at(1992(3)2019)
collapse (mean) tpop_rolling tmort *rate ed_rank_* cum_ed_rank_*, by(year_bin age sex race edclass)
ren year_bin year
save $tmp/appended_rank_mort_3, replace
export delimited using $mdata/appended_rank_mort_3.csv, replace

/**********************************/
/* 3 education bin mortality file */
/**********************************/
use $mdata/appended_rank_mort, clear

ren age_gp age
gen edclass3 = edclass
recode edclass3 1=1 2=1 3=2 4=3

list edclass cum_ed_rank_sex tpop_rolling tmortrate dmortrate if age == 50 & year == 1992 & race == 1 & sex == 1
collapse (sum) *mort tpop_rolling (max) cum_ed_rank_sex cum_ed_rank_race_sex, by(age sex race year edclass3)
ren edclass3 edclass
foreach v of varlist *mort {
  local type = substr("`v'", 1, strlen("`v'") - 4)
  gen `type'mortrate = `type'mort / tpop_rolling * 100000
}

/* set all races from 0 to 5, b/c our matlab code is dumb about zeroes */
recode race 0=5

keep year age sex race edclass cum* *mortrate
export delimited using $mdata/appended_rank_mort_ed3.csv, replace

exit
exit
exit
