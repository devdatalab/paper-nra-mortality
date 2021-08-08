/***********************************************************************************************/
/* GOAL: take year-level mort bounds and reshape to wide years with bounds on 1992-2018 change */
/***********************************************************************************************/

/* open the CSV with all the matlab-generated bounds */
import delimited using $mdata/int/bounds/mort_bounds_all_parallel.csv, clear 

/* assign longer names to causes */
replace cause = "total" if cause == "t"
replace cause = "despair" if cause == "d"
replace cause = "cancer" if cause == "c"
replace cause = "heart" if cause == "h"
replace cause = "accident" if cause == "a"
replace cause = "other" if cause == "o"
replace cause = "nondesp" if cause == "n"

/* save master bounds file in Stata format */
save $mdata/int/bounds/mort_bounds_all, replace

/*********************************************/
/* prep data for the all-cause all-age graph */
/*********************************************/
keep if inlist(year, 1992, 2013, 2016)

/* generate upper and  lower bound changes  */

/* create a "total mortality" variable that lives in all rows, for comparison with other causes */
gen tmort_mu_lb = mu_lb if cause == "total"
gen tmort_mu_ub = mu_ub if cause == "total"
egen group = group(year age sex race edclass spec ranktype f2 target)
bys group: assert _N <= 7
xfill tmort_mu_*, i(group)
drop group

/* reshape years to wide */
reshape wide *mu_lb *mu_ub, j(year) i(cause age sex race edclass spec ranktype f2 target)
ren *mu_*b* **b_*

/* calculate bounds on mortality change */
gen change_lb = lb_2016 - ub_1992
gen change_ub = ub_2016 - lb_1992

/* normalize change so that total mortality in 1992 is equal to 100 */
gen norm_change_lb = change_lb / tmort_ub_1992 * 100
gen norm_change_ub = change_ub / tmort_lb_1992 * 100

/* repeat for change to 2013, to compare with prior paper submission */
gen change_2013_lb = lb_2013 - ub_1992
gen change_2013_ub = ub_2013 - lb_1992
gen norm_change_2013_lb = change_2013_lb / tmort_ub_1992 * 100
gen norm_change_2013_ub = change_2013_ub / tmort_lb_1992 * 100

/* sort and format */
sort race sex cause age edclass spec ranktype target f2 
format change* ?b* %5.0f

save $mdata/int/bounds/mort_changes_all, replace
