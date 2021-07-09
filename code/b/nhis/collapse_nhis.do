/*

this dofile loads the merged dataset and generates a collapsed nhis dataset of mortality rates 

date: Jan 2019 , updated Fall 2020 for AEJ: Applied

*/
global data $mdata/nhis_data/clean 
use $data/appended_mort_personsx_small, clear

/***********************************/
/* /\* generate race variable *\/  */
/***********************************/
ren race nhisrace 
gen race = .

/* 1997 */
replace race = 1 if hispan_p == 12 & racerec == 1 & year == 1997
replace race = 2 if hispan_p == 12 & racerec == 2 & year == 1997
replace race = 3 if hispan_p < 12 & year == 1997 
replace race = 4 if race == . & year == 1997 

/* 1998 */
replace race = 1 if hispcode == 2 & year == 1998
replace race = 2 if hispcode == 3 & year == 1998
replace race = 3 if hispcode == 1 & year == 1998
replace race = 4 if race == . & year == 1998


/* 1999 */
replace race = 1 if hispcodr == 2 & year == 1999
replace race = 2 if hispcodr == 3 & year == 1999
replace race = 3 if hispcodr == 1 & year == 1999
replace race = 4 if race == . & year == 1999

/* 2000 - 2002 */
replace race = 1 if hiscod_i == 2 & inrange(year,2000,2002)
replace race = 2 if hiscod_i == 3 & inrange(year,2000,2002)
replace race = 3 if hiscod_i == 1 & inrange(year,2000,2002)
replace race = 4 if race == . & inrange(year,2000,2002)

/* 2003 - 2005 */
replace race = 1 if hiscodi2 == 2 & inrange(year,2003,2005)
replace race = 2 if hiscodi2 == 3 & inrange(year,2003,2005)
replace race = 3 if hiscodi2 == 1 & inrange(year,2003,2005)
replace race = 4 if race == . & inrange(year,2003,2005)

/* 2006 - 2009 */
replace race = 1 if hiscodi3 == 2 & inrange(year,2006,2014)
replace race = 2 if hiscodi3 == 3 & inrange(year,2006,2014)
replace race = 3 if hiscodi3 == 1 & inrange(year,2006,2014)
replace race = 4 if race == . & inrange(year,2006,2014)



/************************************/
/* /\* prepare mortality status *\/ */
/************************************/
* NOTE NO INTERVIEW QUARTER IN 2004 - AD-HOC SOLUTION IS TO GIVE EVERYONE A JUNE INTERVIEW 
replace intv_qrt = 2.5 if year == 2004 
gen q_interview = yq(year,intv_qrt)
gen q_died = yq(dodyear,dodqtr) 
gen mort_1 = q_died - q_interview <= 4 
gen mort_2 = q_died - q_interview <= 8
gen mort_3 = q_died - q_interview <= 12
gen mort_4 = q_died - q_interview <= 16
gen mort_5 = q_died - q_interview <= 20
gen mort_6 = q_died - q_interview <= 24

/**********************/
/* prepare education  */
/**********************/
gen ed = .
replace ed =  1 if educ <= 11 & year < 2004 
replace ed =  2 if inrange(educ,12,14) & year < 2004 
replace ed =  3 if inrange(educ,15,17) & year < 2004
replace ed =  4 if inrange(educ,18,21) & year < 2004

replace ed =  1 if educ1 <= 11 & year >= 2004
replace ed =  2 if inrange(educ1,12,14) & year >= 2004
replace ed =  3 if inrange(educ1,15,17)  & year >= 2004
replace ed =  4 if inrange(educ1,18,21)  & year >= 2004

/* get a 3-bin version of the ed var */
gen ed_3 = ed - 1
replace ed_3 = 1 if ed_3 == 0

/* drop missing educations */
drop if educ > 90 & year < 2004 
drop if educ1 > 90 & year >= 2004 & !mi(year) 

/* prepare age */
gen age = age_p if age_p != .
replace age = age_chg if age == . 
egen age_gp = cut(age), at(0 25 56 100) 
ren age gran_age 
gen tpop = 1

save $mdata/nhis_uncollapsed, replace

