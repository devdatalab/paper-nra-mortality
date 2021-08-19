/*

this loads the collapsed nhis dataset and graphs mortality rate by group

date: Jan 2019

*/

capture pr drop mortscat
pr define mortscat 
syntax, race(string) sex(string) age(string) ed(string) [bin3] 

        local racet1 White
        local racet2 Black 
        local racet3 Hisp
        local racet4 Other

        local sext1 Men
        local sext2 Women

        local edt1 <HS
        local edt2 HS
        local edt3 Some College
        local edt4 BA+
                     
                     if "`bin3'" != "" {
                       local edt1 LEHS
                       local edt2 Some College 
                       local edt3 BA+ 
                                    }

        local aget0 Age 0-24
        local aget25 Age 25-55
        local aget55 Age 56+ 

        foreach i in 1 2 4 6 { 
          scatter mort_`i' year if sex == `sex' & race == `race' & age_gp == `age' & ed == `ed', xtitle("Year") ytitle("Deaths per 100,000") name(_`i', replace) legend(off) title("`i'-Year Mortality")
        }

        gr combine _1 _2 _4 _6, xcommon title("Mortality Trends: `racet`race'' `sext`sex'', `edt`ed'', `aget`age''") 

        graphout nhis_mort_`sex'_`race'_`ed'_`age'`bin3', large pdf

end


capture pr drop mortscat_se
pr define mortscat_se 
syntax, race(string) sex(string) age(string) ed(string) type(string) 

        local racet1 White
        local racet2 Black 
        local racet3 Hisp
        local racet4 Other

        local sext1 Men
        local sext2 Women

        local edt1 <HS
        local edt2 HS
        local edt3 Some College
        local edt4 BA+
                     
                     if "`type'" == "ed_3" {
                       local edt1 LEHS
                       local edt2 Some College 
                       local edt3 BA+ 
                                    }

        local aget0 Age 0-24
        local aget25 Age 25-55
        local aget55 Age 55+ 

        foreach i in 1 2 4 6 { 
          twoway scatter mean year if mort == `i' & sex == `sex' & race == `race' & age == `age' & ed == `ed' & type == "`type'", xtitle("Year") ytitle("Deaths per 100,000") name(_`i', replace) legend(off) title("`i'-Year Mortality") msymbol(O) || /
          rcap high low year if mort == `i' & sex == `sex' & race == `race' & age == `age' & ed == `ed' & type == "`type'", lcolor(black)                                                                                                                                                                                          
        }

        gr combine _1 _2 _4 _6, xcommon title("Mortality Trends: `racet`race'' `sext`sex'', `edt`ed'', `aget`age''") 

        graphout nhis_mort_`sex'_`race'_`ed'_`age'_`type'_ses, large pdf

end

/*************/
/* with SEs  */
/*************/
import delimited using $data/nhis_ses, clear
drop if year > 2012 & mort == 2 
drop if year > 2011 & mort == 3
drop if year > 2010 & mort == 4
drop if year > 2009 & mort == 5
drop if year > 2008 & mort == 6
mortscat_se, race(1) sex(2) ed(1) age(25) type(ed) 
mortscat_se, race(1) sex(2) ed(1) age(25) type(ed_3) 

mortscat_se, race(1) sex(1) ed(1) age(25) type(ed) 
mortscat_se, race(1) sex(1) ed(1) age(25) type(ed_3) 


/*************/
/* sans SEs  */
/*************/

global data $mdata/int/nhis/clean 
use $data/collapsed_nhis_mort, clear

mortscat, race(1) sex(2) ed(1) age(25)
mortscat, race(1) sex(1) ed(1) age(25)
mortscat, race(1) sex(1) ed(2) age(25)
mortscat, race(1) sex(2) ed(2) age(25)

use $data/collapsed_nhis_mort_3, clear 
mortscat, race(1) sex(2) ed(1) age(25) bin3
mortscat, race(1) sex(1) ed(1) age(25) bin3


