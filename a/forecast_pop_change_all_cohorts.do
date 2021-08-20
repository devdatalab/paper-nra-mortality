/**********************************************************************************/
/* program get_missing_pop : Insert description here */
/***********************************************************************************/
cap prog drop get_missing_pop
prog def get_missing_pop, rclass
  syntax if/

  qui sum tpop_forecast_mort_only if year == 2015 & `if'
  local pred_pop_mort_only = `r(mean)'

  qui sum tpop_forecast_full if year == 2015 & `if'
  if `r(N)' != 0 {
    local pred_pop_full = `r(mean)'
  }

  qui sum tpop_lfit if year == 2015 & `if'
  local cps_pop = `r(mean)'

  local bias_mort_only: di %2.1f (100 * (`pred_pop_mort_only' - `cps_pop') / `pred_pop_mort_only')
  return local bias_mort_only = "`bias_mort_only'"

  if "`pred_pop_full'" != "" {
    local bias_full: di %2.1f (100 * (`pred_pop_full' - `cps_pop') / `pred_pop_full')
    return local bias_full = "`bias_full'"
    return local missing = round(`pred_pop_full' - `cps_pop')
  }
  else {
    return local missing = round(`pred_pop_mort_only' - `cps_pop')
  }
end
/* *********** END program get_missing_pop ***************************************** */

/* convert GED count estimates to Stata long format */
import delimited $mdata/raw/misc/ged-count.csv, clear

forval i =2/46 {
  local age = `i' + 23
  ren v`i' ged`age'
}

reshape long ged, j(age) i(year)

/* use global 2002-2009 statistics on passers to generate estimates for white female and white men */
global white_perc 0.62
global female_perc 0.42
gen ged_pass_2 = ged * $white_perc * $female_perc
gen ged_pass_1 = ged * $white_perc * (1 - $female_perc)

/* reshape by sex */
drop ged
reshape long ged_pass_, j(sex) i(year age)
ren ged_pass ged_passers

/* set race and education class */
gen race = 1
gen edclass = 1

drop if year == 1991

/* carryforward rolling mean for 2014 */
expand 2 if year == 2013, gen(new2014)
replace year = 2014 if new2014 == 1
drop new2014
egen g = group(age sex race edclass)
sort g year
xtset g year
replace ged_passers = (L.ged_passers + L2.ged_passers + L3.ged_passers + L4.ged_passers + L5.ged_passers) / 5 if year == 2014

/* then repeat the same numbers for 2015 */
expand 2 if year == 2014, gen(new2015)
replace year = 2015 if new2015 == 1
drop new2015 g

save $tmp/ged, replace

/********/
/* MAIN */
/********/
cap erase $tmp/bias.csv

/* which birth cohorts is this feasible for?

We're tracking CPS size from 1992 to 2015, and our study covers ages 25-69.

In 1992, 25-year-olds were born in 1967. 69-year-olds were born in 1923.
In 2015, 25-year-olds were born in 1990. 69-year-olds were born in 1946.

We want to follow a cohort for 25 years, from 1992 to 2015.
We need their mortality rate in every period.

We can't do a cohort any later than 1967, because we don't observe their
mortality rate in the early years.
- The 1967 cohort is 25 in 1992 and 48 in 2015

We can't do a cohort born any earlier than 1946, because we don't
observe their mortality in 2015 -- they're too old.
- The 1946 cohort is 46 in 1992 and 69 in 2015

We find that the difference gets larger over time. This means later
cohorts are shrinking too quickly.

If we examine mortality at a fixed age category, such as 45-year-olds,
we are slowly moving from the 1946 to the 1967 cohort.

*/

foreach bc in 1950 1960 {
  qui {
    /* last possible bc: 1967 */
    /* first possible bc: 1946 */
    global bc `bc'
    global bc_end = `bc' + 4
    global start_year 1992
    
    use $mdata/mort/nchs/appended_rank_mortgranage, clear

    /* only keep up to 2015 since GED data doesn't go past it */
    keep if year <= 2015
    
    /* bring in number of GED passers in this year */
    drop _merge
    merge 1:1 age edclass race sex year using $tmp/ged
    drop _merge

    /* create birth cohort variable */
    gen bc = year - age
    
    /* collapse to a five year birth cohort */
    keep if inrange(bc, $bc, $bc + 5)
    collapse (sum) tmort tpop_rolling ged_passers, by(edclass race sex year)
    replace ged_passers = . if ged_passers == 0
    
    gen tmortrate = tmort / tpop_rolling * 100000
    gen bc = $bc
    
    /* set time series on ed/race/sex/birth cohort */
    egen cohort = group(edclass race sex)
    sort cohort year
    xtset cohort year
    
    /* create a forecasted population based on mortality alone.  */
    /* start with a linear fit to the 1992 value (in case 1992 is an outlier) */
    gen y2 = year ^ 2

    reg tpop_rolling c.year##i.cohort 
    predict tpop_lfit
    
    /* forecast population from linear fit to 1992 going forward, just by cutting on mortality */
    gen tpop_forecast_mort_only = tpop_lfit if year == $start_year
    replace tpop_forecast_mort_only = L.tpop_forecast_mort_only * (1 - tmortrate / 100000) if year > $start_year

    /* forecast population change by dropping deaths and dropping geds */
    gen tpop_forecast_full = tpop_lfit if year == $start_year
    replace tpop_forecast_full = L.tpop_forecast_full * (1 - tmortrate / 100000) - ged_passers if year > $start_year
    
    /* review time series forecast of group size */
    get_missing_pop if bc == $bc & edclass == 1 & race == 1 & sex == 2
    append_to_file using $tmp/bias.csv, s(wf1,$bc,`r(bias_full)', `r(bias_mort_only)')
    noi disp_nice "wf1_$bc: Max bias is  `r(bias_full)'"
    store_constant using $out/mort_paper_stats, value(`r(bias_full)') desc("Max % bias -- white female dropout--$bc") category("CPS Synthetic Cohort Exercise") format(%2.1f)

    twoway ///
        (scatter tpop_rolling year          if bc == $bc & edclass == 1 & race == 1 & sex == 2, msymbol(S) color(gray)) ///
        (line tpop_lfit year        if bc == $bc & edclass == 1 & race == 1 & sex == 2, color(black) lpattern(".-")) ///
        (line tpop_forecast_mort_only year if bc == $bc & edclass == 1 & race == 1 & sex == 2, color("27 150 155") lpattern(dash)) ///
        (line tpop_forecast_full year if bc == $bc & edclass == 1 & race == 1 & sex == 2, color("169 11 61") lpattern(solid) lwidth(medthick)) ///
        , title("White Female ($bc-$bc_end birth cohorts)") ylabel(0(100000)700000) ///
        legend(lab(1 "CPS population") lab(2 "CPS population (linear trend)") lab(3 "Predicted CPS pop from just mortality") lab(4 "Predicted CPS pop from mortality and GED")) ///
        ytitle("Population without High School") xtitle("Year") ///
        ylabel(,format(%15.0fc) ) name(wf1_$bc, replace)  ///
        legend(order(1 2 3 4))
    // graphout wf1_$bc

    // /* repeat for men */
    get_missing_pop if bc == $bc & edclass == 1 & race == 1 & sex == 1
    append_to_file using $tmp/bias.csv, s(wm1,$bc,`r(bias_full)', `r(bias_mort_only)')
    noi disp_nice "wm1_$bc: Max bias is  `r(bias_full)'"
    store_constant using $out/mort_paper_stats, value(`r(bias_full)') desc("Max % bias -- white male dropout--$bc") category("CPS Synthetic Cohort Exercise") format(%2.1f)
    twoway ///
        (scatter tpop_rolling year          if bc == $bc & edclass == 1 & race == 1 & sex == 1, msymbol(S) color(gray)) ///
        (line tpop_lfit year        if bc == $bc & edclass == 1 & race == 1 & sex == 1, color(black) lpattern(".-")) ///
        (line tpop_forecast_mort_only year if bc == $bc & edclass == 1 & race == 1 & sex == 1, color("27 150 155") lpattern(dash)) ///
        (line tpop_forecast_full year if bc == $bc & edclass == 1 & race == 1 & sex == 1, color("169 11 61") lpattern(solid) lwidth(medthick)) ///
        , title("White Male ($bc-$bc_end birth cohorts)") ylabel(0(100000)700000) ///
        legend(lab(1 "CPS population") lab(2 "CPS population (linear trend)") lab(3 "Predicted CPS pop from just mortality") lab(4 "Predicted CPS pop from mortality and GED")) ///
        ytitle(Population without High School) xtitle("Year") ///
        ylabel(,format(%15.0fc) ) name(wm1_$bc, replace)  ///
        legend(order(1 2 3 4))
    //     graphout wm1_$bc

    /* repeat for edclass 2 */
    get_missing_pop if bc == $bc & edclass == 2 & race == 1 & sex == 2
    append_to_file using $tmp/bias.csv, s(wf2,$bc,`r(bias_mort_only)', `r(bias_mort_only)')
    noi disp_nice "wf2_$bc: Max bias is  `r(bias_mort_only)'"
    store_constant using $out/mort_paper_stats, value(`r(bias_mort_only)') desc("Max % bias -- white female HS--$bc") category("CPS Synthetic Cohort Exercise") format(%2.1f)
    twoway ///
        (scatter tpop_rolling year          if bc == $bc & edclass == 2 & race == 1 & sex == 2, msymbol(S) color(gray)) ///
        (line tpop_lfit year        if bc == $bc & edclass == 2 & race == 1 & sex == 2, color(black) lpattern(".-")) ///
        (line    tpop_forecast_mort_only year if bc == $bc & edclass == 2 & race == 1 & sex == 2, color("27 150 155") lpattern(dash)) ///
        , title("White Female ($bc-$bc_end birth cohorts)") ylabel(0(500000)4000000) ///
        legend(lab(1 "CPS population") lab(2 "CPS population (linear trend)") lab(3 "Predicted CPS pop from just mortality")) ///
        ytitle(Population without High School) xtitle("Year") ///
        ylabel(,format(%15.0fc) ) name(wf2_$bc, replace)  ///
        legend(order(1 2 3 4))
    //     graphout wf2_$bc

    // /* repeat for men */
    get_missing_pop if bc == $bc & edclass == 2 & race == 1 & sex == 1
    append_to_file using $tmp/bias.csv, s(wm2,$bc,`r(bias_mort_only)', `r(bias_mort_only)')
    noi disp_nice "wm2_$bc: Max bias is  `r(bias_mort_only)'"
    store_constant using $out/mort_paper_stats, value(`r(bias_mort_only)') desc("Max % bias -- white male HS--$bc") category("CPS Synthetic Cohort Exercise") format(%2.1f)
    twoway ///
        (scatter tpop_rolling year          if bc == $bc & edclass == 2 & race == 1 & sex == 1, msymbol(S) color(gray)) ///
        (line tpop_lfit year        if bc == $bc & edclass == 2 & race == 1 & sex == 1, color(black) lpattern(".-")) ///
        (line    tpop_forecast_mort_only year if bc == $bc & edclass == 2 & race == 1 & sex == 1, color("27 150 155") lpattern(dash)) ///
        , title("White Male ($bc-$bc_end birth cohorts)") ylabel(0(500000)4000000) ///
        legend(lab(1 "CPS population") lab(2 "CPS population (linear trend)") lab(3 "Predicted CPS pop from just mortality")) ///
        ytitle(Population without High School) xtitle("Year") ///
        ylabel(,format(%15.0fc) ) name(wm2_$bc, replace)  ///
        legend(order(1 2 3))
    //     graphout wm2_$bc

    // grc1leg wf1_$bc wf2_$bc wm1_$bc wm2_$bc
    // noi graphout cps_pred_all_$bc, pdf
    // noi di $bc
  }
}

/* create 4-panel graph for cutler -- 1950, 1960, women, men */
grc1leg wf1_1950  wf1_1960 wm1_1950 wm1_1960 
graphout cps_pred_all_r2, pdf
graphout cps_pred_all_dropout, pdf

grc1leg wf2_1950  wf2_1960 wm2_1950 wm2_1960 
graphout cps_pred_all_hs, pdf

exit
exit
exit

import delimited using $tmp/bias.csv, clear
ren v1 group
ren v2 bc
ren v3 bias_full
ren v4 bias_mort_only

keep if bc <= 1962

sort group bc
twoway ///
    (line bias_full bc if group == "wf1") ///
    (line bias_full bc if group == "wm1") ///
    (line bias_full bc if group == "wf2") ///
    (line bias_full bc if group == "wm2") ///
    , legend(lab(1 "white female dropout") lab(2 "white male dropout") lab(3 "white female HS") lab(4 "white male HS"))

graphout bias

/* create the paper stats web site  */
shell python $mcode/a/write_paper_stats.py

// example. mortality rises from 1000/100k to 1800/100k (80% gain). But cohort shrunk by 23.6%. True cohort size was 123600. So mortality at time 2 was 1456.

// short form: 80% growth (1.8) with 23.6% bias ->  1.8 / 1.236 = 1.46
