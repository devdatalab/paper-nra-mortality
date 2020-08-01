/**********************************************************/
/* /\* this dofile makes a datafile of changes by age *\/ */
/**********************************************************/
capture pr drop table_changes
capture pr define table_changes
syntax, race(string) sex(string) edclass(string) type(string) [spec(string)] 


/******************************************************/
/* write the parameters to be pulled into a template  */
/******************************************************/
    /* load data  */
    use $tmp/bounds_all_causes, clear

if "`spec'" == "" { 
  local spec = "mon_inf" 
}
    /* open csv  */
    capture file close fh
    capture file open fh using ~/iec1/output/mort-desc/params_changes_`sex'_`race'_`edclass'_`type'`spec'.csv, write replace

    /* loop over all ages */ 
    foreach age of numlist 25(5)65 {

        /* loop over high and low */ 
        foreach bound in lb ub {

            /* loop over absolute changes and proportions */
            foreach abs in "pd_" "delta_" {

              local t = "mon_inf"
              local mont = "no_mon"
              local mont = "mon"
              local mon_inft = "mon_inf"

              local tcause = "Total" 
              
                  /* obtain and write the parameter */
              *list if  race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & cause == "``type'cause'" & spec == "``spec't'"
              noisily {
                unique race sex age edclass cause spec
                di "`abs'sex_1992_2013_2_`bound', `age'" 
                  noisily sum `abs'sex_1992_2013_2_`bound' if race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & cause == "``type'cause'" & spec == "``spec't'", f
                assert `r(N)' <= 1

                if `r(N)' == 0 {
                  local r(mean) = .
                }
              }
                      file write fh "`abs'age_`age'_`bound',"
              if "`r(mean)'" != "" {
                      file write fh %5.2f (`r(mean)') _n 
                    }
              else {
                file write fh _n
              }
              /* close absolute and proportionate */
            }

        /* close high low */
        }  

    /* close age loop */
    }
        file close fh 

    /*********************************************/
    /* /\* /\\* convert to a tex table *\\/  *\/ */
    /*********************************************/
    table_from_tpl, t(~/iec1/output/mort-desc/changes_template.tex) o(~/iec1/output/mort-desc/table_changes_`sex'_`race'_`edclass'_`type'`spec'.tex) r(~/iec1/output/mort-desc/params_changes_`sex'_`race'_`edclass'_`type'`spec'.csv)
end 

table_changes, race(1) sex(1) edclass(1) type(t) 
table_changes, race(1) sex(2) edclass(1) type(t) 
table_changes, race(2) sex(1) edclass(1) type(t) 
table_changes, race(2) sex(2) edclass(1) type(t) 

table_changes, race(1) sex(1) edclass(1) type(t) spec(mon)
table_changes, race(1) sex(2) edclass(1) type(t) spec(mon)
table_changes, race(2) sex(1) edclass(1) type(t) spec(mon)
table_changes, race(2) sex(2) edclass(1) type(t) spec(mon)
