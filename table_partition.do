capture pr drop table_partition
capture pr define table_partition
syntax, race(string) sex(string) edclass(string) [spec(string)] 

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
    capture file open fh using ~/iec1/output/mort-desc/params_partition_`sex'_`race'_`edclass'_`spec'.csv, write replace

    /* loop over all ages */ 
    foreach age of numlist 25(5)60 {

        /* loop over high and low */ 
        foreach bound in lb ub {

            /* loop over absolute partition and proportions */
            foreach type in t d h c a o {

              
              local t = "mon"
              local no_mont = "no_mon"
              local mont = "mon"
              local mon_inft = "mon_inf"

              local tcause = "Total"
              local dcause = "Despair" 
              local hcause = "Heart" 
              local ccause = "Cancer" 
              local acause = "Accident" 
              local ocause = "Other" 
              
                  /* obtain and write the parameter */
              *list if  race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & cause == "``type'cause'" & spec == "``spec't'"
              noisily {
                di "`age', `type'"
                unique race sex age edclass cause spec 
                  capture noisily sum pd_sex_1992_2013_2_`bound' if race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & cause == "``type'cause'" & spec == "``spec't'"

                /* set an error check */ 
              if `r(N)' == 0 {
                local error = "error" 
                   local mean = .
              }
                else {
                  local error = "" 
                  local mean = `r(mean)' 
                }
                di "`mean'"                
              }

              file write fh "`type'age_`age'_`bound',"
              
              if "`error'" != "" {
                file write fh _n 
              }
              else { 
                file write fh %5.2f (`mean') _n
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
    table_from_tpl, t(~/iec1/output/mort-desc/partition_template.tex) o(~/iec1/output/mort-desc/table_partition_`sex'_`race'_`edclass'_`spec'.tex) r(~/iec1/output/mort-desc/params_partition_`sex'_`race'_`edclass'_`spec'.csv)
end 

table_partition, race(1) sex(1) edclass(1) 
table_partition, race(1) sex(2) edclass(1) 
table_partition, race(2) sex(1) edclass(1) 
table_partition, race(2) sex(2) edclass(1) 

      
