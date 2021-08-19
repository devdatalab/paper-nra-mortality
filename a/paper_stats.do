/* function to get mortality change */
cap prog drop get_mort_change
prog def get_mort_change, rclass
  syntax, ed(integer) sex(integer) race(integer) age(integer) [cause(string) norm]

  if mi("`cause'") local cause total
  
  foreach year in 1992 2016 {
    foreach b in lb ub {
      
      /* store mortality upper or lower bound in this year */
      qui sum mu_`b' if ed == `ed' & sex == `sex' & race == `race' & age == `age' & year == `year' & cause == "`cause'"
      assert r(N) == 1
      local `b'_`year' `r(mean)'
    }
  }

  /* calculate % change */
  local lb: di %5.1f ((`lb_2016' / `ub_1992' - 1) * 100)
  local ub: di %5.1f ((`ub_2016' / `lb_1992' - 1) * 100)

  /* return the bounds */
  return local lb = `lb'
  return local ub = `ub'
end

/*******************************************/
/* edclass boundaries for different groups */
/*******************************************/

/* education bin boundaries 1 and 2 in 1992 and 2018 */
global f $out/mort_paper_stats
// cap erase $f.csv
global cumrank "Bin Percentile Boundaries -- Single years -- Combined races"
global mort    "Mortality At Ed LEVELS -- Single years -- Combined races"

use $mdata/mort/nchs/appended_rank_mort, clear
keep if race == 0
foreach year in 1992 2018 {
  foreach sex in 1 2 {
    local sex1 "men"
    local sex2 "women"

    foreach age in 40 50 {
      
      /* end of edclass bin boundary 1 */
      qui sum cum_ed_rank_sex if  sex == `sex' & age == `age' & year == `year' & edclass == 1
      assert `r(N)' == 1
      store_constant using $f, value(`r(mean)') desc("Ed1-2 - `year' - `sex`sex'' - age `age'") category("$cumrank") format(%6.3f)
  
      /* end of edclass bin boundary 2 */
      qui sum cum_ed_rank_sex if  sex == `sex' & age == `age' & year == `year' & edclass == 2
      assert `r(N)' == 1
      store_constant using $f, value(`r(mean)') desc("Ed2-3 - `year' - `sex`sex'' - age `age'") category("$cumrank") format(%6.3f)
  
      /* end of edclass bin boundary 1 */
      qui sum cum_ed_rank_sex if  sex == `sex' & age == `age' & year == `year' & edclass == 3
      assert `r(N)' == 1
      store_constant using $f, value(`r(mean)') desc("Ed3-4 - `year' - `sex`sex'' - age `age'") category("$cumrank") format(%6.3f)
  
      /* mortality in each bin */
      foreach ed in 1 2 3 4 {
        qui sum tmortrate if  sex == `sex' & age == `age' & year == `year' & edclass == `ed'
        assert `r(N)' == 1
        store_constant using $f, value(`r(mean)') desc("Ed`ed' - `year' - `sex`sex'' - age `age'") category("$mort") format(%6.3f)
      }
    }
  }
}

/* open the 3-bin dataset */
use $tmp/appended_rank_mort_3, clear
recode race 5=0
keep if inlist(age, 40, 50) & race == 0

global cumrank "Bin Percentile Boundaries -- Sets of 3 years combined race"
global mort    "Mortality At Ed LEVELS -- Sets of 3 years combined race"

foreach year in 1992 2016 {
  foreach sex in 1 2 {
    local yp2 = `year' + 2
    local sex1 "men"
    local sex2 "women"
    foreach age in 40 50 {
      
      /* end of edclass bin boundary 1 */
      qui sum cum_ed_rank_sex if  sex == `sex' & age == `age' & year == `year' & edclass == 1
      assert `r(N)' == 1
      store_constant using $f, value(`r(mean)') desc("Ed1-2 - `year'-`yp2' - `sex`sex'' - age `age'") category("$cumrank") format(%6.3f)
  
      /* end of edclass bin boundary 2 */
      qui sum cum_ed_rank_sex if  sex == `sex' & age == `age' & year == `year' & edclass == 2
      assert `r(N)' == 1
      store_constant using $f, value(`r(mean)') desc("Ed2-3 - `year'-`yp2' - `sex`sex'' - age `age'") category("$cumrank") format(%6.3f)
  
      /* end of edclass bin boundary 1 */
      qui sum cum_ed_rank_sex if  sex == `sex' & age == `age' & year == `year' & edclass == 3
      assert `r(N)' == 1
      store_constant using $f, value(`r(mean)') desc("Ed3-4 - `year'-`yp2' - `sex`sex'' - age `age'") category("$cumrank") format(%6.3f)
      
      /* mortality in each bin */
      foreach ed in 1 2 3 4 {
        qui sum tmortrate if  sex == `sex' & age == `age' & year == `year' & edclass == `ed'
        assert `r(N)' == 1
        store_constant using $f, value(`r(mean)') desc("Ed`ed' - `year'-`yp2' - `sex`sex'' - age `age'") category("$mort") format(%6.3f)
      }
    }
  }
}

/* same thing, 3-year-bins, split by race */
use $tmp/appended_rank_mort_3, clear
keep if inlist(age, 40, 50)
global mort    "Mortality At Ed LEVELS -- 3-year bins by race"
foreach year in 1992 2016 {
  foreach race in 1 2 5 {
    local race1 "white"
    local race2 "black"
    local race5 "all races"
    foreach sex in 1 2 {
      local yp2 = `year' + 2
      local sex1 "men"
      local sex2 "women"
      foreach age in 40 50 {

        /* mortality in each bin */
        foreach ed in 1 2 3 4 {
          qui sum tmortrate if  sex == `sex' & race == `race' & age == `age' & year == `year' & edclass == `ed'
          assert `r(N)' == 1
          store_constant using $f, value(`r(mean)') desc("Ed`ed' - `year'-`yp2' - `race`race'' `sex`sex'' - age `age'") category("$mort") format(%6.3f)
        }
      }
    }
  }
}

/* raw mortality changes */
foreach race in 1 2 5 {
  foreach sex in 1 2 {
    foreach ed in 1 2 3 4 {
      qui sum tmortrate if sex == `sex' & race == `race' & age == 50 & year == 1992 & edclass == `ed'
      assert `r(N)' == 1
      local start `r(mean)'
      
      qui sum tmortrate if sex == `sex' & race == `race' & age == 50 & year == 2016 & edclass == `ed'
      assert `r(N)' == 1
      local end `r(mean)'

      /* calculate mortality change */
      local change: di %6.1f (((`end' / `start') - 1) * 100)
      store_constant using $f, value(`change') desc("`race`race'' `sex`sex'' ed level `ed' age 50") category("% Change in ed LEVEL mortality")

      /* annualize the change */
      local ann_change: di %5.1f ((`change'/100+1)^(1/24) - 1) * 100
      store_constant using $f, value(`ann_change') desc("`race`race'' `sex`sex'' ed level `ed' age 50") category("Annualized % Change in ed LEVEL mortality")
    }
  }
}

/* bounds on mortality age 50--54 */
use $mdata/int/bounds/mort_bounds_all, clear
keep if target == "10-45-70" & spec == "mon" & f2 < 1 & cause == "total" & inlist(age, 40, 50) & ranktype == "sex"
foreach sex in 1 2 {
  foreach race in 1 2 {
    foreach edclass in 1 2 3 4 {
      foreach age in 40 50 {
        foreach year in 1992 2016 {
          foreach b in lb ub {
  
            /* store mortality upper or lower bound in this year */
            qui sum mu_`b' if ed == `edclass' & sex == `sex' & race == `race' & year == `year' & age == `age'
            local `b'_`year' `r(mean)'
            assert r(N) == 1
          }
          
          local s: di "[" %2.0f (`lb_`year'') " ... " %2.0f (`ub_`year'') "]"
          store_constant using $f, value("`s'") desc("`year' `race`race'' `sex`sex'' ed`edclass' age `age'") category("Mortality Bounds in 1992-94 and 2016-18") format(string)
        }
  
        /* calculate and store bounds on % mort change */
        local lb: di %5.1f ((`lb_2016' / `ub_1992' - 1) * 100)
        local ub: di %5.1f ((`ub_2016' / `lb_1992' - 1) * 100)
        local s: di "[" %2.1f (`lb') " ... " %2.1f (`ub') "]"
        
        store_constant using $f, value("`s'") desc("`race`race'' `sex`sex'' ed`edclass' age `age'") category("Mortality Change Bounds 1992-94 to 2016-18") format(string)
      }
    }
  }
}

/* get a few more changes that we name in the text */
use $mdata/int/bounds/mort_bounds_all, clear
keep if target == "10-45-70" & spec == "mon" & f2 < 1 & ranktype == "sex"

/* white men age 25, bin 2 */
get_mort_change, ed(2) sex(1) race(1) age(25)
local s: di "[" %2.1f (`r(lb)') " ... " %2.1f (`r(ub)') "]"
store_constant using $f, value("`s'") desc("total white men ed2 Age 25") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)

/* white women age 25, bin 2 */
get_mort_change, ed(2) sex(2) race(1) age(25)
local s: di "[" %2.1f (`r(lb)') " ... " %2.1f (`r(ub)') "]"
store_constant using $f, value("`s'") desc("total white women ed2 Age 25") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)

/* white women, age 25, bin 1, by cause */
get_mort_change, ed(1) sex(2) race(1) age(25) cause(despair)
local s: di "[" %2.1f (`r(lb)') " ... " %2.1f (`r(ub)') "]"
store_constant using $f, value("`s'") desc("despair white women ed1 Age 25") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)

/* white women age 25, bin 1, non-despair */
get_mort_change, ed(1) sex(2) race(1) age(25) cause(nondesp)
local s: di "[" %2.1f (`r(lb)') " ... " %2.1f (`r(ub)') "]"
store_constant using $f, value("`s'") desc("non-despair white women ed1 Age 25") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)

/* all women, age 50, bins 1 and 2, 1992 boundaries (figure 4 naive comparison) */
use $mdata/int/bounds/mort_bounds_all, clear
keep if target == "17-60-81" & spec == "mon" & f2 < 1 & ranktype == "sex"
get_mort_change, ed(1) sex(2) race(5) age(50) cause(total)
local s: di "[" %2.1f (`r(lb)') " ... " %2.1f (`r(ub)') "]"
store_constant using $f, value("`s'") desc("all women ed1 Age 50--1992 bins--s3.4") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)
get_mort_change, ed(2) sex(2) race(5) age(50)
local s: di "[" %2.1f (`r(lb)') " ... " %2.1f (`r(ub)') "]"
store_constant using $f, value("`s'") desc("all women ed2 Age 50--1992 bins--s3.4") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)

/* mortality attributable to despair -- 25-yr white women ed1 */
use $mdata/int/bounds/mort_changes_all, clear
keep if target == "10-45-70" & spec == "mon" & f2 < 1 & ranktype == "sex"
sum norm_change_lb if ed == 1 & sex == 2 & race == 1 & age == 25 & cause == "despair"
assert r(N) == 1
local lb: di %2.1f `r(mean)'
sum norm_change_ub if ed == 1 & sex == 2 & race == 1 & age == 25 & cause == "despair"
local ub: di %2.1f `r(mean)'
local s: di "[`lb' ... `ub']"
store_constant using $f, value("`s'") desc("despair -- normalized to total -- white women ed1 Age 25") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)

/* mortality attributable to non-despair -- 25-yr white women ed1 */
sum norm_change_lb if ed == 1 & sex == 2 & race == 1 & age == 25 & cause == "nondesp"
assert r(N) == 1
local lb: di %2.1f `r(mean)'
sum norm_change_ub if ed == 1 & sex == 2 & race == 1 & age == 25 & cause == "nondesp"
local ub: di %2.1f `r(mean)'
local s: di "[`lb' ... `ub']"
store_constant using $f, value("`s'") desc("non-despair -- normalized to total -- white women ed1 Age 25") category("Selected Mortality Change Bounds 1992-94 to 2016-18") format(string)


shell python $mcode/a/write_paper_stats.py


exit
exit
exit

/***********************************/
/* paper stats not on the web app: */
/***********************************/

/* at what ages/genders is bottom 10% black mortality higher or lower than white? */
use $mdata/int/bounds/mort_bounds_all, clear
keep if target == "10-45-70" & spec == "mon" & f2 < 1 & ranktype == "sex" & cause == "total" & year == 2016
keep if inlist(race, 1, 2) & inlist(sex, 1, 2)

disp_nice "MEN"
table age race if sex == 1 & edclass == 1, c(mean mu_lb mean mu_ub) format(%2.0f)
/* edclass 1: white men have higher mortality than black men above age 50 */

table age race if sex == 1 & edclass == 2, c(mean mu_lb mean mu_ub) format(%2.0f)
/* edclass 2: white men have lower mortality at all ages (ambiguous at age 25) */

disp_nice "WOMEN"
table age race if sex == 2 & edclass == 1, c(mean mu_lb mean mu_ub) format(%2.0f)
table age race if sex == 2 & edclass == 2, c(mean mu_lb mean mu_ub) format(%2.0f)
/* edclass 1: white women have higher mortality at all ages except 40-49 */
/* edclass 2: same mortality below age 45, white women lower at all higher ages */
