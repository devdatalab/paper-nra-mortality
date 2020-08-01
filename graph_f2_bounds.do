
cd ~/iec1/mortality/case_deaton_replicate


/*************************************************************/
/* graph plots of mu bounds for a fixed age group, combining */
/* via the mu                                                */
/*************************************************************/

foreach race in white black  {
  foreach gender in 1 2 {
    foreach rank in sex {
      foreach age in 45  {
        foreach f2 in 1 5 10 { 
          foreach outcome in t d {       

            /* scatter plot parameters */
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


            /****************/
            /* scatter 0-10 */
            /****************/

            import delimited using bounds/mu_0_10_`race'_`gender'_`age'_`rank'_`f2'_`outcome'rate.csv, clear

            replace lb = -lb
            replace ub = -ub
            ren lb upper
            ren ub lower                   

            twoway rcap upper lower cohort, color(black) title(0-10) ///
              xlabel(1990 "92-94" 1995 "95-99" 2000 "00-04" 2005 "05-09" 2010 "10-15") xtitle("Year") ///
                ytitle("Deaths/100,000") name(_0_10, replace) 



            /****************/
            /* scatter 10-45 */
            /****************/

            import delimited using bounds/mu_10_45_`race'_`gender'_`age'_`rank'_`f2'_`outcome'rate.csv, clear

            replace lb = -lb
            replace ub = -ub
            ren lb upper
            ren ub lower


            /****************/
            /* scatter 45-70 */
            /****************/

            twoway rcap upper lower cohort, color(black) title(10-45) ///
              xlabel(1990 "92-94" 1995 "95-99" 2000 "00-04" 2005 "05-09" 2010 "10-15") xtitle("Year") ///
                ytitle("Deaths/100,000") name(_10_45, replace) 

            import delimited using bounds/mu_45_70_`race'_`gender'_`age'_`rank'_`f2'_`outcome'rate.csv, clear              

            replace lb = -lb
            replace ub = -ub
            ren lb upper
            ren ub lower

            /****************/
            /* scatter 70-100 */
            /****************/

            twoway rcap upper lower cohort, color(black) title(45-70) ///
              xlabel(1990 "92-94" 1995 "95-99" 2000 "00-04" 2005 "05-09" 2010 "10-15") xtitle("Year") ///
                ytitle("Deaths/100,000") name(_45_70, replace) 

            import delimited using bounds/mu_70_100_`race'_`gender'_`age'_`rank'_`f2'_`outcome'rate.csv, clear

            replace lb = -lb
            replace ub = -ub
            ren lb upper
            ren ub lower


            twoway rcap upper lower cohort, color(black) title(70-100) ///
              xlabel(1990 "92-94" 1995 "95-99" 2000 "00-04" 2005 "05-09" 2010 "10-15") xtitle("Year") ///
                ytitle("Deaths/100,000") name(_70_100, replace) 

            /************/
            /* combine  */
            /************/

            gr combine _0_10 _10_45 _45_70 _70_100, xcommon title("{&mu}{subscript:`low'}{superscript:`high'} Bounds on Within-Agegroup ``outcome't'")  subtitle("``race't', `st`gender'', ``rank'rt'" "F2 Restriction: `f2'" "Age: `nm`age''") 
            graphout bound_`outcome'rate_`race'_`gender'_`rank'_`f2' , pdf large
          }
        }
      }
    }
  }

}  



/**********************************************/
/* graph pictures for a FIXED mu (here, 0-10) */
/* but varying the ages                       */
/**********************************************/
foreach f2 in 10 100 { 
  foreach race in white  {
    foreach gender in 0 1 2 {
      foreach rank in sex {
        foreach age in 35 40 45 50 55 60 {

          
          import delimited using bounds/mu50_`race'_`gender'_`age'_`rank'_`f2'_trate.csv, clear

          replace lb = -lb
          replace ub = -ub
          ren lb upper
          ren ub lower

          /* scatter */
          local nm25 "25-29" 
          local nm30 "30-34" 
          local nm35 "35-39"
          local nm40 "40-44" 
          local nm45 "45-49"
          local nm50 "50-54" 
          local nm55 "55-59" 
          local nm60 "60-64" 
          local nm65 "65-69"
          local tt Total 
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


          
          twoway rcap upper lower cohort, color(black) title(Age `nm`age'') ///
            xlabel(1990 "92-94" 1995 "95-99" 2000 "00-04" 2005 "05-09" 2010 "10-15") xtitle("Year") ///
              ytitle("Deaths/100,000") name(_`age', replace) 
        }

        gr combine _35 _40 _45 _50 _55 _60, xcommon title("{&mu}{subscript:`low'}{superscript:`high'} Bounds on Within-Agegroup ``outcome't' Mortality")  subtitle("``race't', `st`gender'', ``rank'rt'") 
        graphout bound_trate_0_50_`race'_`gender'_`rank'_`f2' , pdf large        
      }
    }
  }
}


}

