global data $mdata/int/nhis/clean 
global std $mdataint
use $data/prepped_nhis, clear

/* get percent change estimates  */
svyset [pweight = wgt_new] , strata(strat) psu(ps) singleunit(centered) / check the SINGLE UNIT command 

/* make a new age variable: people 25-55 */
gen age_25_55 = inrange(gran_age,25,55)
keep if age_25_55 == 1

capture file close fh
file open fh using $std/coefplot.csv, write replace
file write fh "name,est,high,low" _n

/* run the simultaneous regression */
foreach type in ed ed_3 { 
  preserve
        keep if race == 1 & `type' == 1 
        replace year = year - 1997 

        /* regress the trend */
        svy: reg mort_1 year
        nlcom (_b[year] * (2009 - 1997))/_b[_cons]

        /* extract */

        matrix est = r(b)
        matrix var = r(V)

        local est = est[1,1]
        local var = var[1,1]
        local high = `est' + 1.96 * sqrt(`var')
        local low = `est' - 1.96 * sqrt(`var' )

        file write fh "nhis_`type',"
        file write fh (`est') "," 
        file write fh (`high') "," 
        file write fh (`low') _n 

  restore
}

/*****************/
/* NCHS results  */
/*****************/

/* recreate standardized mortality file, so we have control over the age in sample */
foreach type in "" "_3bin" { 
  use $mdata/mort/nchs/appended_rank_mort`type', clear
        drop _merge
        ren age_gp age
        merge m:1 age using $std/std-pop-79-5
  
        /* 25 to 55 */
        keep if inrange(age, 25, 55)
        assert _merge == 3
        drop _merge
        keep if age <= 55
        collapse (sum) tmort tpop [aw=std], by(sex race edclass year)
  
  keep if inrange(year, 1997, 2009)
    replace year = year-1997
gen tmortrate = tmort/tpop
        reg tmortrate year if race == 1 & edclass == 1 & sex == 0 

        local ratio = (_b[year] * (2009-1997)/_b[_cons])

        file write fh "nchs_`type',"
        file write fh (`ratio') _n 

}
file close fh

/*******************************/
/* /\* turn into a picture *\/ */
/*******************************/
import delimited using $std/coefplot.csv, clear

gen n = _n
replace n = 2 if name == "nchs_"
replace n = 3 if name == "nhis_ed_3"
foreach var in high low est {
  replace `var' = `var' * 100
}

format est %9.1f

twoway rcap high low n, xtitle("Survey") ytitle("Percent change in age 25-55 mortality" "2009-1997") || /
                                           scatter est n, /
xlabel(1 "NHIS: <HS" 2 "NCHS: <HS" 3 "NHIS {&le}HS" 4 "NCHS {&le}HS")  legend(off)  /
mcolor(black) msymbol(O) mlabel(est) mlabcolor(black)  xline(2.5, lpattern(dash) lcolor(gray)) graphregion(margin(r+10)) ylabel(#5) ylabel(,grid)

graphout nchs_vs_nhis, pdf large





