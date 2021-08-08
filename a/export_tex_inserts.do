/* load data  */
use $mdata/int/bounds/mort_bounds_all, clear

cap !rm -f $out/tex_constant.tex
cap !rm -f $out/tex_constant.csv

keep if target == "10-45-70" & spec == "mon" & float(f2) == float(0.03)

/************************************************************/
/* loop over each subgroup using a series of if statements  */
/************************************************************/

foreach gender in 1 2 {
  
if "`gender'" == "1" local gname = "male" 
if "`gender'" == "2" local gname = "female"
  
  foreach race in 1 2 {
    if "`race'" == "1" local rname = "white"
    if "`race'" == "2" local rname = "black"

    foreach age in 25 50 {
      if "`age'" == "25" local aname = "young"
      if "`age'" == "50" local aname = "middle"

      foreach edclass in 1 2 4 {
        if "`edclass'" == "1" local ename = "lesshs"
        if "`edclass'" == "2" local ename = "hs" 
        if "`edclass'" == "3" local ename = "somecoll"
        if "`edclass'" == "4" local ename = "coll"

        foreach ranktype in sex {
          local rankname = subinstr("`ranktype'","_","",.)
          
          foreach cause in total despair {

            foreach year in 1992 2016 {
              if "`year'" == "1992" local yearname = "pre" 
              if "`year'" == "2016" local yearname = "post" 

              foreach bound in lb ub {

                /* get the bound for this specific cell and put into a tex insert */ 
                sum mu_`bound' if sex == `gender' & race == `race' & age == `age' & ///
                    edclass == `edclass' & year == `year' & cause == "`cause'" ///
                    & ranktype == "`ranktype'"

                assert `r(N)' == 1
                local mean: di %10.0f `r(mean)'
                store_tex_constant, file($out/tex_constant) ///
                    idshort(`bound'`cause'`rankname'`yearname'`ename'`rname'`gname'`aname') ///
                    idlong(`bound'`cause'`rankname'`yearname'`ename'`rname'`gname'`aname') ///
                    desc("Mortality: `cause'; rank: `ranktype'; sex: `gname'; race: `rname'; age: `age'; year: `year'; edclass: `ename'") value(`mean')
                
              }
              
            }            

            /* get bounds on percent changes */
            sum mu_lb if sex == `gender' & race == `race' & age == `age' & ///
                edclass == `edclass' & year == 1992 & cause == "`cause'" ///
                & ranktype == "`ranktype'"
            
            assert `r(N)' == 1 
            local lb_pre = `r(mean)'

            sum mu_ub if sex == `gender' & race == `race' & age == `age' & ///
                edclass == `edclass' & year == 1992 & cause == "`cause'" ///
                & ranktype == "`ranktype'"
            
            assert `r(N)' == 1             
            local ub_pre = `r(mean)'

              sum mu_lb if sex == `gender' & race == `race' & age == `age' & ///
                  edclass == `edclass' & year == 2016 & cause == "`cause'" ///
                  & ranktype == "`ranktype'"
            assert `r(N)' == 1             
              local lb_post = `r(mean)'

           sum mu_ub if sex == `gender' & race == `race' & age == `age' & ///
                  edclass == `edclass' & year == 2016 & cause == "`cause'" ///
                  & ranktype == "`ranktype'"
            assert `r(N)' == 1             
              local ub_post = `r(mean)'
              
            local ub_change: di %10.0f  (`ub_post' / `lb_pre') * 100 - 100
              store_tex_constant, file($out/tex_constant) ///
                  idshort(ub`cause'`rankname'change`ename'`rname'`gname'`aname') ///
                  idlong(ub`cause'`rankname'change`ename'`rname'`gname'`aname') ///
                  desc("N/A") value(`ub_change')                

              local lb_change: di %10.0f (`lb_post' / `ub_pre') * 100 - 100
              store_tex_constant, file($out/tex_constant) ///
                  idshort(lb`cause'`rankname'change`ename'`rname'`gname'`aname') ///
                  idlong(lb`cause'`rankname'change`ename'`rname'`gname'`aname') ///
                  desc("N/A") value(`lb_change')

            
          }
        }

      }
    }
    
  }
}

