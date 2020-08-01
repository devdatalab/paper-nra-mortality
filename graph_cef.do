

/****************************/
/* Program to plot the cef  */
/****************************/
capture pr drop graph_cef
capture pr define graph_cef 
syntax, races(string) ages(string) deathtypes(string) cohorts(string) genders(string) ranks(string) f2s(string) output_folder(string) mutype(string) [_3bin fixedy]
cd ~/iec1/mortality/
  foreach race in `races' {
    foreach age in `ages' {
      foreach outcome in `deathtypes' {
        foreach cohort in `cohorts' {
          foreach gender in `genders'   {
            foreach rank in `ranks' { 
              foreach f2  in `f2s' { 

                
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

                            /* load moments */
                            import delimited using moments/`cohort'/`race'_`gender'_`age'_`rank'_`outcome'survrate`_3bin'.csv, clear
                            ren ed_rank p
                            ren `outcome'survrate moment
                            replace moment = 100000-moment 
                            
                            tempfile moments
                            save `moments'
                           
                            /* append bounds */
                            import delimited using `output_folder'/cefmu`mutype'_`cohort'_`race'_`gender'_`age'_`rank'_`f2'_`outcome'survrate`_3bin'.csv, clear
                            append using `moments'

                            /* generate picture */
                            gen lb = 100000-p_max

                            gen ub = 100000-p_min

                            if "`f2'" != "999" & "`f2'" != "0" { 
                              replace p = p * 2 if ub != .
                            }
                                                    if "`fixedy'" != "" {
                          local fixedy "ylabel(0(500)2000) yscale(r(0 2000) noextend )"
                          drop if ub > 2000 & ub != . 
                        }

                            if "`f2'" == "999" {
                              local f2 = "None"
                            }
                            
                            scatter moment p, msymbol(O) mcolor(black) legend(lab(1 "Bin Mean"))  || ///
                            line ub p, lcolor(black) xtitle("Education Rank") ytitle("Deaths/100,000") lpattern(line) || ///
                            line lb p, lcolor(black) xtitle("Education Rank") ytitle("Deaths/100,000") lpattern(line)  ///
                            name(_`f2', replace) legend(lab(3 "Bounds")) legend(order(1 3)) `fixedy'
*                                                          title("Bounds on Within-Agegroup ``outcome't'") subtitle("``race't', `st`gender'', ``rank'rt'" "F2 restriction: `f2'" ) 

                            graphout cef_`cohort'_`race'_`gender'_`age'_`rank'_`f2'_`outcome'mortrate, pdf large 
                          }

            }
          }
        }
      }
    }
  }


end 

