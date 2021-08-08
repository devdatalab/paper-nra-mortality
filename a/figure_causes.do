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
use $mdata/int/bounds/mort_changes_all, clear

/* set the f2 and target */
keep if f2 < 1 & target == "10-45-70"

/* nudge age for 2013 limit graph */
gen age_2013 = age - 0.2

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
           (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
         , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
           name(cause_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel
       
       /* graph with 2013 in gray and 2016 in black [for referees only] */
       twoway ///
           (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
           (rcap norm_change_2013_lb norm_change_2013_ub age_2013 if sample & cause == "total", msize(vsmall) lwidth(thick) color(gs8)) ///
         , yline(0, lpattern(-) lcolor(gs8)) legend(rows(1) order(2 1) lab(1 "1992-94 to 2016-18") lab(2 "1992-94 to 2013-15")) ///
           name(cause_2013_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel
     }
    
    /* create graph with 2013 and 2016 lines (for referees) */
    grc1leg       cause_2013_`sex'_`race'_1 cause_2013_`sex'_`race'_2 cause_2013_`sex'_`race'_3 cause_2013_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to end date")
    graphout changes-total-2013-2016-`sex'-`race', pdf

    /* create graph with 2016 lines only (for paper) */
    graph combine       cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18") 
    graphout changes-total-`sex'-`race', pdf

    // /* create web version of graph */
    // grc1leg       cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18") title("Mortality Change by Education Percentile" "Non-Hispanic `race`race'' `sex`sex'', All Ages") ///
    //   note("The black lines show the percentage change in the mortality rate from 1992-1994 to 2013-2018 for non-Hispanic `race`race'l' `sex`sex'l' at all " ///
    //    "education ranks. The orange lines show how much total mortality would have changed just from the change in deaths of despair." ///
    //    "Data Source: National Center for Health Statistics", size(vsmall))
    // graphout causes-`sex'-`race'-web, large pdf
    
  }
}





/***************************/
/* despair and non-despair */
/***************************/
/* rcap with all four ed groups in one plot, 4 different graphs for categories */
use $mdata/int/bounds/mort_changes_all, clear
replace age = age + 1 if cause == "nondesp"

/* nudge age for 2013 limit graph */
gen age_2013 = age - 0.2

/* set the f2 and target */
keep if f2 < 1 & target == "10-45-70"

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

      /* despair vs. non-despair with 2013 and 2016 (for referees) */
      twoway ///
          (rcap norm_change_2013_lb norm_change_2013_ub age_2013 if sample & cause == "despair", msize(vsmall) lwidth(thick) color("224 164 125")) ///
          (rcap norm_change_2013_lb norm_change_2013_ub age_2013 if sample & cause == "nondesp", msize(vsmall) lwidth(thick) color(gs8)) ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "despair", msize(vsmall) lwidth(thick) color("204 85 0")) ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "nondesp", msize(vsmall) lwidth(thick) color(black)) ///
          , legend(order(1 2 3 4) rows(2) lab(1 "Despair (1992-94 to 2013-15)") lab(2 "Non-Despair (1992-94 to 2013-2015)") lab(3 "Despair (1992-94 to 2016-18)") lab(4 "Non-Despair (1992-94 to 2016-18)") ) ///
          ytitle("Change in aggregate death caused by each source") yline(0, lpattern(-) lcolor(gs8)) ///
          name(cause_nod_2013_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel

      /* despair vs. non-despair */
      twoway ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "despair", msize(vsmall) lwidth(thick) color("204 85 0")) ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "nondesp", msize(vsmall) lwidth(thick) color(gs6)) ///
          , legend(order(1 2) rows(1) lab(2 "All Other Causes") lab(1 "Suicide, Poisoning, and Liver Disease")) ///
          ytitle("Change in aggregate death caused by each source") yline(0, lpattern(-) lcolor(gs8)) ///
          name(cause_nod_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel

    }

    /* 2013 and 2016 graph [for referees] */
    grc1leg       cause_nod_2013_`sex'_`race'_1 cause_nod_2013_`sex'_`race'_2 cause_nod_2013_`sex'_`race'_3 cause_nod_2013_`sex'_`race'_4, xcommon ycommon l1("Percent change in total deaths" "driven by each cause") 
    graphout changes-nod-2013-`sex'-`race', pdf

    /* 2016 graph only */
    grc1leg       cause_nod_`sex'_`race'_1 cause_nod_`sex'_`race'_2 cause_nod_`sex'_`race'_3 cause_nod_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent change in total deaths" "driven by each cause (1992-94 to 2016-18)") 
    graphout changes-nod-`sex'-`race', pdf

  }
}

