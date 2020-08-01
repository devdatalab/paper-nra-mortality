/**********************************************************/
/* /\* this dofile makes a datafile of changes by age *\/ */
/**********************************************************/

/* This differs from table_changes, which makes a version for
beamers. this makes a version for the paper itself. */

capture pr drop table_changes_paper
capture pr define table_changes_paper
syntax, race(string) sex(string) type(string) [spec(string) ranktype(string)] 

/******************************************************/
/* write the parameters to be pulled into a template  */
/******************************************************/
    /* load data  */
    use $tmp/appended_trends, clear

if "`spec'" == "" { 
  local spec = "mon-step" 
}
if "`ranktype'" == "" {
  local ranktype = "sex"
}

    /* open csv  */
    capture file close fh
    capture file open fh using ~/iec1/output/mort-desc/params_paper_changes_`sex'_`race'_`type'`spec'.csv, write replace

    /* loop over all ages */
foreach edclass in 1 2 3 4 { 
    foreach age of numlist 35(5)60 {

            /* loop over absolute changes and proportions */
            foreach abs in "pd_"  {

              local tcause = "Total" 
              
              /* obtain and write the parameter */
              di `" race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" "'
              noisily list if  race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" & ranktype == "`ranktype'" 
              noisily {
                
                unique race sex age edclass type spec
                di "`abs'sex_1992_2013_2_`bound', `age'"
                
                noisily sum mu_lb if race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" & year == 1992 & ranktype == "`ranktype'"  , f 
                capture local lb_1992 = `r(mean)'

                noisily sum mu_ub if race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" & year == 1992 & ranktype == "`ranktype'" , f 
                local ub_1992 = `r(mean)'

                noisily sum mu_lb if race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" & year == 2015  & ranktype == "`ranktype'" , f 
                local lb_2015 = `r(mean)'

                noisily sum mu_ub if race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" & year == 2015  & ranktype == "`ranktype'" , f 
                local ub_2015 = `r(mean)'
                
                assert `r(N)' <= 1

                local baseline_midpoint = (`ub_1992' + `lb_1992')/2
                
                if `r(N)' == 0 {
                  local r(mean) = .
                }
              }
              
              file write fh "`abs'age_`age'_lb_`edclass',"
              local min = (`lb_2015' - `ub_1992') / `baseline_midpoint' * 100
              file write fh %5.1f (`min') _n

              file write fh "`abs'age_`age'_ub_`edclass',"
              local max = ( `ub_2015' - `lb_1992' )  / `baseline_midpoint' * 100
              file write fh %5.1f (`max') _n
              
              /* close absolute and proportionate */
            }

    /* close age loop */
    }

    /* close edclass loop */
  }

    file close fh 

    /*********************************************/
    /* /\* /\\* convert to a tex table *\\/  *\/ */
    /*********************************************/
    table_from_tpl, t(~/iecmerge/mortality/tex/table_changes_template.tex) o(~/iec1/output/mort-desc/table_paper_changes_`sex'_`race'_`type'`spec'.tex) r(~/iec1/output/mort-desc/params_paper_changes_`sex'_`race'_`type'`spec'.csv)
end 

table_changes_paper, race(1) sex(1)  type(t) 
table_changes_paper, race(1) sex(2)  type(t) 
table_changes_paper, race(2) sex(1)  type(t) 
table_changes_paper, race(2) sex(2)  type(t) 

table_changes_paper, race(1) sex(1)  type(t) spec(mon)
table_changes_paper, race(1) sex(2)  type(t) spec(mon)
table_changes_paper, race(2) sex(1)  type(t) spec(mon)
table_changes_paper, race(2) sex(2)  type(t) spec(mon)
