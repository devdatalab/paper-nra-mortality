/**************************************************************/
/* - calculates overall mortality using standardized population */
/* - also calculates some average stats referenced in paper/abstract */
/**************************************************************/
global std $mdata/int

/*************************************/
/* prep standardized u.s. population */
/*************************************/
insheet using  $mdata/raw/misc/std-pop-us-2000-1.csv, clear names
ren uss pop
drop v3
drop if mi(age)

replace pop = subinstr(pop, ",", "", .)
replace age = subinstr(age, " years", "", .)
replace age = "100" if age == "100+"
destring *, replace

/* save up to age 79 */
drop if age > 79

ren pop std_pop

save $std/std-pop-79-1, replace

/* save up to age 69 */
drop if age > 69

save $std/std-pop-69-1, replace

/* repeat for 5-year standards */
insheet using  $mdata/raw/misc/std-pop-us-2000-5.csv, clear names
keep age std2000tot
ren std pop

replace pop = subinstr(pop, ",", "", .)
replace age = regexs(1) if regexm(age, "([0-9][0-9])\+?-?[0-9]?[0-9]? years")
drop if age == "Total"
destring pop age, replace
ren pop std_pop

/* save up to age 79 */
drop if age > 75
save $std/std-pop-79-5, replace

/* save up to age 69 */
drop if age > 65
save $std/std-pop-69-5, replace

/*************************************************************************/
/* create age-adjusted mortality rates from standardized u.s. population */
/*************************************************************************/
use $mdata/mort/nchs/appended_rank_mortgranage, clear
drop _merge

merge m:1 age using $std/std-pop-79-1
keep if inrange(age, 25, 74)
assert _merge == 3
drop _merge
save $tmp/foo, replace

sort age year
// list year age tmortrate if inlist(year, 1992, 2015) & race == 1 & sex == 2 & edclass == 1, sepby(age)

/* get standardized mortality rates */
collapse (mean) tmortrate dmortrate [aw=std_pop], by(sex race edclass year)
// list if inlist(year, 1992, 2015) & race == 1 & sex == 2, sepby(edclass)
save $std/mort_std_1_25_74, replace

/* repeat using death rates up to age 69 */
use $tmp/foo, clear
keep if age <= 69
collapse (mean) tmortrate dmortrate [aw=std_pop], by(sex race edclass year)
// list if inlist(year, 1992, 2015) & race == 1 & sex == 2, sepby(edclass)
save $std/mort_std_1_25_69, replace

/* repeat using 5-year death rates */
use $mdata/mort/nchs/appended_rank_mort, clear
drop _merge
ren age_gp age
merge m:1 age using $std/std-pop-79-5
keep if inrange(age, 25, 74)
assert _merge == 3
drop _merge
keep if age <= 69
collapse (mean) tmortrate dmortrate [aw=std_pop], by(sex race edclass year)
// list if inlist(year, 1992, 2015) & race == 1 & sex == 2, sepby(edclass)
save $std/mort_std_5_25_69, replace

/****************************************************************************/
/* create standardized mortality bounds using U.S. standard population 2000 */
/****************************************************************************/
use $mdata/int/bounds/mort_changes_all, clear

keep if inlist(cause, "total", "despair")
keep if ranktype == "sex" & target == "10-45-70" & spec == "mon" & f2 < 1

/* get standardized population */
merge m:1 age using $std/std-pop-79-5
keep if _merge == 3
drop _merge

/* collapse mortality bounds across ages, weighting by standard population */
collapse (mean) lb_1992 ub_1992 lb_2016 ub_2016 [aw=std_pop], by(sex race edclass cause)

/* calculate upper and lower bounds on changes */
gen change_ub = ub_2016 / lb_1992 - 1
gen change_lb = lb_2016 / ub_1992 - 1
format change* %5.2f

/* save standardized rates */
save $std/mort_bounds_std_pop, replace