/*************************/
/* E1-A: 1992 base years */
/*************************/
foreach sex in 1 2 {
  local target1 17-52-73
  local target2 17-60-81
  local label1_ed1 "Ed Percentiles 0-17"
  local label1_ed2 "Ed Percentiles 17-52"
  local label1_ed3 "Ed Percentiles 52-73"
  local label1_ed4 "Ed Percentiles 73-100"
  local label2_ed1 "Ed Percentiles 0-17"
  local label2_ed2 "Ed Percentiles 17-60"
  local label2_ed3 "Ed Percentiles 60-81"
  local label2_ed4 "Ed Percentiles 81-100"

  /* open dataset within loop, b/c male/female use different targets */
  use $mdata/int/bounds/mort_changes_all, clear
  keep if f2 < 1 & target == "`target`sex''"
  
  foreach race in 1 2 {
    foreach ed in 1 2 3 4 {
      
      capdrop sample
      gen sample = race == `race' & sex == `sex' & edclass == `ed' & spec == "mon" & ranktype == "sex"

      twoway ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
        , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
          name(cause_`sex'_`race'_`ed', replace) subtitle("`label`sex'_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age") $ylabel
      
      graphout causes-`sex'-`race'-`ed', qui
    }
    graph combine cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18")
    graphout causes-1992-`sex'-`race', pdf
  }
}

/*****************************/
/* E1-B: within race-sex graph */
/*****************************/

/* get the bounds dataset with the right f2 and target */
use $mdata/int/bounds/mort_changes_all, clear
keep if f2 < 1 & target == "10-45-70"

