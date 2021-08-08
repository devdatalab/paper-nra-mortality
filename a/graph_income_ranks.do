/******************************/
/* prep income ranks */
/******************************/
use $mdata/int/cps_march_inc_8018.dta, clear
keep if year >= 1992

egen age_gp = cut(age), at(25(5)70)
drop if age_gp == .

egen year_age_gp = group(year age_gp)
egen year_age_gp_female = group(year age_gp female)
egen year_age_gp_female_wbho = group(year age_gp female wbho)

/* get ranks */
gen_wt_ranks rincp_all, gen(inc_rank_all) by(year_age_gp) weight(wgt)
gen_wt_ranks rincp_all, gen(inc_rank_sex) by(year_age_gp_female) weight(wgt)
gen_wt_ranks rincp_all, gen(inc_rank_racesex) by(year_age_gp_female_wbho) weight(wgt)

levelsof year, local(years)
levelsof age_gp, local(ages)

cumul inc_rank_all, gen(cumul_rank_all) by(age_gp year female) equal
cumul inc_rank_sex , gen(cumul_rank_sex) by(age_gp year wbho female) equal

cumul inc_rank_all, gen(cumul_rank_all_byed) by(age_gp year female edclass) equal
cumul inc_rank_sex , gen(cumul_rank_sex_byed) by(age_gp year wbho female edclass) equal

save $mdata/int/cps_inc_ranks.dta, replace

/******************************************************************************/
/* generate average rank conditional on being in a certain ed bucket          */
/******************************************************************************/
capture pr drop mean_inc_rank_within
capture pr define mean_inc_rank_within
syntax, age(string) sex(string) edclass(string) [ name(passthru) title(passthru) wage pres ]

    local axis1 = "20(10)70"
    local axis2 = "20(10)70" 
    local axis3 = "20(10)70" 
    local axis4 = "20(10)70" 

    local wageaxis1 = "0(2)10"
    local wageaxis2 = "10(5)45"
    local wageaxis3 = "45(5)70"
    local wageaxis4 = "70(5)100" 

    use $mdata/int/cps_inc_ranks.dta, clear
    if "`wage'" == "" { 
    keep if female == `sex' - 1 & edclass  == `edclass' & age_gp == `age'

    /* get within ed ranks */
    gen_wt_ranks rincp_all, gen(inc_rank_sex_ed) by(year_age_gp_female) weight(wgt)
    local rankvar = "inc_rank_sex_ed"                
    }
    else {
    local wage1 = "0,10"
    local wage2 = "10,45"
    local wage3 = "45,70"
    local wage4 = "70,100"
    keep if female == `sex' - 1   & inrange(inc_rank_sex,`wage`edclass'') == 1 & age_gp == `age'
    local rankvar = "inc_rank_sex" 
    }

    gen n = 1

    /* regress to get the standard errors */
    capture file close fh 
    capture file open fh using $tmp/`wage'ranks_`age'_`sex'_`edclass'.csv, write replace
    file write fh "wbho, year, rank, se_rank" _n

    forv year =  1992/2018 { 
    foreach wbho in 1 2 {
      qui reg `rankvar'  if wbho == `wbho' & year == `year' & female == `sex' - 1 [pw = wgt] 

      file write fh "`wbho',`year'," 
      file write fh (_b[_cons])  ","
      file write fh (_se[_cons]) _n  
    }
    }
    file close fh 
    import delimited using $tmp/`wage'ranks_`age'_`sex'_`edclass', clear

    local presgraphoptions xtitle(,size(large)) ytitle(, size(large)) ylabel(,labsize(large)) xlabel(,labsize(large)) legend(size(large)) title("Average Within-Bin Rank")

    gen high = rank + 1.96 * se_rank
    gen low = rank - 1.96 * se_rank 
    line rank year if wbho == 1, ytitle("Mean income rank") xtitle("Year") legend(lab(1 "White non-Hispanic")) lwidth(medthick) lcolor(black) lpattern(dash) || ///
      line rank year if wbho == 2, ytitle("Mean income rank") xtitle("Year") legend(lab(2 "Black non-Hispanic")) lwidth(medthick) lcolor(gray) lpattern(solid)  `name' `title' legend(order(1 2) cols(2)) ///
      ylabel(``wage'axis`edclass'') ///
      ``pres'graphoptions' 

    /* rarea high low year if wbho == 1, bcolor(gs14 %20) lcolor(none) || /// */
      /* rarea high low year if wbho == 2, bcolor(gs2 %20) lcolor(none)  */

    if "`name'" == "" { 
      graphout mean_within_`wage'rank_`age'_`sex'_`edclass'`pres', pdf 
    }
end

foreach wage in  "" /*"wage"*/ {
  foreach age in 50 {
    foreach sex in 1 2 {
      foreach edclass in 1 2 3 4 {
    
        local t1 = "<HS"
        local t2 = "HS"
        local t3 = "Some College"
        local t4 = "BA+"
        local waget1 = "Ranks 0-10"
        local waget2 = "Ranks 10-45"
        local waget3 = "Ranks 45-70"
        local waget4 = "Ranks 70-100"
    
        mean_inc_rank_within, age(`age') sex(`sex') edclass(`edclass') name(_`wage'`edclass',replace) title(``wage't`edclass'') `wage'
        graphout mean_within_`wage'rank_`age'_`sex'_comb1
      }
    
      grc1leg _`wage'1 _`wage'2 _`wage'3 _`wage'4, xcommon
      graphout mean_within_`wage'rank_`age'_`sex'_comb, pdf 
    }
  }
}

/***************************/
/* Output for presentation */
/***************************/
mean_inc_rank_within, age(50) sex(1) edclass(1) 
mean_inc_rank_within, age(50) sex(1) edclass(2) 
mean_inc_rank_within, age(50) sex(2) edclass(1) 
mean_inc_rank_within, age(50) sex(2) edclass(2) 