/* export rates for total mortality only */
keep if cause == "total"
sort race sex edclass 

global f $out/std_mort_table.csv
cap erase $f

local r1 White
local r2 Black
local s1 Men
local s2 Women

/* write header line */
append_to_file using $f, s(",0-10th,10th-45th,45th-70th,70th-100th")

foreach race in 1 2 {
  
  foreach sex in 2 1 {

    local s `r`race'' `s`sex''
    
    forval ed = 1/4 {

      sum change_lb if race == `race' & sex == `sex' & edclass == `ed'
      local lb: di %1.0f `r(mean)' * 100
      if `r(mean)' > 0 local lb +`lb'
      sum change_ub if race == `race' & sex == `sex' & edclass == `ed'
      local ub: di %1.0f `r(mean)' * 100
      if `r(mean)' > 0 local ub +`ub'

      local s `"`s',"(`lb'%, `ub'%)""'
      di `"`s'"'
    }
    append_to_file using $f, s(`"`s'"')
  }
}

cat $f


/*********************************************/
/* calculate summary statistics for abstract */
/*********************************************/
use $mdata/mort/nchs/appended_rank_mort, clear

/* collapse to get total deaths, total population */
collapse (sum) tmort tpop_rolling, by(sex)
format tpop tmort %10.0f
gen rate = tmort / tpop * 100000

// /* get average age */
// use $mdata/mort/nchs/appended_rank_mortgranage, clear
// 
// keep if inrange(age, 25, 69)
// 
// /* collapse over everything but age */
// collapse (sum) tpop_rolling, by(age sex)
// 
// sum age if sex == 0 [aw=tpop]


/**********************************************/
/* compare standardized unadjusted and bounds */
/**********************************************/

/* get unadjusted change from 1992-94 to 2016-18 */
use $std/mort_std_5_25_69, clear
drop if inrange(year, 1995, 2015)
keep if inrange(race, 1, 2) & inrange(sex, 1, 2)

/* reshape wide by years */
reshape wide tmortrate dmortrate, j(year) i(edclass sex race)

/* get 3-year means for start and finish periods */
foreach t in t d {
  egen mort_start_`t' = rowmean(`t'mortrate1992 `t'mortrate1993 `t'mortrate1994)
  egen mort_end_`t'   = rowmean(`t'mortrate2016 `t'mortrate2017 `t'mortrate2018)
}
drop dmort* tmort*

reshape long mort_start mort_end, string j(cause) i(edclass sex race)

replace cause = "despair" if cause == "_d"
replace cause = "total"   if cause == "_t"

save $std/mort_std, replace

/* merge with bounds */
merge 1:1 edclass sex race cause using $std/mort_bounds_std_pop, 
assert _merge == 3 if inlist(race, 1, 2)
keep if _merge == 3
drop _merge

/* generate changes in percentage points and percentages */
ren change_ub change_perc_ub
ren change_lb change_perc_lb
gen change_perc = mort_end / mort_start - 1
gen change_pp   = mort_end - mort_start

gen change_pp_lb = ub_2016 - lb_1992
gen change_pp_ub = lb_2016 - ub_1992

/* rescale so these are percents */
replace change_perc_lb = change_perc_lb * 100
replace change_perc_ub = change_perc_ub * 100
replace change_perc = change_perc * 100
format change_perc_lb change_perc_ub %1.0f

/* graph changes in bounds vs. point estimates */

