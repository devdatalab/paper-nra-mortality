/***************************/
/* test polynomial spline  */
/***************************/
capture pr drop polyspline
pr define polyspline, rclass 
syntax, xvar(string) yvar(string) name(string) [graphoff notmortality degree(int 5)] 

    /* only try 4, 5 or 6 degree polynomials */ 
    assert inlist(`degree',4,5,6) 
    local ylabel = ", format(%10.0fc)"
    local ytitle = "Deaths/100,000"


    /* compute polynomial */
    forv i = 1/`degree' { 
        gen px`i' = `xvar'^`i'
    }


    /* regress the y var on the polynomial and obtain fitted values */ 
    reg `yvar' px*
    predict prhat, xb 

  /* if not mortality, need to do something else to get overall sample mean */ 
  if "`notmortality'" == "" { 
      egen total_deaths = total(deaths)
      egen total_count = total(count)
      gen overall_sample_mean = total_deaths / total_count * 100000
  }    

    /* get analytical second derivative */
    if `degree' == 4 { 
        gen second_deriv = (2 * _b[px2] + (3* 2) *_b[px3] * `xvar' + ///
            (4 * 3 ) * _b[px4] * (`xvar'^2 ) ) / overall_sample_mean * 100
    }
    if `degree' == 5 { 
        gen second_deriv = (2 * _b[px2] + (3* 2) *_b[px3] * `xvar' + ///
            (4 * 3 ) * _b[px4] * (`xvar'^2) + ///
            (5 * 4)*_b[px5]*(`xvar'^3) ) / overall_sample_mean * 100
    }
    if `degree' == 6 {
        gen second_deriv = (2 * _b[px2] + (3* 2) *_b[px3] * `xvar' + ///
            (4 * 3 ) * _b[px4] * (`xvar'^2) + ///
            (5 * 4)*_b[px5]*(`xvar'^3) + (6 * 5)*_b[px6]*(`xvar'^4) )  / overall_sample_mean * 100
    }


    /* obtain min and max */ 
    sum second_deriv
    local min: di %5.3f `r(min)'
    local max: di %5.3f `r(max)'

    sum second_deriv if inrange(`xvar',5,95) 
    local min2: di %5.3f `r(min)'
    local max2: di %5.3f `r(max)'

    sort `xvar'

    if "`graphoff'" == "" { 
        /* scatter */
        scatter `yvar' `xvar', legend(off) mcolor(black) msize(small) msymbol(Oh) /// 
                xtitle("Rank") ytitle("`ytitle'") ///
                xlabel(0(10)100, format(%10.0fc)) ///
      note("2nd derivative in [`min'%,`max'%]" "2nd derivative in range [5, 95] in [`min2'%,`max2'%]", size(large)) ///
                ylabel(`ylabel') `xlines' || line prhat `xvar', lcolor(maroon)
          graphout polyspline_`name', pdf

    }

    /* extract locals */ 
    return local max = `max'
    return local min = `min'
    return local max595 = `max2'
    return local min595 = `min2'

end


/***************************/
/* Prep Chetty et al. data */
/***************************/
import delimited using $mortality/health_ineq_online_table_16.csv, clear

/* this is a dataset that is unique by age year sex and percentile */ 
unique age yod gnd indv_pctile
assert `r(unique)' == _N

/* clean age group data */ 
ren age_at_d age 
egen age_gp = cut(age), at(40(5)75)
keep if age_gp <= 70

/* bucket years */ 
egen year_gp = cut(yod), at(2001 2003 2006 2009 2012 2015) // there are not an evenly divisible number of years, so lump 2001 and 2002 together so it's similar to aggregation in paper 

assert !mi(deaths)
assert !mi(count)
assert !mi(age_gp)
assert !mi(year_gp)
assert !mi(gnd)
assert !mi(indv_pctile)
ren indv_pctile pctile

collapse (sum) deaths count, by(age_gp year_gp gnd pctile)
gen mortrate = deaths / count * 100000

/**************************************/
/* export min and max cbar to a .csv  */
/**************************************/
capture file close fh
capture file open fh using $tmp/poly_cbar.csv, write replace
file write fh "age,year,sex,min,max,min595,max595,degree" _n

/* loop over appropriate subgroups */ 
foreach age_gp of numlist 40(5)70 {
    foreach year in 2001 2003 2006 2009 2012 {
        foreach sex in M F {
             foreach degree in 4 5 6 {

                 local nm2001 "2001-2002"
                 local nm2003 "2003-2005"
                 local nm2006 "2006-2008"
                 local nm2009 "2009-2011"
                 local nm2012 "2012-2014"
      
                  preserve 
                      keep if age_gp == `age_gp' & gnd == "`sex'" & year_gp == `year'

                      /* obtain spline */ 
                      cap qui  polyspline, yvar(mortrate) xvar(pctile) name(_`age_gp'_`sex'_`year') degree(`degree')  graphoff      
                      if (_rc == 0 )     file write fh "`age_gp',`nm`year'',`sex'" "," (`r(min)') "," (`r(max)') "," (`r(min595)') "," (`r(max595)') "," (`degree') _n

                  restore 
      
              }
        }
    }
}

cap file close fh

/* make two additional graphs */ 
preserve
    keep if age_gp == 50 & gnd == "M" & year_gp == 2012 
    qui  polyspline, yvar(mortrate) xvar(pctile) name(_50_M_2012-2014) degree(5)  
restore

preserve 
    keep if age_gp == 50 & gnd == "F" & year_gp == 2012 
    qui  polyspline, yvar(mortrate) xvar(pctile) name(_50_F_2012-2014) degree(5)  
restore 


import delimited using $tmp/poly_cbar.csv, clear
gen abs = max(abs(min),abs(max))
sum abs if degree == 5 

gen abs595 = max(abs(min595),abs(max595))
sum abs595 if degree == 5
!cp $tmp/poly_cbar.csv ~/public_html/png/poly_cbar.csv

