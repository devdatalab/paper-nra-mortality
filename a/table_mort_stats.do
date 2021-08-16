/*****************************************************************/
/* convert mort stats output into a table_from_tpl readable file */
/*****************************************************************/

/* set the template output file */
global f $out/mort_stats.csv

/********************************************************/
/* calculate the stata monotonicity no-curvature bounds */
/********************************************************/
use $mdata/mort/nchs/appended_rank_mort, clear
keep if race == 0 & sex == 2 & (year >= 2016 | year < 1995) & age == 50
replace year = 2016 if year > 2015
replace year = 1992 if year < 1995
collapse (mean) tmortrate cum_ed_rank_sex ed_rank_sex, by(edclass year)
qui foreach year in 1992 2016 {

  /* p values */
  foreach p in 4 8 10 25 {
    local pm1 = `p' - 0.1
    local pp1 = `p' + 0.1
    bound_mort tmortrate if year == `year', s(`pm1') t(`pp1') gen(foo)
    local lb: di %5.1f (`r(lb_1)')
    local ub: di %5.1f (`r(ub_1)')
    insert_into_file using $f, key(p`p'_`year'_inf_lb) val(`lb') format(%5.1f)
    insert_into_file using $f, key(p`p'_`year'_inf_ub) val(`ub') format(%5.1f)
  }

  /* mu values */
  foreach mu in 8 16 20 50 {
    bound_mort tmortrate if year == `year', s(0) t(`mu') gen(foo)
    local lb: di %5.1f (`r(lb_1)')
    local ub: di %5.1f (`r(ub_1)')
    insert_into_file using $f, key(mu`mu'_`year'_inf_lb) val(`lb') format(%5.1f)
    insert_into_file using $f, key(mu`mu'_`year'_inf_ub) val(`ub') format(%5.1f)
  }
}

/*****************************/
/* import the matlab results */
/*****************************/
import delimited using $mdata/bounds/mort_bounds_sample_table.csv, clear

/* recode vars removing special characters */
replace f2 = round(f2 * 100)
replace spec = "mon" if spec == "mon-step"
replace target = subinstr(target, "-70", "", .)
gen start = substr(target, 1, strpos(target, "-") - 1)
replace target = "p" + start if inlist(start, "10", "25", "4") | target == "8-9"
replace target = "mu" + start if substr(target, 1, 1) != "p"

/* loop over all specs */
levelsof target_name, local(targets)
foreach target in `targets' {
  foreach year in 1992 2016 {
    foreach f2 in 3 {
      foreach spec in mon nomon {

        /* write 'em to the estimates file */
        global f $out/mort_stats.csv

        /* write lower bound */
        qui sum mu_lb if target_name == "`target'" & year == `year' & f2 == `f2' & spec == "`spec'"
        assert `r(N)' == 1
        local b: di %5.1f (`r(mean)')
        insert_into_file using $f, key(`target'_`year'_`f2'_`spec'_lb) val(`b') format(%5.1f)

        /* write upper bound */
        qui sum mu_ub if target_name == "`target'" & year == `year' & f2 == `f2' & spec == "`spec'"
        assert `r(N)' == 1
        local b: di %5.1f (`r(mean)')
        insert_into_file using $f, key(`target'_`year'_`f2'_`spec'_ub) val(`b') format(%5.1f)
      }
    }
  }
}

/* create the table */
table_from_tpl, t($mcode/a/tpl/table_mort_stats_1992.tpl) r($f) o($out/table_mort_stats_1992.tex)
table_from_tpl, t($mcode/a/tpl/table_mort_stats_2016.tpl) r($f) o($out/table_mort_stats_2016.tex)


