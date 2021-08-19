/* tweak these lines if we decide to put in a point for total mortality */
global legend legend(order(1 2) lab(1 "Deaths from Poisoning, Suicide, Liver Disease") lab(2 "Deaths from Other Causes")) 
global legend legend(order(1 2 3) lab(1 "Deaths from All Causes") lab(2 "Deaths from Poisoning, Suicide, Liver Disease") lab(3 "Deaths from Other Causes")) 
global total_rcap         (rcap norm_change_lb norm_change_ub age if sample & cause == "total", lwidth(medthick) color(black))
global other_rcap (rcap norm_change_lb norm_change_ub age if sample & cause == "other", lwidth(medthick) color("204 85 0"))
global other_rcap
global legend legend(order(1 2 3) lab(1 "% Change in All-Cause Mortality") lab(2 "% Change in All-Cause Mortality Attributable" "     to  Poisoning, Suicide, Liver Disease") rows(2))
global ylabel ylabel(-100(25)150)
// global total_rcap

/*********************************************/
/* main graph -- total mortality change only */
/*********************************************/

/* rcap with all four ed groups in one plot, 4 different graphs for categories */
use $mdata/bounds/mort_changes_heart, clear

/* calculate % change for heart disease */
gen hdelta_2016_lb = lb_2016 / ub_1992 - 1
gen hdelta_2016_ub = ub_2016 / lb_1992 - 1
gen hdelta_2010_lb = lb_2010 / ub_1992 - 1
gen hdelta_2010_ub = ub_2010 / lb_1992 - 1

/* calculate change from 2010 to 2016 */
gen hdelta_recent_lb = lb_2016 / ub_2010 - 1
gen hdelta_recent_ub = ub_2016 / lb_2010 - 1

/* set the f2 and target */
keep if f2 < 1 & target == "10-45-70"

/* nudge age for 2010 limit graph */
gen age_2010 = age - 0.2
global ylabel ""
local label_ed1 "Ed Percentiles 0-10"
local label_ed2 "Ed Percentiles 10-45"
local label_ed3 "Ed Percentiles 45-70"
local label_ed4 "Ed Percentiles 70-100"
foreach race in 1 2 {
  foreach sex in 1 2 {
     foreach ed in 1 2 3 4 {
       local race1 "White"
       local race2 "Black"
       local sex1 "Men"
       local sex2 "Women"
       local race1l "white"
       local race2l "black"
       local sex1l "men"
       local sex2l "women"
      
       /* set the graph sample */
       capdrop sample
       gen sample = race == `race' & sex == `sex' & edclass == `ed' & spec == "mon" & ranktype == "sex"
 
       /* graph with just 2016 in black */
       twoway ///
           (rcap hdelta_2016_lb hdelta_2016_ub age if sample & cause == "heart", msize(vsmall) lwidth(thick) color(black)) ///
         , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
           name(heart_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel
       
       /* graph changes from 2010 to 2016*/
       twoway ///
           (rcap hdelta_recent_lb hdelta_recent_ub age if sample & cause == "heart", msize(vsmall) lwidth(thick) color(black)) ///
         , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
           name(heart_recent_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel
       
       /* graph with 2010 in gray and 2016 in black [for referees only] */
       twoway ///
           (rcap hdelta_2016_lb hdelta_2016_ub age if sample & cause == "heart", msize(vsmall) lwidth(thick) color(black)) ///
           (rcap hdelta_2010_lb hdelta_2010_ub age_2010 if sample & cause == "heart", msize(vsmall) lwidth(thick) color(gs8)) ///
         , yline(0, lpattern(-) lcolor(gs8)) legend(rows(1) order(2 1) lab(1 "1992-94 to 2016-18") lab(2 "1992-94 to 2010-12")) ///
           name(heart_2010_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel
     }
    
    /* create graph with 2010 and 2016 lines (for referees) */
    grc1leg       heart_2010_`sex'_`race'_1 heart_2010_`sex'_`race'_2 heart_2010_`sex'_`race'_3 heart_2010_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to end date")
    graphout hdelta-total-2010-2016-`sex'-`race', pdf

    /* create graph with 2016 lines only (for paper) */
    graph combine       heart_`sex'_`race'_1 heart_`sex'_`race'_2 heart_`sex'_`race'_3 heart_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18") 
    graphout hdelta-total-`sex'-`race', pdf

    /* graph changes 2010 to 2016 */
    graph combine       heart_recent_`sex'_`race'_1 heart_recent_`sex'_`race'_2 heart_recent_`sex'_`race'_3 heart_recent_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "2010-12 to 2016-18") 
    graphout hdelta-recent-`sex'-`race', pdf

    
  }
}


