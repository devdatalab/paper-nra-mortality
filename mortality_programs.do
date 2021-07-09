/*************************************************************************************************/
/* program bound_mort : Bound a mortality statistic, and generate a new variable with the bounds */
/*************************************************************************************************/
cap prog drop bound_mort
prog def bound_mort, rclass
{
    syntax varlist(min=1 max=1) [if/], s(passthru) t(passthru) gen(string) [by(varname) xvar(string)]

    qui {
    
    capdrop __by __surv
    
      /* set default xvar */
      if mi("`xvar'") {
          local xvar ed_rank_sex
      }
  
      /* handle missing if */
      if mi("`if'") {
          local if 1
      }

    /* handle missing by */
    if mi("`by'") {
      gen __by = 1
      local by __by
    }
    
      /* preserve to generate survival rate */
      preserve

      /* keep requested subset only */
      keep if `if'
    
      /* convert deaths to survival rate */
      tokenize `varlist'
      gen __surv = 100000 - `1'
      
      qui levelsof `by', local(by_values)

      foreach by_value in `by_values' {

        /* check for monotonicity in entire x-variable group */
        sort `by' `xvar'
        cap assert __surv > __surv[_n-1] if `by' == `by_value' & `by'[_n-1] == `by_value'
        if _rc {
          noi di "WARNING: NON-MONOTONIC (`if' & `by' == `by_value')"
          // list `by' `xvar' `1'
          local ub_`by_value' = "."
          local lb_`by_value' = "."
        }

        else {
        
          qui bound_param if `by' == `by_value', xvar(`xvar') yvar(__surv) `s' `t' minmom(0) maxmom(100000)
          local ub_`by_value' = 100000 - `r(mu_lower_bound)'
          local lb_`by_value' = 100000 - `r(mu_upper_bound)'
        }
      }
  
      restore

      /* create empty variable with result if doesn't exist yet */
      cap gen `gen'_lb = .
      cap gen `gen'_ub = .

      /* set all result bounds */
      foreach by_value in `by_values' {

        // di "Bounds are: [" `lb_`by_value'' ", " `ub_`by_value'' "]"
        
        replace `gen'_lb = `lb_`by_value'' if `by' == `by_value' & `if'
        replace `gen'_ub = `ub_`by_value'' if `by' == `by_value' & `if'
      }
    }
    di "Created `gen'_lb and `gen'_ub."
        capdrop __by
}
end
/* *********** END program bound_mort ***************************************** */

