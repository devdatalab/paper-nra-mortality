/* get rank boundaries in 1992-94 and 2016-18 */
use $mdata/mort/nchs/appended_rank_mort, clear
list year edclass cum_ed_rank_sex if race == 0 & sex == 2 & age == 50 & inlist(year, 1992, 2018), sepby(year)
sort year sex race
list year sex race cum_ed_rank_sex if inlist(year, 1992, 1993, 1994) & age == 50 & edclass == 1, sepby(year)
replace year = 2016 if year > 2015
replace year = 1992 if year < 1995
keep if inlist(year, 1992, 2016)
collapse (mean) tmortrate cum_ed_rank_sex ed_rank_sex, by(edclass year race sex age)

/* show ed boundaries at age 50 */
keep if age == 50
sort year edc
list if race == 0 & sex == 1, sepby(year)
list if race == 0 & sex == 2, sepby(year)

keep if race == 0 & sex == 2 & (year >= 2016 | year < 1995) & age == 50
sort year edc

/* save a collapsed all race dataset for the example group */
use $mdata/mort/nchs/appended_rank_mort, clear
keep if race == 0 & sex == 2 & year >= 2016 & age == 50
collapse (mean) tmortrate cum_ed_rank_sex ed_rank_sex, by(edclass)

/* save the moments */
savesome tmortrate ed_rank_sex using $tmp/mort_2016_moments, replace

/* calculate the mu values for the intuitive examples in the paper */
list
qui bound_mort tmortrate, s(0)  t(10) gen(mu_0_10)
qui bound_mort tmortrate, s(0)  t(8) gen(mu_0_8)
qui bound_mort tmortrate, s(8)  t(10) gen(mu_8_10)
qui bound_mort tmortrate, s(8) t(37) gen(mu_8_37)
qui bound_mort tmortrate, s(10) t(37) gen(mu_10_37)
qui bound_mort tmortrate, s(30) t(37) gen(mu_30_37)
qui bound_mort tmortrate, s(37) t(40) gen(mu_37_40)
qui bound_mort tmortrate, s(10) t(40) gen(mu_10_40)
tabstat mu*, col(stats)
drop mu*

/* calculate p in each bin */
set obs 100
gen p = _n
gen lb = .
gen ub = .
qui forval p = 1/100 {
  local pm1 = `p' - 1
  bound_mort tmortrate if !mi(edclass), s(`pm1') t(`p') gen(foo)
  replace lb = `r(lb_1)' if p == `p'
  replace ub = `r(ub_1)' if p == `p'
}
drop foo*
gen f2 = 999
keep p lb ub f2
save $tmp/mort_cef_999, replace

/***************************/
/* calculate manski bounds */
/***************************/

/* collapse to 2016-2018 as one period */
use $mdata/mort/nchs/appended_rank_mort, clear
keep if race == 0 & sex == 2 & year >= 2016 & age == 50
collapse (mean) tmortrate cum_ed_rank_sex ed_rank_sex, by(edclass)

/* calculate set manski-tamer bounds */
tsset edclass
gen ub = tmortrate[_n-1]
gen lb = tmortrate[_n+1]
replace ub = 100000 if edclass == 1
replace lb =  0 if edclass == 4
keep edclass cum_ed_rank_sex lb ub
replace cum_ed_rank_sex = cum_ed_rank_sex * 100
ren cum_ed_rank_sex rank
gen x = 1
reshape wide rank lb ub, j(edclass) i(x)
drop x

expand 1000
gen p = _n / 10
gen lb = .
gen ub = .
foreach b in lb ub {
  replace `b' = `b'1 if inrange(p, 0, rank1)
  replace `b' = `b'2 if inrange(p, rank1, rank2)
  replace `b' = `b'3 if inrange(p, rank2, rank3)
  replace `b' = `b'4 if inrange(p, rank3, rank4)
}
keep p lb ub
gen f2 = 12345
replace p = p - 0.05
save $tmp/mort_cef_manski, replace


foreach v in 12 24 48 100000 {
  import delimited using $tmp/mort_cef_`v'.csv, clear
  ren v1 p
  ren v2 lb
  ren v3 ub
  gen f2 = `v'
  save $tmp/mort_cef_`v', replace
}

clear
foreach v in 12 24 48 100000 {
  append using $tmp/mort_cef_`v', 
}

/* add stata bounds and manski-tamer bounds */
append using $tmp/mort_cef_999
append using $tmp/mort_cef_manski
append using $tmp/mort_2016_moments

winsorize lb 0 2000, replace
winsorize ub 0 2000, replace

/* stretch all the bounds to solve off-by-one boundary issues */
bys f2: egen p_min = min(p)
bys f2: egen p_max = max(p)
replace p = (p - p_min) / (p_max - p_min) * 100
sort f2 p

/* smooth the curvature-constrained mus */
replace lb = (lb[_n-1] + lb + lb[_n+1]) / 3 if !mi(lb[_n-1]) & !mi(lb[_n+1]) & inrange(p, 1, 99)
replace ub = (ub[_n-1] + ub + ub[_n+1]) / 3 if !mi(ub[_n-1]) & !mi(ub[_n+1]) & inrange(p, 1, 99)

/* Panel A: manski (12345) vs. stata (999) */
twoway ///
    (rarea lb ub p if f2 == 12345, lcolor(black) ) ///
    (rarea lb ub p if f2 == 999, lcolor(black)) ///
    (rarea lb ub p if f2 == 12, color(gray) lcolor(black) ) ///
    (scatter tmortrate ed_rank_sex, msize(medsmall) color(black)) ///
    (scatteri 0 8  2000 8 , recast(line) lcolor(black) lpattern(-)) ///
    (scatteri 0 37 2000 37 , recast(line) lcolor(black) lpattern(-)) ///
    (scatteri 0 67 2000 67 , recast(line) lcolor(black) lpattern(-))  ///
    ,legend(order(1 2 3) lab(1 "Manski-Tamer (2002) bounds") lab(2 "NRA bounds (C = inf)") lab(3 "NRA bounds (C = 3)") lab(4 "Bin means"))

graphout mort_cef, pdf

// /* Panel A: manski (12345) vs. stata (999) */
// twoway ///
//     (rarea lb ub p if f2 == 48, lcolor(black)) ///
//     (rarea lb ub p if f2 == 24, lcolor(black)) ///
//     (rarea lb ub p if f2 == 12, color("120 102 35") lcolor(black) ) ///
//     (scatter tmortrate ed_rank_sex, msize(medsmall) color(black)) ///
//     (scatteri 0 8  2000 8 , recast(line) lcolor(black) lpattern(-)) ///
//     (scatteri 0 37 2000 37 , recast(line) lcolor(black) lpattern(-)) ///
//     (scatteri 0 67 2000 67 , recast(line) lcolor(black) lpattern(-))  ///
//     ,legend(order(3 2 1 4) lab(1 "NRA bounds (C = 4.8)") lab(2 "NRA bounds (C = 2.4)") lab(3 "NRA bounds (C = 1.2)") lab(4 "Bin means"))
// 
// graphout mort_cef_b