local label_ed1 "Ed Percentiles 0-10"
local label_ed2 "Ed Percentiles 10-45"
local label_ed3 "Ed Percentiles 45-70"
local label_ed4 "Ed Percentiles 70-100"
foreach race in 1 2 {
  foreach sex in 1 2 {
    foreach ed in 1 2 3 4 {
      
      capdrop sample
      gen sample = race == `race' & sex == `sex' & edclass == `ed' & spec == "mon" & ranktype == "race_sex"

      twoway ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
        , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
          name(cause_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age") $ylabel
      
      graphout causes-`sex'-`race'-`ed', qui
    }
    graph combine       cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18") 
    graphout causes-racesex-`sex'-`race', pdf
  }
}


/****************************/
/* E1-C: curvature/mon-step */
/****************************/
/* get the bounds dataset with the right f2, target and NOMON */
use $mdata/int/bounds/mort_changes_all, clear
keep if f2 < 1 & target == "10-45-70" & spec == "mon-step"

/* truncate upper bound to 150 so it fits on the graph */
replace norm_change_ub = 150 if norm_change_ub > 150 & !mi(norm_change_ub)

local label_ed1 "Ed Percentiles 0-10"
local label_ed2 "Ed Percentiles 10-45"
local label_ed3 "Ed Percentiles 45-70"
local label_ed4 "Ed Percentiles 70-100"
foreach race in 1 2 {
  foreach sex in 1 2 {
    foreach ed in 1 2 3 4 {
      
      capdrop sample
      gen sample = race == `race' & sex == `sex' & edclass == `ed' & ranktype == "sex"
      twoway ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
        , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
          name(cause_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age") $ylabel
      graphout causes-`sex'-`race'-`ed', qui
    }
    graph combine cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18")
    graphout causes-mon-step-`sex'-`race', pdf
  }
}

/**********************/
/* E1-D: no curvature */
/**********************/
/* get the bounds dataset with the right f2, target and NOMON */
use $mdata/int/bounds/mort_changes_all, clear
keep if f2 == 10 & target == "10-45-70"

/* truncate upper bound */
replace norm_change_ub = 150 if norm_change_ub > 150 & !mi(norm_change_ub)

local label_ed1 "Ed Percentiles 0-10"
local label_ed2 "Ed Percentiles 10-45"
local label_ed3 "Ed Percentiles 45-70"
local label_ed4 "Ed Percentiles 70-100"
foreach race in 1 2 {
  foreach sex in 1 2 {
    foreach ed in 1 2 3 4 {
      
      capdrop sample
      gen sample = race == `race' & sex == `sex' & edclass == `ed' & ranktype == "sex"
      qui twoway ///
          (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
        , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
          name(cause_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age") $ylabel
      graphout causes-`sex'-`race'-`ed', qui
    }
    graph combine       cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18")
    graphout causes-nof2-`sex'-`race', pdf
  }
}

/**********************/
/* 3 education groups */
/**********************/
use $mdata/int/bounds/mort_changes_all, clear
keep if target == "45-70" & race == 1

local label_ed1 "Ed Percentiles 0-45"
local label_ed2 "Ed Percentiles 45-70"
local label_ed3 "Ed Percentiles 70-100"
foreach sex in 1 2 {
  foreach ed in 1 2 3 {
    
    capdrop sample
    gen sample = sex == `sex' & edclass == `ed'
    twoway ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "total", msize(vsmall) lwidth(thick) color(black)) ///
        , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
        name(cause_ed3_`sex'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age") $ylabel
    graphout causes-ed3-`sex'-`ed', qui
  }
  graph combine cause_ed3_`sex'_1 cause_ed3_`sex'_2 cause_ed3_`sex'_3, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18")
  graphout causes-ed3-`sex', pdf
}

exit
exit
exit




// STUFF AFTER THIS NOT YET REVISED IN 2020





/*****************************/
/* all disaggregated causes  */
/*****************************/
use $bounds_dir/trend-3-all-graph, clear

local label_ed1 "Ed Percentiles 0-10"
local label_ed2 "Ed Percentiles 10-45"
local label_ed3 "Ed Percentiles 45-70"
local label_ed4 "Ed Percentiles 70-100"

foreach race in 1 2 {
  foreach sex in 1 2 {
    foreach ed in 1 2 3 4 {
      
      capdrop sample
      gen sample = race == `race' & sex == `sex' & edclass == `ed' & spec == "mon-step" & ranktype == "sex"
      twoway ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "t", lwidth(medthick) color(black)) ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "d", lwidth(medthick))  ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "c", lwidth(medthick))    ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "h", lwidth(medthick))  ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "a", lwidth(medthick))    ///
        (rcap norm_change_lb norm_change_ub age if sample & cause == "o", lwidth(medthick))    ///
        , yline(0, lpattern(-) lcolor(gs8)) ///
         legend(cols(3) subtitle("% Change in All-Cause Mortality" "    Attributable to") order(1 2 3 4 5 6) lab(1 "All Causes") lab(2 "Despair") lab(3 "Cancer") lab(4 "Heart Disease") lab(5 "Injuries") lab(6 "Other")) ///
         name(cause_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age") ylabel(-75(25)150)
      // graphout causes-`sex'-`race'-`ed', large qui
    }
    grc1leg       cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18")
    graphout causes-all-`sex'-`race', large pdf
  }
}

/**********************************************/
/* graphs with descriptive titles for twitter */
/**********************************************/
use $bounds_dir/trend-3-graph, clear
global ylabel ylabel(-100(25)150)
global legend legend(order(1 2) lab(1 "Total Mortality Change") lab(2 "Change in Mortality Rate Attributable to" "Poisoning, Suicide, Liver Disease")) 

/**********************************************************************************/
/* program mgraph : Insert description here */
/***********************************************************************************/
cap prog drop mgraph
prog def mgraph
{
  syntax, sex(integer) race(integer) ed(integer)
  local ed1 "Least Educated 10%"
  local ed2 "Education Percentiles 10-45"
  local ed3 "Education Percentiles 45-70"
  local ed4 "Most Educated 30%"
  local race1 "White"
  local race2 "Black"
  local sex1 "Men"
  local sex2 "Women"
  local ed1l "least educated 10%"
  local ed2l "education percentiles 10-45"
  local ed3l "education percentiles 45-70"
  local ed4l "most educated 30%"
  local race1l "white"
  local race2l "black"
  local sex1l "men"
  local sex2l "women"

  capdrop sample
  gen sample = race == `race' & sex == `sex' & edclass == `ed' & spec == "mon-step" & ranktype == "sex"
  twoway ///
  $total_rcap ///
  (rcap norm_change_lb norm_change_ub age if sample & cause == "despair", lwidth(medthick) color("204 85 0")) ///
        , yline(0, lpattern(-) lcolor(gs8)) $legend ///
  ytitle("Percentage Change in Mortality") xtitle("Age") $ylabel ///
  title("Mortality Change in `ed`ed''" "Non-Hispanic `race`race'' `sex`sex'', All Ages") ///
  note("The black lines show the percentage change in the mortality rate from 1992-1994 to 2013-2015 for non-Hispanic `race`race'l' `sex`sex'l' in the " ///
       "`ed`ed'l'. The orange lines show how much total mortality would have changed just from the change in deaths of despair." ///
       "Data Source: National Center for Health Statistics", size(vsmall))
  graphout causes-`sex'-`race'-`ed'-web, large 
}
end
/* *********** END program mgraph ***************************************** */

foreach sex in 1 2 {
  foreach race in 1 2 {
    forval ed = 1/4 {
      mgraph, sex(`sex') race(`race') ed(`ed')
    }
  }
}




/* white female ed 0-10, no despair */
capdrop sample
gen sample = race == 1 & sex == 2 & edclass == 1 & spec == "mon-step" & ranktype == "sex"
twoway ///
$total_rcap ///
        , yline(0, lpattern(-) lcolor(gs8)) $legend ///
ytitle("Percentage Change in Mortality" "(1992-1994 to 2013-2015)") xtitle("Age") $ylabel ///
title("Mortality Change in Least Educated 10%" "Non-Hispanic White Women, By Age") ///
note("The graph shows the percentage change in the mortality rate from 1992-1994 to 2013-2015 for non-Hispanic white women." "Data Source: National Center for Health Statistics", size(vsmall))
graphout causes-2-1-1-total-web, large 