/**********************************************************************************/
/* program bound_param : generate analytical bounds on mu-s-t */ 
/* s: lower bound */
/* t: upper bound */
/***********************************************************************************/
capture prog drop bound_param 
prog def bound_param, rclass
  
  syntax [aweight pweight] [if], xvar(string) yvar(string) s(real) t(real) [maxmom(real 100) minmom(real 0) append(string) str(string) forcemono QUIet verbose] 

  preserve

  qui {

    /* keep if if */
    if !mi("`if'") {
      keep `if'
      local ifstring "`if'"
    }

    /* only use "noi" if verbose is specified */
    if !mi("`verbose'") {
      local noi noisily
    }
    
    /* require non-missing xvar and yvar */
    count if mi(`xvar') | mi(`yvar')
    if `r(N)' > 0  & ("`verbose'" != "") {
      `noi' disp "Warning: ignoring `r(N)' rows that are missing `xvar' or `yvar'."
    }
    keep if !mi(`xvar') & !mi(`yvar')

    /* fail with an error message if there's no data left */
    qui count
    if `r(N)' < 2 {
      disp as error "bound_param: Only `r(N)' observations left in sample; cannot bound anything."
      error 456
    }
    
    // Create convenient weight local
    if ("`weight'" != "") {
      local wt [`weight'`exp']
      local longweight = "weight(" + substr("`exp'", 2, .) + ")"
    }

    /* if not monotonic */
    is_monotonic, x(`xvar') y(`yvar') `longweight'
    if `r(is_monotonic)' == 0 {

      /* combine bins to force monotonicity if requested */
      if !mi("`forcemono'") {
        `noi' make_monotonic, x(`xvar') y(`yvar') `longweight' preserve_ranks
        make_monotonic, x(`xvar') y(`yvar') `longweight' preserve_ranks
      }

      /* otherwise fail */
      else {
        display as error "ERROR: bound_param cannot estimate mu with non-monotonic moments"
        local FAILED 1
      }
    }
    
    /* sort by the x variable */
    sort `xvar'
    
    /* collapse on xvar [does nothing if data is already collapsed] */
    collapse (mean) `yvar' `wt' , by(`xvar')
    
    /* rename variables for convenience */
    ren `yvar' y_moment
    ren `xvar' x_moment

    /************************************************/
    /* STEP 1: get moments/cuts  */
    /************************************************/

    /* obtain the cuts from the midpoints */
    sort x_moment
    gen xcuts = x_moment[1] * 2 if _n == 1
    local n = _N
    
    forv i = 2/`n' {
      replace xcuts = (x_moment - xcuts[_n-1]) * 2 + xcuts[_n-1] if _n == `i' 
    }
    replace xcuts = 100 if _n == _N 
    
    /**************************************************/
    /* STEP 2: CONVERT PARAMETERS TO LOCALS */
    /**************************************************/
    /* obtain important parameters and put into locals */
    forv i = 1/`n' {
      
      local y_moment_next_`i' = y_moment[`i'+1]
      local y_moment_prior_`i' = y_moment[`i'-1]
      local y_moment_`i' = y_moment[`i']
      local x_moment_`i' = x_moment[`i']
      local min_bin_`i' = xcuts[`i'-1]
      local max_bin_`i' = xcuts[`i']
      
      local min_bin_1 = 0 
      local max_bin_`n' = 100 
      local y_moment_prior_1 = `minmom' 
      local y_moment_next_`n' = `maxmom' 
      
      /* get the star for each bin */
      local star_bin_`i' = (`y_moment_next_`i'' * `max_bin_`i'' - (`max_bin_`i'' - `min_bin_`i'') * `y_moment_`i'' - `min_bin_`i'' * `y_moment_prior_`i'' ) / ( `y_moment_next_`i'' - `y_moment_prior_`i'' )
      
      /* close loop over bins */
      
    }
    
    /* determine the bin that s and t are in */
    forv i = 1/`n' {
      
      if `min_bin_`i'' <= `t' & `max_bin_`i'' >= `t' { 
        local bin_t = `i'
      }
      
      if `min_bin_`i'' <= `s' & `max_bin_`i'' >= `s' { 
        local bin_s = `i'
      }
      
    }    
    
    /* make everything easier to reference by dropping the end index */
    foreach variable in min_bin max_bin y_moment_prior y_moment_next y_moment x_moment star_bin {
      local `variable'_t = ``variable'_`bin_t''
      local `variable'_s = ``variable'_`bin_s''
    }
    
    /***************************/
    /* STEP 3: GET THE BOUNDS  */
    /***************************/
    
    /* get the analytical lower bound */
    if (`t' < `star_bin_t') local analytical_lower_bound_t = `y_moment_prior_t' 
    if (`t' >= `star_bin_t') local analytical_lower_bound_t = 1/(`t' - `min_bin_t') * ( (`max_bin_t' - `min_bin_t') * `y_moment_t' - (`max_bin_t' - `t') * `y_moment_next_t' )
    
    /* get the analytical upper bound */
    if (`s' < `star_bin_s') local analytical_upper_bound_s = 1/(`max_bin_s' - `s') * ((`max_bin_s' - `min_bin_s' )* `y_moment_s' - (`s' - `min_bin_s') * `y_moment_prior_s' )
    if (`s' >= `star_bin_s') local analytical_upper_bound_s = `y_moment_next_s'
    
    /* if the t value is not in the same bin as s, average the determined value of the moments in prior bins, plus the analytical
    lower bound times the proportion of mu_0^t it constitutes */
    if `bin_t' != `bin_s' {
      
      local bin_t_minus_1 = `bin_t' - 1
      local bin_s_plus_1 = `bin_s' + 1
      
      /* add the determined portion, mu_prime, only if there is a full bin in between s and t  */      
      if `bin_t' - `bin_s' >= 2 {
        local mu_prime = 0 
        /* obtain the weighted value of the moments between s and t  */  
        forv i = `bin_s_plus_1'/`bin_t_minus_1' {
          local bin_size_`i' = `max_bin_`i'' - `min_bin_`i''         
          local wt =  `bin_size_`i'' / (`t' - `s') * `y_moment_`i'' 
          local mu_prime = `mu_prime' + `wt'
        }
      }      
      else {
        local mu_prime = 0
      }
      di "`mu_prime'" 
      /* put this together with the determined portion of the parameter */  
      local lb_mu_s_t = `mu_prime' + (`t' - max(`max_bin_`bin_t_minus_1'',`s') ) / (`t' - `s') * `analytical_lower_bound_t' + (`max_bin_s' - `s') / (`t' - `s') * `y_moment_s' * (`bin_s' != `bin_t') 
      local ub_mu_s_t = `mu_prime' + (`t' - `max_bin_`bin_t_minus_1'' ) / (`t' - `s') * `y_moment_t' * (`bin_s' != `bin_t') + (min(`max_bin_s',`t') - `s') / (`t' - `s') * `analytical_upper_bound_s' 
    }
    
    /* if the t IS in the same interval as s, the bounds are simpler to compute: just take the analytical lower bound of t, or the analytical upper bound of s */
    if `bin_t' == `bin_s' {
      local lb_mu_s_t = `analytical_lower_bound_t'
      local ub_mu_s_t = `analytical_upper_bound_s'
    }
    
    /* return the locals that are desired */
    if "`FAILED'" != "1" {
      return local t = `t'
      return local s = `s'
      return local mu_lower_bound = `lb_mu_s_t'
      return local mu_upper_bound = `ub_mu_s_t'                     
      return local mu_lb = `lb_mu_s_t'
      return local mu_ub = `ub_mu_s_t'                     
      return local star_bin_s = `star_bin_s'
      return local star_bin_t = `star_bin_t'    
      return local num_moms = _N
    }
  }

  if "`FAILED'" != "1" {
    local rd_lb_mu_s_t: di %6.3f `lb_mu_s_t'
    local rd_ub_mu_s_t: di %6.3f `ub_mu_s_t'

    if mi("`quiet'") {      
      di `" Mean `yvar' in(`s', `t') is in [`rd_lb_mu_s_t', `rd_ub_mu_s_t'] "'   
    }
    
    if !mi("`append'") {
      append_to_file using `append', s(`str',`rd_lb_mu_s_t', `rd_ub_mu_s_t')
    }
  }
  else {
    return local t = `t'
    return local s = `s'
    return local mu_lower_bound = .
    return local mu_upper_bound = .
    return local mu_lb = .
    return local mu_ub = .
    return local star_bin_s = .
    return local star_bin_t = .
    return local num_moms = _N
  }
  /* close program */
  restore
end
/* *********** END program bound_param ***************************************** */


/***********************************************************************************/
/* program join_x_bins : Combine X groups indicated by `1' and `2', and rerank X's */
// [used only by make_monotonic() ]
/***********************************************************************************/
cap prog drop join_x_bins
prog def join_x_bins
{
  /* FIX: PRESERVE_RANKS PART NEEDS TO WORK WITH IF */
  syntax anything [if], group(varname) xvar(varname) yvar(varname) [weight(passthru) preserve_ranks]
  tokenize `anything'

  capdrop __xcut __xsize
  
  /* preserve_ranks: x variable is already in ranks, but can't use gen_wt_ranks because don't have national sample for rank generation */
  if !mi("`preserve_ranks'") {

    /* generate rank boundaries from rank means */
    get_rank_cuts_from_rank_means `xvar', gen_xcut(__xcut) gen_xsize(__xsize)

    /* store outcome variable for each bin of interest, and bin size */
    sum __xcut if `group' == `1'
    local cut1 = `r(mean)'
    sum __xcut if `group' == `2'
    local cut2 = `r(mean)'
    
    sum `yvar' if `group' == `1'
    local y1 = `r(mean)'
    sum `yvar' if `group' == `2'
    local y2 = `r(mean)'
    
    sum __xsize if `group' == `1'
    local size1 = `r(mean)'
    sum __xsize if `group' == `2'
    local size2 = `r(mean)'

    /* store weighted mean of outcome variable */
    local weighted_mean = (`y1' * `size1' + `y2' * `size2') / (`size1' + `size2')
    
    /* group 1 endpoint becomes same as group 2 endpoint */
    sum __xcut if `group' == `2'
    replace __xcut = `r(mean)' if `group' == `1'

    /* replace group identifer 1 with group identifer 1 */
    replace `group' = `2' if `group' == `1'

    /* assign mean y to weighted average of first two groups */
    replace `yvar' = `weighted_mean' if inlist(`group', `1', `2')

    /* assign midpoint of new group 1 to xvar */
    replace `xvar' = `cut2' - (`size1' + `size2') / 2 if inlist(`group', `1', `2')
  }

  /* else, combine groups and regenerate full sample ranks */
  else {
    /* combine the groups -- doesn't matter which way since we're in rank space */
    replace `group' = `1' if `group' == `2'
    
    /* recalculate father midpoint ranks */
    drop `xvar'
    gen_wt_ranks `group' `if', gen(`xvar') `weight'
  }
  
  /* regroup `group's */
  drop `group'
  sort `xvar'
  egen `group' = group(`xvar') `if'
}
end
/* *********** END program join_x_bins ***************************************** */

/**********************************************************************************/
/* program is_monotonic : reports whether parent/child distribution is monotonic   */
// sample usage: is_monotonic, x(father_ed_rank) y(son_ed_rank) weight(weight)
// return value: `r(is_monotonic)' is 1 if monotonic, 0 if not
/**********************************************************************************/
cap prog drop is_monotonic
prog def is_monotonic, rclass
{
  syntax [if], x(varname) y(varname) [weight(varname) preserve_ranks]
  
  /* manage weights */
  if !mi("`weight'") {
    local wt_string [aw=`weight']
    local wt_passthru weight(`weight')
  }
  else {
    local wt_string
    local wt_passthru
  }

  /* create integer groups for X variable */
  sort `x'
  qui egen __xgroup  = group(`x') `if'

  sum __xgroup, meanonly
  local n = `r(max)' - 1
  local is_mono 1

  forval x_current = 1/`n' {
  
    local x_next = `x_current' + 1
    
    /* calculate diff from this point to next */
    qui sum `y' `wt_string' if __xgroup == `x_current'
    local y_current = `r(mean)'
    
    qui sum `y' `wt_string' if __xgroup == `x_next'
    local y_next = `r(mean)'
    
    local diff = `y_next' - `y_current'

    /* report whether monotonic or not */
    if `diff' < 0 {
      return local is_monotonic 0
      continue, break 
    }
    else {
      return local is_monotonic 1
    }
  }
  cap drop __xgroup
}
end
/* *********** END program is_monotonic ***************************************** */

/**********************************************************************************/
/* program make_monotonic : combine X variable bins until CEF(Y|X) is monotonic    */
// sample usage: make_monotonic, x(father_ed_rank) y(son_ed_rank) weight(weight)
// - will then combine bins of father_ed_rank until son_ed is monotonic in father_ed
// - if using grouped data, need to specify GROUP_DATA option [NOT DEVELOPED YET]
/**********************************************************************************/
cap prog drop make_monotonic
prog def make_monotonic
{
  syntax [if], x(varname) y(varname) [weight(varname) group_data preserve_ranks]
  qui {
    /* manage weights */
    if !mi("`weight'") {
      local wt_string [aw=`weight']
      local wt_passthru weight(`weight')
    }
    else {
      local wt_string
      local wt_passthru
    }
    
    /* create integer groups for X variable */
    sort `x'
    qui egen __xgroup  = group(`x') `if'
    
    qui sum __xgroup
    local x_max = `r(max)'
    local x_max_orig = `r(max)'
    local flag_changed = 0
    local x_current = 1
    
    /* loop until there are no X bins left */
    /* strict inequality since we compare x_current to (x_current + 1) */
    while `x_current' < `x_max' {

      di "Loop start: `x_current' / `x_max'"
      
      local x_next = `x_current' + 1
      
      /* calculate diff from this point to next */
      qui sum `y' `wt_string' if __xgroup == `x_current'
      local y_current = `r(mean)'
    
      qui sum `y' `wt_string' if __xgroup == `x_next'
      local y_next = `r(mean)'
    
      local diff = `y_next' - `y_current'
      di "`x_current', `x_next', `y_current', `y_next', `diff'"
      
      /* if we're nonmonotonic, join the two bins */
      if `diff' < 0 {

        /* join X bins -- different programs depending on whether data are grouped or not */
        if mi("`grouped_data'") {
          join_x_bins `x_current' `x_next' `if', group(__xgroup) yvar(`y') xvar(`x') `wt_passthru' `preserve_ranks'
        }
        else {
          join_x_bins_group `x_current' `x_next', group(__xgroup) yvar(`y') xvar(`x') `wt_passthru' `preserve_ranks'
        }
        
        /* reset loop counter (i.e. go back to first group) and repeat */
        local x_current = 1
    
        /* reset x_max since we joined some groups together */
        sum __xgroup
        local x_max = `r(max)'
    
        /* set "changed" flag so we can report what happened */
        local flag_changed = 1
        
        continue
      }
      else {
        
        /* this step was monotonic, so raise x_current and check the next one */
        local x_current = `x_current' + 1
      }
    }
  }
  if `flag_changed' == 1 {
    di "make_monotonic: Collapsing from `x_max_orig' X groups to `x_max' X groups to obtain monotonic CEF."
  }
  capdrop __xgroup
}
end
/* *********** END program make_monotonic ***************************************** */

/**************************************************************************************/
/* program gen_wt_ranks : Generates midpoint ranks for a given variable               */
/* - sample use: gen_ed_ranks, gen(ed_rank) .... or gen(ed_rank_agecut)               */
/* - sample use: gen_ed_ranks son_ed [if], gen(son_ed_rank) weight(weight) by(decade) */
/**************************************************************************************/
cap prog drop gen_wt_ranks
prog def gen_wt_ranks
{
  syntax varname [if], [GENerate(name) by(varname) correction] Weight(varname) 
  capdrop __rank __min_rank __max_rank __by __number_of_people __smallest_rank_in_bin

  if mi("`weight'") {
    tempvar weight
    gen `weight' = 1
  }
  
  if mi("`by'") {
    gen __by = 1
    local by __by
  }
  sort `by'

  tokenize `varlist'
  
  /* add an if clause when varname is missing */
  if !mi("`if'") {
    local if `if' & !mi(`1')
  }
  else {
    local if if !mi(`1')
  }

  /* generate the total number of weights == size of total population */
  by `by': egen __number_of_people = total(`weight') `if'

  /* sort according to variable of interest (e.g. education) */
  sort `by' `1' `weight'
  
  /* obtain a rolling sum of weights,  */
  by `by': gen __rank = sum(`weight') `if'
  
  /* within each variable group, obtain the minimum and maximum ranks */
  by `by' `1': egen __min_rank = min(__rank) `if'
  by `by' `1': egen __max_rank = max(__rank) `if'
  bys `by' `1' (__rank): gen __smallest_rank_in_bin = `weight'[1] 
    
  /* correction for minimum rank = max of previous bin */
  replace __min_rank = __min_rank - __smallest_rank_in_bin 
    
  /* replace the rank as the mean of those rolling sums, and divide by the number of people */
  gen `generate' = 100 * (__min_rank + __max_rank) / (2 * __number_of_people) `if'
  
  /* drop clutter */        
  capdrop __rank __min_rank __max_rank __number_of_people __by __smallest_rank_in_bin

}
end
/* *********** END program gen_wt_ranks ***************************************** */

/*******************************************************************************************/
/* program get_rank_cuts_from_rank_means : Obtain rank cuts (upper bounds) from rank means */
/*******************************************************************************************/
cap prog drop get_rank_cuts_from_rank_means
prog def get_rank_cuts_from_rank_means
{
  syntax varlist(min=1 max=1), gen_xcut(string) [gen_xsize(string) ]

  capdrop __xtag __xsize
  tempvar xcut xsize
  
  /* obtain the cuts from the midpoints */
  tokenize `varlist'

  /* sort so that first n observations are ordered ranks */
  egen __xtag = tag(`1')
  gsort -__xtag `1'
  count if __xtag == 1
  local count = `r(N)'
  
  /* get top boundary of bin #1 */
  gen `xcut' = `1'[1] * 2 if _n == 1
  gen `xsize' = `xcut' if _n == 1
  
  forval i = 2/`count' {
    replace `xsize' = (`1' - `xcut'[_n-1]) * 2 if _n == `i'
    replace `xcut' = `xsize' + `xcut'[_n-1] if _n == `i'
  }
  replace `xcut' = 100 if _n == `count'

  /* apply these boundary values to all observations */
  bys `1': egen `gen_xcut' = max(`xcut')

  if !mi("`gen_xsize'") {
    bys `1': egen `gen_xsize' = max(`xsize')
  }
  
  capdrop __xtag `xcut' `xsize'
}
end
/* *********** END program get_rank_cuts_from_rank_means ***************************************** */

/**********************************************************************************/
/* program capdrop : Drop a bunch of variables without errors if they don't exist */
/**********************************************************************************/
cap prog drop capdrop
prog def capdrop
{
  syntax anything
  foreach v in `anything' {
    cap drop `v'
  }
}
end
/* *********** END program capdrop ***************************************** */


