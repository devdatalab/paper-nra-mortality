/************************************************/
/* make pictures that plot mortality by ed rank */
/************************************************/
cd ~/iec1/mortality/case_deaton_replicate/
clear 
  local counter 0 
  gen wbho = . 
  foreach race in WNH BNH H O {
    
    append using outfiles/`race'rates_sex_5yr_state_ed_9215
    local counter = `counter' + 1
    replace wbho = `counter' if wbho == .
  }

/* get 5-year bins */
egen year_bin = cut(year), at(1990 1995 2000 2005 2010 2016) 

/* collapse everything by 5-year bucket */ 
collapse (sum) TPop *mort, by(sex age_gp edclass year_bin wbho) 

/* get rates */
foreach var in T P S L H C lungC CD CL {
   gen `var'rate   = (`var'mort/TPop)*100000
} 

/* get the number in each cell */
bys age_gp sex year_bin: egen TPop_all = total(TPop)
bys age_gp sex year_bin edclass: egen TPop_ed = total(TPop)

/* obtain education ranks */
bys wbho year_bin age_gp sex (edclass): gen ed_rank = TPop_ed/TPop_all/2 if _n == 1
bys wbho year_bin age_gp sex (edclass): gen cum_ed_rank = sum(TPop_ed/TPop_all) 
bys wbho year_bin age_gp sex (edclass): replace ed_rank = TPop_ed/TPop_all/2 + cum_ed_rank[_n-1] if _n > 1 
replace ed_rank = ed_rank * 100

save $tmp/mort_ed_rank, replace
use $tmp/mort_ed_rank, clear

global out ~/tmp/png
global pn_png 1

