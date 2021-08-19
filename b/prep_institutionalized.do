/*

CR Notes: November 2020

- The 1990 and 2000 Census have a variable that is 1 if considered institutionalized
in the ACS. We use this variable ("type") in the ACS.

- See here for definition of
institutionalized populations: https://www.census.gov/topics/income-poverty/guidance/group-quarters.html

- We just add institutionalized and are agnostic about military.

*/


capture pr drop prep_inst
capture pr define prep_inst
syntax, [edtype(string) dropstates granage] 
        /********************/
        /* /\* GET CPS  *\/ */
        /********************/
        use $mdata/int/cps_march_inc_8018.dta, clear
        keep if inrange(year,1990,2018)


        * drop the relevant states if necessary
        if "`dropstates'" != "" {
                ren state State 
                merge m:1 State using $mdata/raw/misc/STCROSS.dta
                drop if (fipsstr==13|fipsstr==40|fipsstr==44|fipsstr==46)
        }

        /* get age group  */
        if "`granage'" != "" { 
          local age_gp = "age"
        }
        if "`age_gp'" == "" {
          local age_gp = "age_gp"
        }

        egen age_gp = cut(age), at(5(5)100)
        keep if inrange(age_gp,25,70)

        /* get sex variable */
        gen sex = female + 1 

        /* get sum by all cells */
        collapse (sum) wgt, by(sex wbho `age_gp' edclass`edtype' year) 

        tempfile cps
        save `cps' , replace 

        /* expand to get totals by race and sex */
        collapse (sum) wgt, by(sex `age_gp' edclass`edtype' year)

        gen wbho = 0
        append using `cps'
        save `cps', replace 

        /* get total by sex */ 
        collapse (sum) wgt, by(wbho `age_gp' edclass`edtype' year)
        gen sex = 0
        append using `cps'

        ren wgt non_inst
        save `cps' , replace 



        /*************/
        /* prep acs  */
        /*************/       
        clear

        forv i = 2006/2018 {
              append using $mdata/int/acs_prepped/cepr_acs_`i'.dta, keep(wbho female age civnon type perwgt year educ state)
        }

        /* drop the stoates if invoked - see $mdata/cepr_acs_do/cepr_acs_geog.do for the key */
        drop if inlist(state,13,40,44,46)
                       
        /* append census data */ 
        append using $mdata/int/1990_clean`dropstates'.dta
        append using $mdata/int/2000_clean`dropstates'.dta

        keep wbho sex age civnon perwgt perwt year educ edclass female type
        save $mdata/int/all_census.dta, replace       

        use $mdata/int/all_census.dta, clear
        
        keep if (type == 2 & inrange(year,2006,2018) == 1) | inlist(year,1990,2000) == 1 

        /* get ed class for the cps data */
        replace sex = female + 1 if inlist(year,1990,2000) != 1 
        replace edclass = min(educ, 4) if inlist(year,1990,2000) != 1

        gen edclass_3bin = edclass - 1 
        replace edclass_3bin = 1 if edclass_3bin == 0

        /* get age group  */
        egen age_gp = cut(age), at(5(5)100)
        keep if inrange(age_gp,25,70)

        /* rename the perwgt variable */
        replace perwgt = perwt if inlist(year,1990,2000)

        /* get sum by all cells */
        collapse (sum) perwgt, by(sex wbho `age_gp' edclass`edtype' year) 

        tempfile acs
        save `acs' , replace 

        /* expand to get totals by race and sex */
        collapse (sum) perwgt, by(sex `age_gp' edclass`edtype' year)

        gen wbho = 0
        append using `acs'
        save `acs' , replace 

        /* get total by sex */ 
        collapse (sum) perwgt, by(wbho `age_gp' edclass`edtype' year)
        gen sex = 0
        append using `acs'

        ren perwgt inst 
        save `acs', replace 

        merge 1:1 wbho year edclass`edtype' `age_gp' sex using `cps'

        replace inst = 0 if inst == . 
        /* impute institutionalized population linearly between years */
        foreach year in 1990 2000 2006 {
          gen inst_`year'_tmp = inst if year == `year'
          bys wbho sex edclass`edtype' `age_gp': egen inst_`year' = mean(inst_`year'_tmp)
        }

        bys wbho sex edclass`edtype' `age_gp': replace inst = (year - 1990) * (inst_2000 - inst_1990)/(2000-1990) + inst_1990 if inrange(year,1991,1999) 
        bys wbho sex edclass`edtype' `age_gp': replace inst = (year - 2000) * (inst_2006 - inst_2000)/(2006-2000) + inst_2000 if inrange(year,2001,2005) 

        drop *tmp

        keep if inrange(year,1992,2018)
        save $mdata/int/inst_pops`edtype'`dropstates'`granage', replace

end

prep_inst, dropstates granage
prep_inst, edtype(_3bin) dropstates
prep_inst, dropstates

