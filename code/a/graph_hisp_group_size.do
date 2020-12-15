/*
This dofile checks whether there exist discontinuities in group sizes of whites
or blacks

author: CR
date: January 7 
*/

/* figure by ed grouup */ 

use $mortality/appended_rank_mort, clear

/* collapse over education classes */
collapse (sum) raw_tpop, by(age_gp year sex race) 

/* scale population into millions */
replace raw_tpop = raw_tpop / 1000000
local unit = "Millions"

/* loop over all ages */
foreach age of numlist 30(5)65 {

  local ageplus = `age' + 4
  local aget = "`age'-`ageplus'"

  scatter raw_tpop year if sex == 0 & age == `age' & race == 1, msymbol(circle) color(gs8) legend(label(1 "White non-Hispanic")) ||  ///
      scatter raw_tpop year if sex == 0 & age == `age' & race == 2, msymbol(triangle) color(black) legend(label(2 "Black non-Hispanic"))  /// 
      xtitle("Year", size(large)) ytitle("Population" "(`unit')", size(large)) title("Ages `aget'") name(_`age',replace) graphregion(color(none)) ///
      xlabel(1990 "90" 1995 "95" 2000 "00" 2005 "05" 2010 "10" 2015 "15" 2020 "20", angle(45) nogrid) legend(cols(4)) ///
      xline(2008, lcolor(gray) lpattern(solid)) xline(2003, lcolor(gray) lpattern(solid))
}

/* combine graphs */
grc1leg _30 _35  _40 _45 _50 _55 _60 _65, xcommon name(c_,replace) cols(4) ycommon xsize(12) 
graphout total_pops, pdf 


