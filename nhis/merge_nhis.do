/**************************************************************/
/* /\* this dofile MERGES the mortality and persons files *\/ */
/**************************************************************/

local per $mdata/int/nhis/clean
/**********************************/
/* /\* construct publicid var in persons dataset *\/ */
/**********************************/

/* 1997-2003 */ 
forv i = 1997/2003 {
    local per $mdata/int/nhis/clean
    use `per'/nhis`i'_personsx.dta, clear 
    capture drop publicid

    egen publicid = concat(srvy_yr hhx fmx px)
    save `per'/nhis`i'_personsx.dta, replace 
}


/* 2004 */
forv i = 2004/2004 {
    local per $mdata/int/nhis/clean 
    use `per'/nhis`i'_personsx.dta, clear 
    capture drop publicid

    egen publicid = concat(srvy_yr hhx fmx fpx)
    save `per'/nhis`i'_personsx.dta, replace 
}


/* 2005-2009 */
forv i = 2005/2014 {
    local per $mdata/int/nhis/clean 

    use `per'/nhis`i'_personsx.dta, clear 
    capture drop publicid

    egen publicid = concat(srvy_yr hhx fmx fpx)
    save `per'/nhis`i'_personsx.dta, replace 
}


/**********/
/* merge persons and mort data  */
/**********/

/* open +  merge+  save tempfile */ 
forv i = 1997/2014 {

  /* load */
  local per $mdata/int/nhis/clean 
  use `per'/nhis`i'_personsx.dta, replace

  /* merge persons onto mortality */ 
  merge 1:1 publicid using `per'/nhis`i'_pmort, assert(match)

  /* destring some variables for clean append */ 
  capture destring dob_m dob_y_p, replace
  capture destring hh_ref, replace 
  capture destring fmother, replace
  capture destring ffather, replace
  
  /* save tempfiles */ 
  tempfile merge`i'
  save `merge`i'' 
}

clear

/* append */ 
forv i = 1997/2014 {
  append using `merge`i''  
}

/* rename survey year */
ren srvy_yr year 

/* save merged file */ 
local per $mdata/int/nhis/clean 
save `per'/appended_mort_personsx, replace

/* generate a reduced file for ease of use */
keep sex *age* r_age1 r_age2 dob_m dob_y_p origin *hisp* *rac* rectype year hhx fmx px intv_qrt ///
wtfa *mort* *dod* eligstat educ* mom_ed dad_ed *his* strat_p stratum psu_p psu

local per $mdata/int/nhis/clean 
save `per'/appended_mort_personsx_small.dta, replace