/********************************/
/* make a program to plot this  */
/********************************/
capture pr drop mortality_ed_fig
capture pr define mortality_ed_fig
{
    syntax, sex(int) age(int) type(string) race(string) [name(string) supplegend]

    if mi("`name'") {
        local name cdmort`type'_`sex'_`racet`race''_`age'
    }

    if mi("`supplegend'") {
        local legend legend(rows(2) order(1 2 3 4 5))
    }
    else {
        local legend legend(off)
    }

    preserve

    /* keep this age only */
    keep if age_gp == `age'
    
    /* set scale by black men (who have highest mortality) */
    qui sum `type'rate if year_bin == 1990 & edclass == 1 & wbho == 2 & sex == 1
    local ymax = floor(`r(max)' / 1000) * 1000 + 1000
    local yhalf = `ymax' / 2
    local ylabel ylabel(0(`yhalf')`ymax')
    // noi di "`ylabel'"
    // error 123
    
    /* keep only this sex/race group */
    keep if sex == `sex' & wbho == `race'
    local t0 "all genders" 
    local t1 "men"
    local t2 "women"
    local age_plus_4 = `age' + 4
    local Tt Total 
    local Pt Poisoning 
    local St Suicide
    local Lt Alcoholic Liver
    local Ht Heart Disease
    local Ct Cancer
    local lungCt Lung Cancer
    local CDrate Cerebrovascular 
    local CLrate Chronic Resp.
    local racet1 white
    local racet2 black
    local racet3 hisp
    local racet4 other

    /* sort so lines are well-ordered */
    sort year_bin
    scatter `type'rate ed_rank if year_bin == 1990,   legend(lab(1 "1992-1994")) mcolor("0 0 0")   msymbol(+) || ///
      scatter `type'rate ed_rank if year_bin == 1995, legend(lab(2 "1995-1999")) mcolor("64 0 0")  msymbol(+) || ///
      scatter `type'rate ed_rank if year_bin == 2000, legend(lab(3 "2000-2004")) mcolor("128 0 0") msymbol(+) || ///
      scatter `type'rate ed_rank if year_bin == 2005, legend(lab(4 "2005-2009")) mcolor("192 0 0") msymbol(+) || ///
      scatter `type'rate ed_rank if year_bin == 2010, legend(lab(5 "2010-2015")) mcolor("255 0 0") msymbol(+) || ///
      line `type'rate ed_rank if edclass == 1, lcolor("200 200 150") || ///
      line `type'rate ed_rank if edclass == 2, lcolor("200 200 150") || ///
      line `type'rate ed_rank if edclass == 3, lcolor("200 200 150")    ///
      xtitle("Ed Rank (within `t`sex'')") ytitle("Deaths / 100,000") title("``type't' Mortality for Age `age'-`age_plus_4'") subtitle("`racet`race'', `t`sex''") ///
      xlabel(0(25)100) `ylabel' ///
      `legend' name(`name', replace) graphregion(color(white))
    //        graphout cdmort`type'_`sex'_`racet`race''_`age', large

restore
}
end

local racet1 white
local racet2 black
local racet3 hisp
local racet4 other

//foreach typ in T P S L H C lunC CD CL { 
    
foreach typ in T { 
    foreach age of numlist 25(5)55 {
        foreach r in 1 2 3 {                   
//            mortality_ed_fig, sex(0) age(`age') type(`typ') race(`r')
            mortality_ed_fig, sex(1) age(`age') type(`typ') race(`r') name(s1_r`r') supplegend
            mortality_ed_fig, sex(2) age(`age') type(`typ') race(`r') name(s2_r`r') supplegend
        }

        graph combine s1_r1 s2_r1 s1_r2 s2_r2, rows(2) xcommon ycommon altshrink
        graphout mf_mort`typ'_`age', large

    /* close type */
    }
    
/* race loop  */
}


use $tmp/mort_ed_rank, clear

/* estimate quadratic to white women and black women, age 35-59 */
keep if sex == 2 & age_gp == 35 & inrange(wbho, 1, 2)

/* create continuous education rank variable */
count
local old_n `r(N)'
local new_n = `old_n' + 100
set obs `new_n'
replace ed_rank = _n - `old_n' if _n > `old_n'
gen predicted = _n > `old_n'

/* estimate a quadratic regression for white and black women */
gen ed_rank_2 = ed_rank ^ 2
foreach wbho in 1 2 {
    foreach year in 1990 1995 2000 2005 2010 {  
        reg Trate ed_rank ed_rank_2 if wbho == `wbho' & year == `year'
        predict pred_mort_`wbho'_`year'
    }
}

/* graph actual and predicted mortality for white women */
sort ed_rank
scatter Trate ed_rank if wbho == 1 & year == 1990, legend(lab(1 "1992-1994")) mcolor("0 0 0")   msymbol(+) || ///
scatter Trate ed_rank if wbho == 1 & year == 1995, legend(lab(2 "1995-1999")) mcolor("64 0 0")  msymbol(+) || ///
scatter Trate ed_rank if wbho == 1 & year == 2000, legend(lab(3 "2000-2004")) mcolor("128 0 0") msymbol(+) || ///
scatter Trate ed_rank if wbho == 1 & year == 2005, legend(lab(4 "2005-2009")) mcolor("192 0 0") msymbol(+) || ///
scatter Trate ed_rank if wbho == 1 & year == 2010, legend(lab(5 "2010-2015")) mcolor("255 0 0") msymbol(+) || ///
line    pred_mort_1_1990 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_1_1995 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_1_2000 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_1_2005 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_1_2010 ed_rank, lcolor("200 200 150")         ///
legend(off) graphregion(color(white)) name(quad_fits_white, replace) title("White women, 35-39")
graphout quad_fits_white

scatter Trate ed_rank if wbho == 2 & year == 1990, legend(lab(1 "1992-1994")) mcolor("0 0 0")   msymbol(+) || ///
scatter Trate ed_rank if wbho == 2 & year == 1995, legend(lab(2 "1995-1999")) mcolor("64 0 0")  msymbol(+) || ///
scatter Trate ed_rank if wbho == 2 & year == 2000, legend(lab(3 "2000-2004")) mcolor("128 0 0") msymbol(+) || ///
scatter Trate ed_rank if wbho == 2 & year == 2005, legend(lab(4 "2005-2009")) mcolor("192 0 0") msymbol(+) || ///
scatter Trate ed_rank if wbho == 2 & year == 2010, legend(lab(5 "2010-2015")) mcolor("255 0 0") msymbol(+) || ///
line    pred_mort_2_1990 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_2_1995 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_2_2000 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_2_2005 ed_rank, lcolor("200 200 150")      || /// 
line    pred_mort_2_2010 ed_rank, lcolor("200 200 150")         ///
legend(off) graphregion(color(white)) name(quad_fits_black, replace) title("Black women, 35-39")
graphout quad_fits_black

graph combine quad_fits_white quad_fits_black, rows(1) xcommon ycommon  
graphout quad_fits, large

/* for each group, estimate the predicted value at the 1990 rank in 2015  */

/* identify the ed rank of the bottom group in 1990 */
sum ed_rank if edclass == 1 & wbho == 1 & year == 1990
local rank_ed1_white_1990 = round(`r(mean)')

/* get mortality for bottom ed group in 1990 */
sum Trate if edclass == 1 & wbho == 1 & year == 1990
local trate_bin1_1990 = `r(mean)'

/* get mortality for bottom ed group in 2010 */
sum Trate if edclass == 1 & wbho == 1 & year == 2010
local trate_bin1_2010 = `r(mean)'

/* get predicted mortality for 1990 bottom ed group in 2010 */
sum pred_mort_1_2010 if ed_rank == `rank_ed1_white_1990' & predicted
local trate_bin1_constant_2010 = `r(mean)'

di "Naive white mortality change:        `trate_bin1_1990' -> `trate_bin1_2010'"
di "Constant bin white mortality change: `trate_bin1_1990' -> `trate_bin1_constant_2010'"


/* repeat for black women in this group */
/* identify the ed rank of the bottom group in 1990 */
sum ed_rank if edclass == 1 & wbho == 2 & year == 1990
local rank_ed1_black_1990 = round(`r(mean)')

/* get mortality for bottom ed group in 1990 */
sum Trate if edclass == 1 & wbho == 2 & year == 1990
local trate_bin1_1990 = `r(mean)'

/* get mortality for bottom ed group in 2010 */
sum Trate if edclass == 1 & wbho == 2 & year == 2010
local trate_bin1_2010 = `r(mean)'

/* get predicted mortality for 1990 bottom ed group in 2010 */
sum pred_mort_2_2010 if ed_rank == `rank_ed1_black_1990' & predicted
local trate_bin1_constant_2010 = `r(mean)'

di "Naive black mortality change:        `trate_bin1_1990' -> `trate_bin1_2010'"
di "Constant bin black mortality change: `trate_bin1_1990' -> `trate_bin1_constant_2010'"
