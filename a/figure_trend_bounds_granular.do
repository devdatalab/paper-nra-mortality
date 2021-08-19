/* open Matlab solver results */
import delimited using $mdata/bounds/mort_bounds_all_granular_parallel.csv, clear

/* keep the standard time series spec only */
keep if ranktype == "sex" & spec == "mon" & target_name == "10-45-70" & f2 < 1

/* drop extraneous variables and sort for easy listing */
drop ranktype spec target_name f2
sort sex race edclass year

/* define looping categories */
global sex_list 1 2
global race_list 5 1 2 3
global ageset 25(5)65

/* smooth the trend */
egen g = group(age sex race edclass cause)
sort g year
xtset g year

qui foreach b in lb ub {
  replace mu_`b' = (L.mu_`b' + mu_`b' + F.mu_`b') / 3 if !mi(L.mu_`b') & !mi(F.mu_`b')
  replace mu_`b' = (L.mu_`b' + mu_`b') / 2 if mi(F.mu_`b')
  replace mu_`b' = (F.mu_`b' + mu_`b') / 2 if mi(L.mu_`b')
}

/* create a temporary sample variable */
gen sample = .

global ageset 25(5)65

/* loop over cause, age, sex, and race */
qui foreach cause in t d h {
  forval age = $ageset {
    local age_p4 = `age' + 4
    foreach sex in $sex_list {
      foreach race in $race_list {

        /* define graph labels */
        local sex1 "Men"
        local sex2 "Women"
        local race1 White
        local race2 Black
        local race3 Hispanic
        local race4 Other
        local race5 All

        replace sample = sex == `sex' & race == `race' & age == `age' & cause == "`cause'"
        
        /* note we need to add redundant top and bottom lines because Stata/16 ignores rarea:lwidth() */
        twoway ///
            (rarea mu_lb mu_ub year if sample & edclass == 1, lwidth(medthick) cmissing(no) color("0 0 0"))       ///
            (rarea mu_lb mu_ub year if sample & edclass == 2, lwidth(medthick) cmissing(no) color("50 100 50"))   ///
            (rarea mu_lb mu_ub year if sample & edclass == 3, lwidth(medthick) cmissing(no) color("100 180 100")) ///
            (rarea mu_lb mu_ub year if sample & edclass == 4, lwidth(medthick) cmissing(no) color("180 225 120")) ///
            (line  mu_lb       year if sample & edclass == 1, lwidth(medthick)              color("0 0 0"))       ///
            (line  mu_lb       year if sample & edclass == 2, lwidth(medthick)              color("40 80 40"))   ///
            (line  mu_lb       year if sample & edclass == 3, lwidth(medthick)              color("75 160 75")) ///
            (line  mu_lb       year if sample & edclass == 4, lwidth(medthick)              color("160 200 105")) ///
            (line        mu_ub year if sample & edclass == 1, lwidth(medthick)              color("0 0 0"))       ///
            (line        mu_ub year if sample & edclass == 2, lwidth(medthick)              color("40 80 40"))   ///
            (line        mu_ub year if sample & edclass == 3, lwidth(medthick)              color("75 160 75")) ///
            (line        mu_ub year if sample & edclass == 4, lwidth(medthick)              color("160 200 105")) ///
            , xlabel(1995(5)2015) xtitle("Year") ytitle("Deaths per 100,000") title("`race`race'' `sex`sex'', Age `age'-`age_p4'", size(medsmall) pos(12) ring(0)) ///
            legend(order(1 2 3 4) symxsize(5) symysize(0.5) size(vsmall) subtitle("Education Percentile", size(small) pos(12)) rows(2) lab(1 "0-10") lab(2 "10-45") lab(3 "45-70") lab(4 "70-100")) name(mon_bounds_`sex'_`race'_`age', replace) plotregion(margin(zero))

        /* graphout combine race only since it doesn't appear in the other ones */
        if `race' == 5 {
          graphout trend-granular-allrace-`cause'-`sex'-`age', pdf
        }
      }
    }
    grc1leg mon_bounds_2_1_`age'  mon_bounds_1_1_`age' mon_bounds_2_2_`age' mon_bounds_1_2_`age'  , rows(2) xcommon ycommon
    noi graphout trend-granular-mon-step-`cause'-sex-`age', pdf
  }
}
