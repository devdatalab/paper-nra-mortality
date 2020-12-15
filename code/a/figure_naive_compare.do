/* goal: compare naive mortality change to bounds on mortality change */

/* 0. identify bin boundaries for the naive graphs -- as close to 1992 boundaries as possible. */
use $mdata/appended_rank_mort, clear
egen year_bin = cut(year), at(1992(3)2019)
collapse (mean) tpop_rolling tmort *rate ed_rank_* cum_ed_rank_*, by(year_bin age sex race edclass)
ren year_bin year

list edclass cum_ed_rank_sex if year == 1992 & sex == 2 & race == 1 & age == 45
list edclass cum_ed_rank_sex if year == 1992 & sex == 2 & race == 1 & age == 50

/* 1. open naive tmortrate estimates for some group from 1992 to 2018 */
use $mdata/appended_rank_mort, clear
keep year sex race age edclass tmortrate dmortrate cum_ed_rank_sex

/* collapse into 3-year means */
egen ycut = cut(year), at(1992(3)2019)
collapse (mean) *rate cum_ed_rank_sex, by(ycut sex race age edclass)
ren ycut year
list year edc tmortrate if inlist(edc, 1) & age == 50 & sex == 2 & race == 0 & inlist(year, 1992, 2016)

/* calculate changes since 1992 */
global group sex race age edclass
gen ttmp = tmortrate if year == 1992
gen dtmp = dmortrate if year == 1992
bys $group: egen tbaserate = max(ttmp)
bys $group: egen dbaserate = max(dtmp)
gen tmort_change = tmortrate / tbaserate
gen dmort_change = dmortrate / dbaserate

sort year
list year tmortrate tmort_change if edclass == 1 & sex == 1 & race == 1 & age == 25
list year dmortrate dmort_change if edclass == 1 & sex == 2 & race == 1 & age == 50
ren age_gp age

recode race 0=5

save $tmp/rawmort, replace

/* 2. prepare bounds estimates from our standard approach */
use $mortality/mort_bounds_all, clear
keep if spec == "mon" & f2 < 1 & ranktype == "sex"

drop mu_s mu_t
keep year sex race age edclass mu_lb mu_ub cause target
keep if inlist(cause, "total", "despair")

/* reshape wide on cause */
reshape wide mu_lb mu_ub, j(cause) i(year sex race age edclass target) string
ren mu_*despair *d
ren mu_*total *t

/* calculate changes from 1992 to each point */

foreach b in ub lb {
  gen ttmp_`b' = `b't if year == 1992
  gen dtmp_`b' = `b'd if year == 1992
  bys $group target: egen base_`b't = max(ttmp_`b')
  bys $group target: egen base_`b'd = max(dtmp_`b')
}

gen tchange_ub = ubt / base_lbt
gen tchange_lb = lbt / base_ubt
gen dchange_ub = ubd / base_lbd
gen dchange_lb = lbd / base_ubd

sort year
list year lbt ubt tchange_lb tchange_ub if edclass == 1 & sex == 2 & race == 1 & age == 50
list year lbt ubt tchange_lb tchange_ub if edclass == 1 & sex == 2 & race == 1 & age == 50

save $tmp/bounds, replace

/* 3. merge the two datasets -- m:1 because we have many target lists in the master dataset */
use $tmp/bounds, clear
merge m:1 year sex race age edclass using $tmp/rawmort, keep(match)
drop *tmp*

/* rescale percent change to be in 100s */
foreach v in tmort_change tchange_lb tchange_ub {
  replace `v' = (`v' - 1) * 100
}

/* plot the naive vs. bounded graphs */
foreach race in 1 2 5 {
  foreach cause in t d {
    foreach ed in 1 2 {
      foreach age in 50 {
        foreach sex in 1 2 {
          local target250 17-60-81
          local target150 17-52-73
          local sex1 men
          local sex2 women

          /* set ylabel differently for all race graph (which can be tighter, without all the
          other comparisons) */
          if `race' == 5 local ylabel -25(25)50
          if inlist(`race', 1, 2) local ylabel -50(50)150
          
          twoway ///
              (scatter `cause'mort_change year if target == "`target`sex'`age''" & race == `race' & sex == `sex' & edclass == `ed' & age == `age', msize(medlarge))  ///
              (rcap `cause'change_lb `cause'change_ub year if target == "`target`sex'`age''" & race == `race' & sex == `sex' & edclass == `ed' & age == `age', lwidth(thick)) ///
              , ylabel(`ylabel', labsize(large)) xlabel(, labsize(large)) legend(size(large) ring(0) pos(11) lab(1 "Unadjusted") lab(2 "Constant Rank")) xtitle("Year", size(large)) ytitle("% Mortality Change", size(large)) yline(0, lpattern(dash) lcolor(gs8))
          graphout naive-`race'-`sex`sex''-`age'-`cause'-`ed', pdf
        }
      }
    }
  }
}

