/*****************************************************************/
/* program to obtain ranks from the data structured in this way  */
/*****************************************************************/
capture pr drop edranks
capture pr define edranks
syntax, type(string) [yeargp(string) etype(string) granage ] 

        /* get age group  */
        if "`granage'" != "" { 
          local age_gp = "age"
        }
        if "`age_gp'" == "" {
          local age_gp = "age_gp"
        }

        if inlist("`type'","race_sex","sex","all") == 0 {
          di "need to specify the correct rank type"
          stop
        }

        /* key between what you sort on and the type of rank you specify */ 
        local race_sexsort = "wbho sex"
        local sexsort = "sex"
        local allsort = "not_all_sex"

        /* ensure you don't double count */ 
        gen not_all_sex = sex != 0

        /* get total population within what you're sorting on */ 
        bys `age_gp' ``type'sort' year`yeargp': egen TPop_`type' = total(TPop_rolling)
        bys `age_gp' ``type'sort' year`yeargp' edclass`etype': egen TPop_ed_`type' = total(TPop_rolling)

        drop not_all_sex
        gen not_all_sex = sex 

        /* obtain education ranks */
        bys wbho year`yeargp' `age_gp' ``type'sort' (edclass`etype'): gen ed_rank_`type' = (TPop_ed_`type' / TPop_`type')/2 if _n == 1
        bys wbho year`yeargp' `age_gp' ``type'sort' (edclass`etype'): gen cum_ed_rank_`type' = sum(TPop_ed_`type'/TPop_`type') 
        bys wbho year`yeargp' `age_gp' ``type'sort'  (edclass`etype'): replace ed_rank_`type' = (TPop_ed_`type' / TPop_`type')/2 + cum_ed_rank_`type'[_n-1] if _n > 1
        replace ed_rank_`type' = ed_rank_`type' * 100

        drop not_all_sex

end

/**********************/
/* store labels here  */
/**********************/
capture pr drop labelvars
capture pr define labelvars

        la var raw_TPop "Total population"
        la var TPop_rolling "Total population: rolling 5 year period"
        la var sex "sex: 0 = all, 1 = male, 2 = female"
        la var wbho "race: 0 = all, 1 = white, 2 = black, 3 = hispanic, 4 = other" 
        la var ed_rank_sex "within gender ed rank, median within bin"
        la var ed_rank_race_sex "within race/gender ed rank, median within bin"
        la var ed_rank_all "ed rank (whole population), median within bin"
        la var cum_ed_rank_sex "within gender rank, cumulative rank at end of bin cut"
        la var cum_ed_rank_race_sex "within race/gender rank, cumulative rank at end of bin cut"
        la var cum_ed_rank_all "ed rank (whole population), cumulative rank at end of bin cut"        

        la var Tmort "Total deaths"
        la var Pmort "Poisoning deaths"
        la var Smort "Suicide deaths"
        la var Lmort "Liver/alcohol deaths"
        la var Hmort "Heart disease deaths"
        la var Cmort "Cancer deaths"
        la var lungCmort "Lung cancer deaths"
        la var CDmort "Cerebrovascular deaths"
        la var CLmort "Chronic lower respiratory disease deaths"
        la var CLmort "Chronic lower respiratory disease deaths"
        la var Dmort "Deaths of despair (= P + S + L) deaths"
        la var Rmort "Regular (= C + H) deaths"
        la var Amort "Accidents deaths"
        la var Omort "Other diseases deaths"
        la var ORmort "Other respiratory diseases deaths (subset of Omort)"
        la var OVmort "Other viral diseases deaths (subset of Omort)"

        la var Tmortrate "Total mortality rate"
        la var Pmortrate "Poisoning mortality rate"
        la var Smortrate "Suicide mortality rate"
        la var Lmortrate "Liver/alcohol mortality rate"
        la var Hmortrate "Heart disease mortality rate"
        la var Cmortrate "Cancer mortality rate"
        la var lungCmortrate "Lung cancer mortality rate"
        la var CDmortrate "Cerebrovascular mortality rate"
        la var CLmortrate "Chronic lower respiratory disease mortality rate"
        la var CLmortrate "Chronic lower respiratory disease mortality rate"
        la var Dmortrate "Deaths of despair (= P + S + L) mortality rate"
        la var Rmortrate "Regular (= C + H) mortality rate"
        la var Amortrate "Accidents mortality rate"
        la var Omortrate "Other diseases mortality rate"
        la var ORmortrate "Other respiratory diseases mortality rate (subset of Omortrate)"
        la var OVmortrate "Other viral diseases mortality rate (subset of Omortrate)"

        la var Tsurvrate "Total survival rate"
        la var Psurvrate "Poisoning survival rate"
        la var Ssurvrate "Suicide survival rate"
        la var Lsurvrate "Liver/alcohol survival rate"
        la var Hsurvrate "Heart disease survival rate"
        la var Csurvrate "Cancer survival rate"
        la var lungCsurvrate "Lung cancer survival rate"
        la var CDsurvrate "Cerebrovascular survival rate"
        la var CLsurvrate "Chronic lower respiratory disease survival rate"
        la var CLsurvrate "Chronic lower respiratory disease survival rate"
        la var Dsurvrate "Deaths of despair (= P + S + L) survival rate"
        la var Rsurvrate "Regular (= C + H) survival rate"
        la var Asurvrate "Accidents survival rate"
        la var Osurvrate "Other diseases survival rate"
        la var ORsurvrate "Other respiratory diseases survival rate (subset of Osurvrate)"
        la var OVsurvrate "Other viral diseases survival rate (subset of Osurvrate)"

/* 
        la var icd10amort "Infectious diseases mortality "
        la var icd10bmort "Infectious diseases mortality "
        la var icd10dmort "Blood diseases mortality " 
        la var icd10emort "Endocrine diseases mortality " 
        la var icd10fmort "Mental disorders mortality " 
        la var icd10gmort "Nervous system diseases mortality " 
        la var icd10hmort "Ear diseases mortality " 
        la var icd10imort "Other heart diseases mortality " 
        la var icd10jmort "Other respiratory diseases mortality " 
        la var icd10kmort "Digestive diseases mortality " 
        la var icd10lmort "Skin diseases mortality " 
        la var icd10mmort "Musculoskeletal diseases mortality " 
        la var icd10nmort "Genitourinary diseases mortality " 
        la var icd10omort "Pregnancy mortality " 
        la var icd10pmort "Perinatal mortality " 
        la var icd10qmort "Congenital malformations/deformations mortality " 
        la var icd10rmort "Not elsewhere classified mortality " 

        la var icd10amortrate "Infectious diseases mortality rate"
        la var icd10bmortrate "Infectious diseases mortality rate"
        la var icd10dmortrate "Blood diseases mortality rate" 
        la var icd10emortrate "Endocrine diseases mortality rate" 
        la var icd10fmortrate "Mental disorders mortality rate" 
        la var icd10gmortrate "Nervous system diseases mortality rate" 
        la var icd10hmortrate "Ear diseases mortality rate" 
        la var icd10imortrate "Other heart diseases mortality rate" 
        la var icd10jmortrate "Other respiratory diseases mortality rate" 
        la var icd10kmortrate "Digestive diseases mortality rate" 
        la var icd10lmortrate "Skin diseases mortality rate" 
        la var icd10mmortrate "Musculoskeletal diseases mortality rate" 
        la var icd10nmortrate "Genitourinary diseases mortality rate" 
        la var icd10omortrate "Pregnancy mortality rate" 
        la var icd10pmortrate "Perinatal mortality rate" 
        la var icd10qmortrate "Congenital malformations/deformations mortality rate" 
        la var icd10rmortrate "Not elsewhere classified mortality rate" 


        la var icd10asurvrate "Infectious diseases survival rate"
        la var icd10bsurvrate "Infectious diseases survival rate"
        la var icd10dsurvrate "Blood diseases survival rate" 
        la var icd10esurvrate "Endocrine diseases survival rate" 
        la var icd10fsurvrate "Mental disorders survival rate" 
        la var icd10gsurvrate "Nervous system diseases survival rate" 
        la var icd10hsurvrate "Ear diseases survival rate" 
        la var icd10isurvrate "Other heart diseases survival rate" 
        la var icd10jsurvrate "Other respiratory diseases survival rate" 
        la var icd10ksurvrate "Digestive diseases survival rate" 
        la var icd10lsurvrate "Skin diseases survival rate" 
        la var icd10msurvrate "Musculoskeletal diseases survival rate" 
        la var icd10nsurvrate "Genitourinary diseases survival rate" 
        la var icd10osurvrate "Pregnancy survival rate" 
        la var icd10psurvrate "Perinatal survival rate" 
        la var icd10qsurvrate "Congenital malformations/deformations survival rate" 
        la var icd10rsurvrate "Not elsewhere classified survival rate" 
*/
end

/************/
/* replace variable names */
/*************************/
capture pr drop prepforexport
capture pr define prepforexport

ren (Ts* Tm* TP* P* S* L* H* Cm* Cs* lungC* CD* CL* D* R* A* Om* Os* OR* OV*)  (ts* tm* tp* p* s* l* h* cm* cs* lungc* cd* cl* d* r* a* om* os* or* ov*)   
ren wbho race  
ren *, lower

end 


/*************************/
/* first prep the ranks  */
/*************************/

capture pr drop prepfiles
capture pr define prepfiles
syntax, [etype(string) dropstates instoff granage supplementalfiles nchs ]

    /* get a suffix that encodes all the variables you have */
    local suffix = "`etype'`dropstates'`instoff'`granage'"
    local appendsuffix = "`etype'`dropstates'`granage'"

    if ("`nchs'" == "") local data = "$mdata/int"
    if ("`nchs'" != "") local data = "$mdata/int/nchs"

    /* for merging: you need the "dropstates" to be on" */ 
    if ("`nchs'" != "") local dropstates = "dropstates"

    /* get age group  */
        if "`granage'" != "" { 
          local age_gp = "age"
        }
        if "`age_gp'" == "" {
          local age_gp = "age_gp"
        }

    /* load cps data */
            clear 
              local counter 0 
              gen wbho = . 
              foreach race in WNH BNH H O {

               append using `data'/`race'rates`appendsuffix'
                local counter = `counter' + 1
                replace wbho = `counter' if wbho == .
            }

    /* drop the mortality rate */
          drop *rate

    /* several obs in small cells are missing for several mortality. this is because of the
    proportionate allotment of educations when missing. in particular, if all four education groups have
    no deaths of a certain type, then it remains missing. we fix that at this stage. */
        foreach mortality of varlist *mort {
            replace `mortality' = 0 if mi(`mortality')
        }

        /* there are some cells with no cps any more. so we need to get around the assert condition */
        local granageassert = "master"
        local assert = "" 

      /* merge in institutionalized numbers, as long as "institutionalized off" not invoked */
    if "`instoff'" == "" {
          merge 1:1 edclass`etype' wbho `age_gp' sex year using $mdata/int/inst_pops`etype'`dropstates'`granage', ///
                           assert(``granage'assert' using match) keep(master match) nogen

          replace inst = 0 if inst == . 
          replace TPop = inst + non_inst 
    }

    /* get total population in rolling 5 year bins */
    egen demo_group = group(wbho `age_gp' sex edclass`etype')
    unique demo_group year 
    assert `r(unique)' == _N

    tsset demo_group year

    /* obtain the lags and leads of the population */ 
    gen lag_2_TPop = L2.TPop
    gen lag_1_TPop = L1.TPop
    gen lead_1_TPop = F1.TPop
    gen lead_2_TPop = F2.TPop
    
    /* these should all be non-missing, except in the granage case where some cells are
    not in the CPS */ 
    if "`granage'" == "" {
        assert !mi(TPop) 
        assert !mi(lag_2_TPop) if inrange(year,1994,2018)
        assert !mi(lead_2_TPop) if inrange(year,1992,2016) 
        assert !mi(lag_1_TPop) if inrange(year,1993,2018)
        assert !mi(lead_1_TPop) if inrange(year,1992,2017) 
    }

    /* get 5 year rolling average */ 
    egen double TPop_rolling_5 = rowmean(lag_2_TPop lag_1_TPop TPop lead_1_TPop lead_2_TPop)
    assert !mi(TPop_rolling_5) 
    
    /* get 3-year rolling average */ 
    egen TPop_rolling_3 = rowmean(lag_1_TPop TPop lead_1_TPop)

    /* for 1993 and 2017, we use a 3-year rolling average (bc 5 year window not available) */
    replace TPop_rolling_5 = . if inlist(year,1993,2017)
    replace TPop_rolling_5 = TPop_rolling_3 if inlist(year,1993,2017)
    assert !mi(TPop_rolling_3) if inlist(year,1993,2017)
    drop TPop_rolling_3

    /* for 1992 and 2018 we need to implement a regression strategy. We take the best-fit line
    for 1992 and 2018 using the prior 3 years, within each demographic group */
    qui levelsof demo_group, local(demos)
    foreach demo in `demos' {

        local error = . 
        cap drop yhat
        if mod(`demo',50) == 0 noisily di "imputing demo `demo'"

        /* linearly impute year 2018 */ 
        qui reg TPop year if inrange(year,2016,2018) & demo_group == `demo'
        qui predict double yhat, xb
        qui replace TPop_rolling_5 = yhat if year == 2018 & demo_group == `demo'

        /* linearly impute year 1992 */ 
        cap drop yhat
        cap qui reg TPop year if inrange(year,1992,1994) & demo_group == `demo'

        /* when you do this with granular ages there are a few cells where you don't have 3 years of data.
            in that case, just give them the 5-year rolling average.
            this is better than linearly imputing, which can give strange results
             because often extrapolating out of sample. */

        local error = _rc 
        if "`granage'" == "" assert `error' == 0

        if `error' == 0 {
            qui predict double yhat, xb
            qui replace TPop_rolling_5 = yhat if year == 1992 & demo_group == `demo' & yhat > 0 & !mi(yhat)
        }
    }

    assert !mi(TPop_rolling_5)

    ren TPop raw_TPop

    /* obtain yearly ranks */
    edranks, type(race_sex) etype(`etype') `granage' 
    edranks, type(sex) etype(`etype') `granage' 
    edranks, type(all) etype(`etype') `granage' 

    /* get deaths of despair */
    gen Dmort = Smort + Pmort + Lmort
    gen Rmort = Hmort + Cmort

      /***************************************/
      /* /\* get mortality for all races *\/ */
      /***************************************/
    if "`granage'" == "" { 
      tempfile granular_races
      save `granular_races' 
      collapse (sum) *TPop* *mort, by(`age_gp' year edclass`etype' ed_rank_all ed_rank_sex cum_ed_rank_all cum_ed_rank_sex sex)
      gen wbho = 0

      gen ed_rank_race_sex = ed_rank_sex
      gen cum_ed_rank_race_sex = cum_ed_rank_sex 

      /* put back into main dataset */ 
      append using `granular_races'
    }

      /* obtain rates */
      foreach var in T P S L H C lungC CD CL D R A O OR OV ///
        icd10a icd10b icd10d icd10e icd10f icd10g icd10h icd10i icd10j icd10k icd10l icd10m icd10n icd10o icd10p ///
         icd10q icd10r {
    
        gen `var'mortrate = `var'mort/TPop_rolling_5 * 100000
        gen `var'survrate = 100000 - `var'mortrate 
      }

      keep if inrange(year,1992,2018)

      /* because we are averaging and then summing and there are some missing variables,
           we drop the "all race" from granage. See note in readme. */
      
      if "`granage'" != "" drop if wbho == 0

      /* export yearly file */
      labelvars
      prepforexport 
      export delimited using `data'/appended_rank_mort`suffix'.csv, replace nolab

      assert !mi(tmortrate)
      assert tpop_rolling >= 0

      /* save a yearly file */
      save `data'/appended_rank_mort`suffix', replace 

end
prepfiles, nchs granage
prepfiles, nchs
prepfiles, nchs etype(_3bin)


