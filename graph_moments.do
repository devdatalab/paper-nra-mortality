/***********************/
/* graphs the moments  */
/***********************/
capture pr drop graph_moments
capture pr define graph_moments 
syntax, races(string) ages(string) deathtypes(string) cohorts(string) genders(string) ranks(string) height(int) [bands _3bin fixedy ylabel(passthru)] 

/*************************/
/* * import the moments  */
/*************************/

cd ~/iec1/mortality/
use $mortality/outfiles/nchs/appended_rank_mort, clear
preserve 
    foreach age in `ages' {
      foreach outcome in `deathtypes' {
        foreach cohort in `cohorts' {
          foreach gender in `genders'   {
            foreach rank in `ranks' {
              local whitenum = 1
              local allnum = 0
              local blacknum = 2
              local hispnum = 3
              local othernum = 4 

              keep if year == `cohorts' & sex == `genders' & race == ``races'num' & age == `age' 
              count

                    local nm25 "25-29" 
                    local nm30 "30-34" 
                    local nm35 "35-39"
                    local nm40 "40-44" 
                    local nm45 "45-49"
                    local nm50 "50-54" 
                    local nm55 "55-59" 
                    local nm60 "60-64" 
                    local nm65 "65-69"
                    local tt Total Mortality 
                    local dt Deaths of Dispair
                    local pt Poisoning 
                    local st Suicide
                    local lt Alcoholic Liver
                    local ht Heart Disease
                    local ct Cancer

                    local allrt = "rank within entire population"
                    local race_sexrt = "rank within race/gender group"
                    local sexrt = "rank within gender group"
                    local whitet = "White"
                    local blackt = "Black"
                    local hispt = "Hispanic"
                    local othert = "Other"
                    local st0 = "all"
                    local st1 = "men"
                    local st2 = "women"

              if "`_3bin'" != "" { 
                    local ed1 = "{&le}HS"
                    local ed2 = "Some College"
                    local ed3 = "{&ge}BA" 
                  }

              else {
                    local ed1 = "<HS"
                    local ed2 = "HS"
                    local ed3 = "Some College" 
                    local ed4 = "BA+" 
                  }
              
                      /* formatting */ 
                      ren ed_rank_sex p
                      ren `deathtypes'survrate moment 
                      replace moment = 100000 - moment

              *graph_moments, races(white) ages(50) deathtypes(t) cohorts(2015) genders(2) ranks(sex) ylabel(0(500)2000)
             
              
              /* obtain bin cuts */
              gen cumul_rank = 2 * p if _n == 1
              replace cumul_rank = 2 * (p - cumul_rank[_n-1])  + cumul_rank[_n-1] if _n > 1 

              local cumul_bins_prior = 0 
              /* put into locals */
              local n = _N 
              forv bins = 1/`n' {
                local cut_`bins' = cumul_rank[`bins'] 
                local allcuts = "`allcuts'" + " `cut_`bins''"
                local hcut = (`cut_`bins'' - `cumul_bins_prior')/ 2 + `cumul_bins_prior'
                local halfcuts = `"`halfcuts'"' + `"`height' `hcut'  " `bins':" "`ed`bins''"  "'
                local cumul_bins_prior = `cut_`bins''
              }


               scatter moment p, msymbol(O) mcolor(black) legend(off) xtitle("Education Rank (within gender and year)", size(large)) ytitle("Deaths/100,000", size(large)) ///
                 xline(0 `allcuts', lcolor(black) lpattern(_) lwidth(thick)) xlabel(0(25)100) ylabel(#5)  text(`halfcuts', size(large)) `ylabel' 
                    graphout moment_`cohort'_`races'_`gender'_`age'_`rank'_`outcome'mortrate, pdf large

              /*********************/
              /* make banded plot  */
              /*********************/

              if "`bands'" != "" {
              gen cumul_rank_prior = cumul_rank[_n-1]
              replace cumul_rank_prior = 0 if _n == 1

              /* paired coordinate plot */
              twoway pcspike moment cumul_rank   moment cumul_rank_prior, mcolor(gs0) lcolor(gs0) xtitle("Education Rank (within gender and year)" , size(large)) ytitle("Deaths/100,000", size(large)) ///
                               xline(0 `allcuts', lcolor(gs0) lpattern(_) lwidth(thick)) xlabel(0(25)100) ylabel(#5) text(`halfcuts', size(large)) `ylabel' 

              graphout band_`cohort'_`races'_`gender'_`age'_`rank'_`outcome'mortrate, pdf large 

              twoway pcspike moment cumul_rank moment cumul_rank_prior, lcolor(gs0)  xtitle("Education Rank (within gender)", size(large)) ytitle("Deaths/100,000", size(large)) ///
                               xline(0 `allcuts', lcolor(gs0) lpattern(_) lwidth(thick)) xlabel(0(25)100) ylabel(#5) || ///
              scatter moment p, msymbol(O) mcolor(gs0)  xtitle("Education Rank (within gender and year)", size(large)) ytitle("Deaths/100,000") ///
              xlabel(0(25)100) ylabel(#5)  legend(off) text(`halfcuts', size(large)) `ylabel' 

              graphout band_`cohort'_`races'_`gender'_`age'_`rank'_`outcome'mortrate_wdot , pdf large 

              



                  }

            }
          }
        }
      }
}
restore 
end 

/************************************************************************************************************************/
/* graph_moments, races(all) ages(50) deathtypes(t) cohorts(2015b) genders(2) ranks(sex) _3bin bands ylabel(0(200)600)  */
/*                                                                                                                      */
/* !mv $out/moment_2015b_all_2_50_sex_tmortrate.pdf ~/iec1/output/mortality/                                            */
/* !mv $out/band_2015b_all_2_50_sex_tmortrate*.pdf ~/iec1/output/mortality/                                             */
/************************************************************************************************************************/

global out ~/iec1/output/mort-desc
graph_moments, races(white) ages(50) deathtypes(t) cohorts(2015) genders(2) ranks(sex) ylabel(0(500)2000) height(1000)

graph_moments, races(all) ages(50) deathtypes(t) cohorts(2015) genders(2) ranks(sex) ylabel(0(200)1000) height(450)

  
