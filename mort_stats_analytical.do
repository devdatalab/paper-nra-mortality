/*************************/
/* invoke bound program  */
/*************************/
capture pr drop an_mort
pr define an_mort
syntax, output_folder(string) cohorts(string) ranks(string) sex(string) races(string) ages(string) mus(string) deathtypes(string) [_3bin moments(string)]
        /* create mus to loop over  */
        if "`mus'" == "custom" {
                local s1 0
                local s2 10
                local s3 45
                local s4 70
                local t1 10
                local t2 45
                local t3 70
                local t4 100
                local mucuts 4
              }


        if "`mus'" == "deciles" {
                local s1 0
                local s2 10
                local s3 20
                local s4 30
                local s5 40
                local s6 50 
                local s7 60 
                local s8 70 
                local s9 80 
                local s10 90
                local t1 10 
                local t2 20
                local t3 30
                local t4 40
                local t5 50 
                local t6 60
                local t7 70
                local t8 80
                local t9 90
                local t10 100
                local mucuts 10
        }

        if "`mus'" == "quartiles" {
                local s1 0
                local s2 25
                local s3 50
                local s4 75
                local t1 25
                local t2 50
                local t3 75
                local t4 100
                local mucuts 4
        }

if "`mus'" == "_3bin" {
                local s1 0
                local s2 64
                local s3 83
                local t1 64
                local t2 83
                local t3 100
                local mucuts 3
}

if "`mus'" == "vals_of_interest" {
                local s1 0
                local s2 0 
                local s3 0
                local t1 20
                local t2 50 
                local t3 39
                local mucuts 3
}

if "`mus'" == "male_vals" {
                local s1 0
                local s2 54 
                local s3 73
                local t1 54
                local t2 73 
                local t3 100 
                local mucuts 3
}


if "`mus'" == "all_vals" {
                local s1 0
                local s2 59
                local s3 78
                local t1 59
                local t2 78 
                local t3 100 
                local mucuts 3
}



        if inlist("`mus'","custom","deciles","quartiles","_3bin","vals_of_interest","all_vals","male_vals") != 1 {
          di "must be custom, deciles, or quartiles"
          stop
        }

/* get a moments folder */
if "`moments'" == "" {
  local moments = "~/iec1/mortality/moments/"
}


        foreach age in `ages' { 
        foreach death in `deathtypes' { 
        foreach rank in `ranks' { 
        foreach gender in `sex' { 
        foreach race in `races'  {
          forv mu = 1/`mucuts' {
          foreach cohort in `cohorts' {

            import delimited using `moments'/`cohort'/`race'_`gender'_`age'_`rank'_`death'survrate`_3bin'.csv, clear 
            bound_param, xvar(ed_rank_`rank') yvar(`death'survrate) s(`s`mu'') t(`t`mu'') maxmom(100000) minmom(0)
            clear
            set obs 1 
            gen year = "`cohort'"
            gen ub = `r(mu_upper_bound)'
            gen lb = `r(mu_lower_bound)'
            gen f2 = 999 
            tempfile years`cohort'
            save `years`cohort''
          }

          /* append file */
          clear 
          foreach cohort in `cohorts' {
            append using `years`cohort''
          }
          

          /* export bounds file  */
          order f2 year lb ub
          export delimited using `output_folder'/mu_`s`mu''_`t`mu''_`race'_`gender'_`age'_`rank'_999_`death'rate`_3bin'.csv, replace 

          }
        }
        }
        }
        }
        }


end 