/******************/
/* Get survey SEs */
/******************/
gen strat = strat_p if strat_p != .
replace strat = stratum if strat == .
gen ps = psu_p if psu_p != .
replace ps = psu if ps == .
svyset [pweight = wtfa] , strata(strat) psu(ps)

/* for running mortality estimates, multiply by 100000 */
replace mort_1 = mort_1 * 100000
replace mort_2 = mort_2 * 100000
replace mort_3 = mort_3 * 100000
replace mort_4 = mort_4 * 100000
replace mort_5 = mort_5 * 100000
replace mort_6 = mort_6 * 100000


/* generate total counts */
bys race sex age_gp year ed: egen tpop_ed = total(wtfa)
bys race sex age_gp year ed_3: egen tpop_ed_3 = total(wtfa)

/* generate total obs in nhis */
gen one = 1
bys race sex age_gp year ed: egen nhispop_ed = total(one)
bys race sex age_gp year ed_3: egen nhispop_ed_3 = total(one)

/* generate total deaths in nhis */
foreach mort in 1 2 3 4 5 6 { 
    bys race sex age_gp year ed: egen nhisdeath_`mort'_ed = total(mort_`mort')
    bys race sex age_gp year ed_3: egen nhisdeath_`mort'_ed_3 = total(mort_`mort')
    replace nhisdeath_`mort'_ed = nhisdeath_`mort'_ed / 100000
    replace nhisdeath_`mort'_ed_3 = nhisdeath_`mort'_ed_3 / 100000
}

/* save prepped nhis dataset */
save $data/prepped_nhis, replace

/* example 

svyset [pweight = wtfa] , strata(strat) psu(ps)
replace mort_5 = mort_5 * 100000
svy: mean mort_5, subpop( if year == 2009 & sex == 2 & race == 1 & ed == 1 & age_gp == 25)
svy: mean mort_5, subpop( if year == 1997 & sex == 2 & race == 1 & ed == 1 & age_gp == 25)

*/ 

/*****************************************/
/* save SEs to a file for graphical analysis */
/*****************************************/
* svyset [pweight = wtfa] , strata(strat) psu(ps)
qui {
capture file close fh
capture file open fh using $data/nhis_ses.csv, write replace
file write fh "race,sex,age,year,ed,type,mort,mean,high,low,tpop,nhispop,nhisdeath" _n 

    foreach race in 1 2 { 
        foreach sex in 1 2 {
            foreach age in 25 {
                foreach ed in 1 2 {
                      /* need to loop over both 4- and 3-bin education variables */ 
                      foreach type in ed ed_3 {

                        /* each mortality length */ 
                        foreach mort in 1 2 3 4 5 6 {
              
                                  forv year = 1997/2014 {

                         noisily di "year: `year', ed group: `ed', age: `age', sex: `sex', race: `race', type: `type', mort: `mort' "

                          /* take mean and get SEs */
                          reg mort_`mort' [pw=wtfa] if year == `year' & sex == `sex' & race == `race' & `type' == `ed' & age_gp == `age'

                          /* extract mean and SEs from stored matrix */ 
                          matrix est = r(table)
                          local b = est[1,1]
                          local high = est[6,1]
                          local low = est[5,1]

                          /* write to a file */ 
                          file write fh "`race',`sex',`age',`year',`ed',`type',`mort',"
                          file write fh (`b')
                          file write fh ","   
                          file write fh (`high')
                          file write fh ","
                          file write fh (`low') "," 

                          /* write sample sizes to the file also */

                          /* total population */
                          sum tpop_`type' if year == `year' & sex == `sex' & race == `race' & `type' == `ed' & age_gp == `age' 
                          file write fh (`r(mean)') ","

                          /* nhis sample size */ 
                          sum nhispop_`type' if year == `year' & sex == `sex' & race == `race' & `type' == `ed' & age_gp == `age' 
                          file write fh (`r(mean)') ","

                          /* # deaths in the nhis */ 
                          sum nhisdeath_`mort'_`type' if year == `year' & sex == `sex' & race == `race' & `type' == `ed' & age_gp == `age' 
                          file write fh (`r(mean)') _n       
                                                    
                        }
                      }
                    }
                }
            }
        }
    }        
file close fh
} 

