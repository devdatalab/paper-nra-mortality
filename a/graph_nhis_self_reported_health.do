/**********************************************************/
/* COPY/PASTE FROM COLLAPSE/NHIS TO GET EDUC / RACE / SEX */
/**********************************************************/
/**********************************************************************************/
/* program clean_nhis : Insert description here */
/***********************************************************************************/
cap prog drop clean_nhis
prog def clean_nhis
{
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
  
  /* 2006 - 2014 */
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
}
end
/* *********** END program clean_nhis ***************************************** */

use $mdata/int/nhis/clean/appended_mort_personsx, clear

recode phstat 7=. 8=. 9=.
gen good_health = inlist(phstat, 1, 2) if !mi(phstat)
gen bad_health = inlist(phstat, 3, 4, 5) if !mi(phstat)

/* check which conditions are apparent and not too missing */
forval i =1/33 {
  qui count if lahca`i' == 1
  di "`i': `r(N)'"
}

gen depressed = lahca17 == 2 if inlist(lahca17, 1, 2)
gen arthritis = lahca3  == 2 if inlist(lahca3, 1, 2)
gen backneck  = lahca4  == 2 if inlist(lahca4, 1, 2)
gen heart     = lahca7  == 2 if inlist(lahca7, 1, 2)

clean_nhis

/* check that sample years exist */
foreach i in depressed arthritis backneck heart {
  tab year if !mi(`i')
}

save $tmp/nhis_short_all_ages, replace

keep if inrange(age_gp, 25, 54)
save $tmp/nhis_short, replace

/*********************/
/* ANALYZE AGE 24-54 */
/*********************/
global f $tmp/nhis_health.csv
cap erase $f
append_to_file using $f, s(b, se, p, n, var, race, ed, sex)
foreach race in 1 2 {
  foreach ed in 1 2 3 4 {
    foreach sex in 1 2 {

      capdrop sample
      gen sample = sex == `sex' & race == `race' & ed == `ed' 

      foreach var in depressed arthritis backneck heart bad_health {
        reg `var' year [pw=wgt_new] if sample == 1
        append_est_to_file using $f, s(`var',`race',`ed',`sex') b(year)
      }
    }
  }
}


import delimited $f, clear

foreach var in depressed arthritis backneck heart bad_health {
  disp_nice "`var' -- white men"
  list b ed n if race == 1 & sex == 1 & var == "`var'"
}


foreach var in depressed arthritis backneck heart bad_health {
  disp_nice "`var' -- white women"
  list b ed n if race == 1 & sex == 2 & var == "`var'"
}




/*********************************************************/
/* PLOT NHIS SELF-REPORTED HEALTH BY AGE/EDUCATION GROUP */
/*********************************************************/
use $tmp/nhis_short_all_ages, clear

ren gran_age age

/* start years at zero */
replace year = year - 1997

/* create interaction variables for regression */
forval i = 1/4 {
  gen year_ed`i' = (ed == `i') * year
  gen ed`i' = ed == `i'
}


/* focus on whites over 21 only */
keep if race == 1 & age >= 21

// /* report average change in self-reported health for white women in each ed category */
// tabstat phstat [aw=wgt_new] if ed == 1 & sex == 2, by(year)
// tabstat phstat [aw=wgt_new] if ed == 2 & sex == 2, by(year)
// tabstat phstat [aw=wgt_new] if ed == 3 & sex == 2, by(year)
// tabstat phstat [aw=wgt_new] if ed == 4 & sex == 2, by(year)
// 
// /* regress one group at a time, with age fixed effects */
// areg phstat year [aw=wgt_new] if ed == 1 & sex == 1, absorb(age)
// areg phstat year [aw=wgt_new] if ed == 2 & sex == 1, absorb(age)
// areg phstat year [aw=wgt_new] if ed == 3 & sex == 1, absorb(age)
// areg phstat year [aw=wgt_new] if ed == 4 & sex == 1, absorb(age)

forval i = 1/4 {
  gen coef_ed`i' = .
}

save $tmp/foo, replace

qui forval age = 21/85 {
  noi di "`age'"
  foreach sex in 1 2 {
    reg phstat ed1 ed2 ed3 year_ed* [pw=wgt_new] if race == 1 & sex == `sex' & age == `age'
    forval i = 1/4 {
      replace coef_ed`i' = _b["year_ed`i'"] if race == 1 & sex == `sex' & age == `age'
    }
  }
}


tag race sex age
drop if age < 21
save $tmp/lowess, replace

twoway ///
  (lowess coef_ed1 age if rsatag == 1 & sex == 1 & race == 1, lwidth(medthick) lpattern(solid)) ///
  (lowess coef_ed2 age if rsatag == 1 & sex == 1 & race == 1, lwidth(medthick) lpattern(dash)) ///
  (lowess coef_ed3 age if rsatag == 1 & sex == 1 & race == 1, lcolor(black) lwidth(medthick) lpattern(shortdash_dot)) ///
  (lowess coef_ed4 age if rsatag == 1 & sex == 1 & race == 1, lwidth(medthick) lpattern(longdash_dot)), ///
  legend(lab(1 "Dropouts") lab(2 "High School") lab(3 "Some College") lab(4 "B.A. or Higher")) ///
xtitle("Age") ytitle("Change in self-reported bad health (1-5)") title("White Men") ///
name(lowess_sex1, replace)
graphout lowess_sex1
twoway ///
  (lowess coef_ed1 age if rsatag == 1 & sex == 2 & race == 1, lwidth(medthick) lpattern(solid)) ///
  (lowess coef_ed2 age if rsatag == 1 & sex == 2 & race == 1, lwidth(medthick) lpattern(dash)) ///
  (lowess coef_ed3 age if rsatag == 1 & sex == 2 & race == 1, lcolor(black) lwidth(medthick) lpattern(shortdash_dot)) ///
  (lowess coef_ed4 age if rsatag == 1 & sex == 2 & race == 1, lwidth(medthick) lpattern(longdash_dot)), ///
  legend(lab(1 "Dropouts") lab(2 "High School") lab(3 "Some College") lab(4 "B.A. or Higher")) ///
         xtitle("Age") ytitle("Change in self-reported bad health (1-5)") title("White Women") ///
name(lowess_sex2, replace)
graphout lowess_sex2

grc1leg lowess_sex2 lowess_sex1 , rows(1)
graphout lowess_sex_both, pdf

exit
exit
exit




/* combined men and women */
reg phstat ed1 ed2 ed3 year_ed* [pw=wgt_new] if race == 1, absorb(age)

/* case-deaton edition w/3 ed groups */
gen cd_ed = ed
recode cd_ed 4=3 3=2 2=1
forval i = 1/3 {
  gen year_cd_ed`i' = (cd_ed == `i') * year
  gen cd_ed`i' = cd_ed == `i'
}

reg phstat cd_ed1 cd_ed2 cd_ed3 year_cd_ed* [pw=wgt_new] if sex == 1 & race == 1, absorb(age)
reg phstat cd_ed1 cd_ed2 cd_ed3 year_cd_ed* [pw=wgt_new] if sex == 2 & race == 1, absorb(age)
reg phstat cd_ed1 cd_ed2 cd_ed3 year_cd_ed* [pw=wgt_new] if race == 1, absorb(age)


recode phstat
