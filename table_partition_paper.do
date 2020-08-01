capture pr drop table_partition_paper
capture pr define table_partition_paper
syntax, race(string) sex(string) edclass(string) [spec(string)] 

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
    capture file open fh using ~/iec1/output/mort-desc/params_paper_partition_`sex'_`race'_`edclass'_`spec'.csv, write replace

    /* loop over all ages */ 
    foreach age of numlist 35(5)60 {

        /* loop over types of deaths */
        foreach type in t d h c a o {

          local t = "mon"
          local no_mont = "no_mon"
          local mont = "mon"
          local mon_inft = "mon_inf"

          /* obtain and write the parameter */
          noisily list if  race == `race' & sex == `sex' & age == `age' & edclass == `edclass' & type == "`type'" & spec == "`spec'" & ranktype == "`ranktype'" 

            di "`age', `type'"

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

          file write fh "`type'`abs'age_`age'_lb,"
          local min = (`lb_2015' - `ub_1992') / `baseline_midpoint' * 100
          file write fh %5.1f (`min') _n

          file write fh "`type'`abs'age_`age'_ub,"
          local max = ( `ub_2015' - `lb_1992' )  / `baseline_midpoint' * 100
          file write fh %5.1f (`max') _n

          
            /* close loop over types */
          }

          /* close age loop */
        }
        file close fh 

    /*********************************************/
    /* /\* /\\* convert to a tex table *\\/  *\/ */
    /*********************************************/
    table_from_tpl, t(~/iecmerge/mortality/tex/table_partition_template.tex) o(~/iec1/output/mort-desc/table_paper_partition_`sex'_`race'_`edclass'_`spec'.tex) r(~/iec1/output/mort-desc/params_paper_partition_`sex'_`race'_`edclass'_`spec'.csv)
end 

foreach i in 1 2 3 4 { 
*foreach i in 1 { 
  table_partition_paper, race(1) sex(1) edclass(`i') 
  table_partition_paper, race(1) sex(2) edclass(`i') 
  table_partition_paper, race(2) sex(1) edclass(`i') 
  table_partition_paper, race(2) sex(2) edclass(`i') 
}