/* percentage points */
foreach race in 1 2 {
  foreach sex in 1 2 {
    foreach cause in total /* despair */ {
      local race1 "White"
      local race2 "Black"
      local sex1 "men"
      local sex2 "women"

      capdrop sample
      gen sample = race == `race' & sex == `sex' & cause == "`cause'"
      twoway ///
          (scatter change_perc edclass if sample)               ///
          (rcap change_perc_lb change_perc_ub edclass if sample, lwidth(medthick)) ///
          , ///
        title("`race`race'' `sex`sex''") ///
        legend(rows(2) lab(1 "Mortality in Naive Education Levels") lab(2 "Mortality in Constant Education Percentiles") ) xtitle("Education Group") ytitle("Percent Change in Mortality") name(perc_`cause'`sex'`race', replace)
      graphout std_mort_perc_`cause'_`race'_`sex'

//      twoway ///
//        (rcap change_pp_lb change_pp_ub edclass if sample) ///
//        (scatter change_pp edclass if sample) ,              ///
//        title("`race`race'' `sex`sex''") ///
//        legend(off) xtitle("Education Group") ytitle("Percentage Point Change") name(pp_`cause'`sex'`race', replace)
//      graphout std_mort_pp_`cause'_`race'_`sex'
    }
  }
}

/* use a separate scale for each type */
graph combine perc_total21 perc_total11 perc_total22 perc_total12, xcommon ycommon rows(2) 
grc1leg perc_total21 perc_total11 perc_total22 perc_total12, xcommon ycommon rows(2) 
graphout std_mort_perc_total, pdf

/***************************************************/
/* create age-adjusted all-cause mortality changes */
/***************************************************/
use $mdata/int/bounds/mort_changes_all, clear
keep if ranktype == "sex" & target == "10-45-70" & spec == "mon" & f2 < 1

/* get standardized population */
merge m:1 age using $std/std-pop-79-5
keep if _merge == 3
drop _merge

/* collapse bounds */
bys sex race edclass cause: assert _N == 9
collapse (mean) lb_1992 ub_1992 lb_2016 ub_2016 [aw=std_pop], by(sex race edclass cause)

/* generate bounds on changes */
gen change_ub = ub_2016 / lb_1992 - 1
gen change_lb = lb_2016 / ub_1992 - 1
format change* %5.2f

/* save standardized rates for all causes */
save $std/mort_all_cause_std_pop, replace

/* export a table with all these changes */
global f $out/std_mort_table_all_cause.csv
cap erase $f

use $std/mort_all_cause_std_pop, clear
replace cause = substr(cause, 1, 1)

foreach race in 1 2 {
  local race1 white
  local race2 black
  foreach sex in 2 1 {
    local sex1 male
    local sex2 female
    forval ed = 1/4 {
      foreach cause in a c d h o t {
        di "`race'-`sex'-`ed'-`cause'"
        /* write bounds for this entry */
        qui sum change_lb if race == `race' & sex == `sex' & edclass == `ed' & cause == "`cause'"
        local lb: di %1.0f `r(mean)' * 100
        if `r(mean)' > 0 local lb +`lb'

        qui sum change_ub if race == `race' & sex == `sex' & edclass == `ed' & cause == "`cause'"
        local ub: di %1.0f `r(mean)' * 100
        if `r(mean)' > 0 local ub +`ub'
  
        local s "(`lb'\%, `ub'\%)"
        local s2 "[`lb'% to `ub'%]"
        append_to_file using $f, s("m`sex'`race'`ed'`cause',`s'")

        /* append total mortality to the html paper stats file */
        if "`cause'" == "t" {
          store_constant using $out/mort_paper_stats, value("`s2'") desc("`race`race'' `sex`sex'' ed`ed'") category("Age-Adjusted all-age Mortality Change %") format(string)
        }
      }
    }
  }
}

/* table a2 (AEJ sub 1): Age-Adjusted Changes in Mortality by Education Percentile and Cause */
table_from_tpl, o($out/all_cause_std.tex) r($f) t($mcode/a/tpl/all_cause_std.tpl)

/* table 1 (AEJ sub 1): Age-Adjusted Changes in All-Cause Mortality
   by Education Percentile, 1992--94 – 2015--2018 */
table_from_tpl, o($out/age_adjusted_all_cause.tex) r($f) t($mcode/a/tpl/age_adjusted_all_cause.tpl)

/* write paper stats */
shell python $mcode/a/write_paper_stats.py
