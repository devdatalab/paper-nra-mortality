
// set up Naives
// set up outcomes
// load moments
// get naive estimate
// get other moments
// get "true" estimate
// write to a CSV
// convert to a .tex

capture pr drop bias_table
capture pr define bias_table
{
  syntax, race(string) ages(string) deathtypes(string) gender(string) rank(string) edclass(string) [_3bin]

  global fn ~/iec1/output/mortality/bias_`race'_`gender'_`rank'_`edclass'_`deathtypes'.tex
  
  capture file close fh 
  file open fh using $fn, write replace 
  *        file write fh "Age&Outcome&Original Est.&Set ID'd Interval" _n
  file write fh "Age&Original Est.&Set ID'd Interval" _n
  file write fh "\hline" 
  
  foreach outcome in `deathtypes' {
    foreach age in `ages' {
      
      
      local whitenum 1
      local blacknum 2
      local hispnum 3
      local othernum 4
      local allnum 5
      local nm25 "25-29" 
      local nm30 "30-34" 
      local nm35 "35-39"
      local nm40 "40-44" 
      local nm45 "45-49"
      local nm50 "50-54" 
      local nm55 "55-59" 
      local nm60 "60-64" 
      local nm65 "65-69"

      /* get the naive mortality */ 
      use ~/iec1/mortality/outfiles/appended_rank_mort`_3bin', clear
      sum `outcome'mortrate if age == `age' & year == 1992 & sex == `gender' & edclass == `edclass' & wbho == ``race'num'
      local naive_pre = `r(mean)'
      
      sum `outcome'mortrate if age == `age' & year == 2015 & sex == `gender' & edclass == `edclass' & wbho == ``race'num' 
      local naive_post = `r(mean)'
      
      local naive = `naive_post' - `naive_pre' 
      /* get the mu bounds */
      if `edclass' == 1 {
        local mu_lower = 0
        
        sum cum_ed_rank_`rank' if age == `age' & year == 1992 & sex == `gender' & edclass == `edclass'  & wbho == ``race'num'
        local mu_upper = `r(mean)'  * 100 
      }
      if `edclass' > 1 {
        sum cum_ed_rank_`rank' if age == `age' & year == 1992 & sex == `gender' & edclass == `edclass' - 1 & wbho == ``race'num'
        local mu_lower = `r(mean)' * 100 
        
        sum cum_ed_rank_`rank' if age == `age' & year == 1992 & sex == `gender' & edclass == `edclass' & wbho == ``race'num'
        local mu_upper = `r(mean)' * 100 
        
      }
      
      local loutcome = lower("`outcome'")

      local tt Total Mortality 
      local dt Deaths of Despair
      local pt Poisoning 
      local st Suicide
      local lt Alcoholic Liver
      local ht Heart Disease
      local ct Cancer
      
      /* obtain the change in mu */
      import delimited using ~/iec1/mortality/moments/2015/`race'_`gender'_`age'_`rank'_`loutcome'survrate`_3bin'.csv, clear
      stop
      
      bound_param , xvar(ed_rank_`rank') yvar(`loutcome'survrate) s(`mu_lower') t(`mu_upper') maxmom(100000) minmom(0)
      local min_post = 100000 - `r(mu_upper_bound)' 
      local max_post = 100000 - `r(mu_lower_bound)' 

      local max_increase = `max_post' - `naive_pre'
      local min_increase = `min_post' - `naive_pre'
      di "`naive_pre', `naive_post', `naive'" 

      file write fh "`nm`age''&"
      file write fh %5.1f (`naive') "&"

      /* obtain if the sign changes */
      local changes_sign = "N"

      if `min_increase' > 0 & `naive' < 0 | `max_increase' < 0 & `naive' > 0 {
        local changes_sign = "Y"
      }

      if "`changes_sign'" == "Y" {
        file write fh "{\color{red}" 
        file write fh "[" 
        file write fh %5.1f  (`min_increase')
        file write fh ", " 
        file write fh %5.1f (`max_increase')        
        file write fh " ]" "}" _n 
      }
      else {
        
        file write fh "[" 
        file write fh %5.1f  (`min_increase')
        file write fh ", " 
        file write fh %5.1f (`max_increase')        
        file write fh " ]" _n
      }          
    }
  }
  file write fh "\hline" _n
  file close fh
  
  /* hack and convert to latex */ 
  !sed -i 's/$/ \\\\ /g' $fn

  import delimited using $fn, clear

  di "Wrote file $fn."
}
end

bias_table, race(all) ages(25 30 35 40 45 50 55 60 65) deathtypes(T) gender(2) rank(sex) edclass(1) _3bin




bias_table, race(all) ages(25 30 35 40 45 50 55 60 65) deathtypes(T) gender(2) rank(sex) edclass(1) _3bin
bias_table, race(all) ages(25 30 35 40 45 50 55 60 65) deathtypes(D) gender(2) rank(sex) edclass(1) _3bin
bias_table, race(all) ages(25 30 35 40 45 50 55 60 65) deathtypes(D) gender(2) rank(sex) edclass(2) _3bin

