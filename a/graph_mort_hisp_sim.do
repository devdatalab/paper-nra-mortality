insheet using $mdata/bounds/hisp_sim.csv, clear names

destring shift mu* year sex, replace force
drop if mi(shift)
keep if shift < .21


/* drop duplicates which can arise if the matlab is run multiple times or in parallel */
duplicates drop sex year shift, force

gen tmp_lb = mu_lb if year == 1992
gen tmp_ub = mu_ub if year == 1992
bys sex: egen mu_lb_1992 = max(tmp_lb)
bys sex: egen mu_ub_1992 = max(tmp_ub)
drop tmp_lb tmp_ub

drop if year == 1992

gen change_lb = mu_lb - mu_ub_1992
gen change_ub = mu_ub - mu_lb_1992
replace shift = shift * 100

sort year shift

twoway rarea change_lb change_ub shift if sex == 1, xtitle("Percent Hispanics Reallocated" "to WNH in 2016-2018") ///
  ytitle("Mortality Change 1992-94 to 2016-18" "Deaths per 100,000") ylabel(0(100)1000) lcolor(black) color(gs8)
graphout hisp_shift_1, pdf

twoway rarea change_lb change_ub shift if sex == 2, xtitle("Percent Hispanics Reallocated" "to WNH in 2016-2018") ///
  ytitle("Mortality Change 1992-94 to 2016-18" "Deaths per 100,000") ylabel(0(100)1000) lcolor(black) color(gs8)
graphout hisp_shift_2, pdf
