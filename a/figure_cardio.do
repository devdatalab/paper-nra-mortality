/* tweak these lines if we decide to put in a point for total mortality */
global legend legend(order(1 2) lab(1 "Deaths from Poisoning, Suicide, Liver Disease") lab(2 "Deaths from Other Causes")) 
global legend legend(order(1 2 3) lab(1 "Deaths from All Causes") lab(2 "Deaths from Poisoning, Suicide, Liver Disease") lab(3 "Deaths from Other Causes")) 
global total_rcap         (rcap norm_change_lb norm_change_ub age if sample & cause == "total", lwidth(medthick) color(black))
global other_rcap (rcap norm_change_lb norm_change_ub age if sample & cause == "other", lwidth(medthick) color("204 85 0"))
global other_rcap
global legend legend(order(1 2 3) lab(1 "% Change in All-Cause Mortality") lab(2 "% Change in All-Cause Mortality Attributable" "     to  Poisoning, Suicide, Liver Disease") rows(2))
global ylabel ylabel(-25(5)25)
// global total_rcap

/***************/
/* cardio only */
/***************/

/* rcap with all four ed groups in one plot, 4 different graphs for categories */
use $mdata/bounds/mort_changes_all, clear

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
       gen sample = race == `race' & sex == `sex' & edclass == `ed' & spec == "mon-step" & ranktype == "sex"
 
       /* graph with just 2016 in black */
       twoway ///
           (rcap norm_change_lb norm_change_ub age if sample & cause == "heart", msize(vsmall) lwidth(thick) color(black)) ///
         , yline(0, lpattern(-) lcolor(gs8)) legend(off) ///
           name(cause_`sex'_`race'_`ed', replace) subtitle("`label_ed`ed''", ring(0) pos(12) size(medlarge)) ytitle("") xtitle("Age", size(medium)) $ylabel
     }
    
    /* create graph with 2016 lines only (for paper) */
    graph combine       cause_`sex'_`race'_1 cause_`sex'_`race'_2 cause_`sex'_`race'_3 cause_`sex'_`race'_4, rows(2) xcommon ycommon l1("Percent Change" "1992-94 to 2016-18") 
    graphout changes-heart-`sex'-`race', pdf
  }
}

/******************************/
/* trend bounds cardio figure */
/******************************/

/* open Matlab solver results */
import delimited using $mdata/bounds/mort_bounds_all_parallel.csv, clear

/* keep the standard time series spec only */
keep if ranktype == "sex" & spec == "mon-step" & target_name == "10-45-70" & f2 < 1

/* drop extraneous variables and sort for easy listing */
drop ranktype spec target_name f2
sort sex race edclass year

/* define looping categories */
global sex_list 1 2
global race_list 1 2
global ageset 25(5)65

/* create a temporary sample variable */
gen sample = .

/* replace year with year + 1 so it shows the midpoint */
replace year = year + 1

global ageset 25(5)65

/* loop over cause, age, sex, and race */
qui foreach cause in h {
  forval age = $ageset {
    local age_p4 = `age' + 4
    foreach sex in $sex_list {
      foreach race in $race_list {

        /* define graph labels */
        local sex1 "Men"
        local sex2 "Women"
        local race1 White
        local race2 Black
        local race3 Hispanic
        local race4 Other

        replace sample = sex == `sex' & race == `race' & age == `age' & cause == "`cause'"
        /* note we need to add redundant top and bottom lines because Stata/16 ignores rarea:lwidth() */
        twoway ///
            (rarea mu_lb mu_ub year if sample & edclass == 1, lwidth(medthick) cmissing(no) color("0 0 0"))       ///
            (rarea mu_lb mu_ub year if sample & edclass == 2, lwidth(medthick) cmissing(no) color("50 100 50"))   ///
            (rarea mu_lb mu_ub year if sample & edclass == 3, lwidth(medthick) cmissing(no) color("100 180 100")) ///
            (rarea mu_lb mu_ub year if sample & edclass == 4, lwidth(medthick) cmissing(no) color("180 225 120")) ///
            (line  mu_lb       year if sample & edclass == 1, lwidth(medthick)              color("0 0 0"))       ///
            (line  mu_lb       year if sample & edclass == 2, lwidth(medthick)              color("40 80 40"))   ///
            (line  mu_lb       year if sample & edclass == 3, lwidth(medthick)              color("75 160 75")) ///
            (line  mu_lb       year if sample & edclass == 4, lwidth(medthick)              color("160 200 105")) ///
            (line        mu_ub year if sample & edclass == 1, lwidth(medthick)              color("0 0 0"))       ///
            (line        mu_ub year if sample & edclass == 2, lwidth(medthick)              color("40 80 40"))   ///
            (line        mu_ub year if sample & edclass == 3, lwidth(medthick)              color("75 160 75")) ///
            (line        mu_ub year if sample & edclass == 4, lwidth(medthick)              color("160 200 105")) ///
            , xlabel(1995(5)2015) xtitle("Year") ytitle("Deaths per 100,000") title("`race`race'' `sex`sex'', Age `age'-`age_p4'", size(medsmall) pos(12) ring(0)) ///
            legend(order(1 2 3 4) symxsize(5) symysize(0.5) size(vsmall) subtitle("Education Percentile", size(small) pos(12)) rows(2) lab(1 "0-10") lab(2 "10-45") lab(3 "45-70") lab(4 "70-100")) name(mon_bounds_`sex'_`race'_`age', replace) plotregion(margin(zero)) 
      }
    }
    grc1leg mon_bounds_2_1_`age'  mon_bounds_1_1_`age' mon_bounds_2_2_`age' mon_bounds_1_2_`age'  , rows(2) xcommon ycommon
    noi graphout trend-smooth-mon-step-`cause'-sex-`age', pdf
  }
}

/************/
/* scatters */
/************/

use $mdata/outfiles/nchs/appended_rank_mort, clear 

/* collapse to 3-year-bins */
egen year_bin = cut(year), at(1992(3)2019)
collapse (mean) *mortrate ed_rank_sex tpop_rolling, by(race sex age edclass year_bin)
ren year_bin year

/* finish collapse and shrink new stuff */
save $tmp/mort_clean_nchs_smooth, replace

/*********************************************/
/* plot mortality over time against ed rank  */
/*********************************************/
capture pr drop mortality_ed_fig
capture pr define mortality_ed_fig
{
    syntax, sex(int) age(int) cause(string) race(string) [ylabel(passthru) name(string) title(string) presentation ]

    if "`presentation'" != "" {
      local paneloff = "paneloff"
      local labsize = "medium"
      }
    
    if mi("`name'") {
        local name cdmort`cause'_`sex'_`racet`race''_`age'
    }
    
    preserve

    /* keep this age only */
    qui keep if age_gp == `age'

    /* set scale to first 1000 above highest black male mortality (since they're the highest) */
    if "`cause'" == "t" & mi("`ylabel'") {
        qui sum `cause'mortrate if edclass == 1 & race == 2 & sex == 1
        local ymax = floor(`r(max)' / 1000) * 1000 + 1000
        local yhalf = `ymax' / 4
        local yhalfhalf = `ymax' / 8
        local ylabel ylabel(0(`yhalf')`ymax')
    }

    /* position text labels above and to the right of each 2016 point */
    forval ed = 1/4 {
      qui sum `cause'mortrate if edclass == `ed' & race == `race' & sex == `sex' & year == 2016
      local text_y`ed' = `r(mean)' + 200

      qui sum ed_rank_sex if edclass == `ed' & race == `race' & sex == `sex' & year == 2016
      local text_x`ed' = `r(mean)' - 1
    }

    /* for blacks : position text labels above and to the right of each 1992 point */
    if `race' == 2 {
      forv ed = 1/4 { 
      qui sum `cause'mortrate if edclass == `ed' & race == `race' & sex == `sex' & year == 1992
      local text_y`ed' = `r(mean)' + 200

      qui sum ed_rank_sex if edclass == `ed' & race == `race' & sex == `sex' & year == 1992
      local text_x`ed' = `r(mean)' - 1
      }
    }

  /* manually nudge some labels */
  if `age' == 50 & `sex' == 1 & `race' == 1 & "`cause'" == "t" {
    local text_x1 = 7
    local text_y1 = 1750
    local text_x4 = 89
  }
  if `age' == 50 & `sex' == 2 & `race' == 2 & "`cause'" == "t" {
    local text_x1 = 2
    local text_y1 = 1350
    local text_x3 = 55
  }
  if `age' == 50 & `sex' == 1 & `race' == 2 & "`cause'" == "t" {
    local text_x1 = 10
    local text_y1 = 1825
    local text_x2 = 27
    local text_y2 = 1300
    local text_x3 = 48
    local text_y3 = 500
  }
  
  
    /* keep only this sex/race group */
    qui keep if sex == `sex' & race == `race'
    local t0 "All Genders" 
    local t1 "Male"
    local t2 "Female"
    
    if "`presentation'" != "" {
      local t1 "Men"
      local t2 "Women"
      }
    
    local age_plus_4 = `age' + 4
    local tt Total Mortality
    local dt "Deaths of Despair"
    local Pt Poisoning 
    local St Suicide
    local Lt Alcoholic Liver
    local Ht Heart Disease
    local ht Heart Disease
    local Ct Cancer
    local lungCt Lung Cancer
    local ct Cancer
    local lungct Lung Cancer
    local CDrate Cerebrovascular 
    local CLrate Chronic Resp.
    local racet1 White
    local racet2 Black
    local racet3 Hisp
    local racet4 Other
    local panel1 "Panel A: "
    local panel2 "Panel B: "
    local panel3 "Panel C: "
    local panel4 "Panel D: "
    if "`paneloff'" != "" {
      local panel1 ""
      local panel2 ""
      local panel3 ""
      local panel4 "" 
      }
    
    if mi("`title'") {
      local title title(`"``cause't' for Age `age'-`age_plus_4'"')
    }
    local panel_num = (3 - `sex') + (`race'-1) * 2
    if `race' != 0 & `sex' != 0 local panel `panel`panel_num''

    /* build legend */
    local legend
    local order 
    forval y = 1992(3)2016 {
      local yp2 = `y' + 2
      local index = (`y' - 1992) / 3 + 5
      local order `order' `index'
      local legend `legend' lab(`index' `y'-`yp2')
    }
    
    local legend legend(`legend' pos(2) ring(0) order(`order') rowgap(0.4) region(lcolor(gs8)) cols(1) size(`legendsize'))
    
    /* sort so lines are well-ordered */
    local lcolor 100 100 100
    local subtitle "`panel' `racet`race'', `t`sex''" 
    if "`presentation'" != "" {
      local subtitle "Mortality Among `racet`race'' `t`sex''"
    }
    
    sort year
      line `cause'mortrate    ed_rank_sex if edclass == 1, lcolor("`lcolor'") || ///
      line `cause'mortrate    ed_rank_sex if edclass == 2, lcolor("`lcolor'") || ///
      line `cause'mortrate    ed_rank_sex if edclass == 3, lcolor("`lcolor'") || ///
      line `cause'mortrate    ed_rank_sex if edclass == 4, lcolor("`lcolor'") || ///
      scatter `cause'mortrate ed_rank_sex if year == 1992,  msize(vlarge) mcolor(" 0 0 0") msymbol(Th) || ///
      scatter `cause'mortrate ed_rank_sex if year == 1995,  msize(medium) mcolor("60 0 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 1998,  msize(medium) mcolor("120 0 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2001,  msize(medium) mcolor(" 180 0 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2004,  msize(medium) mcolor("240 0 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2007,  msize(medium) mcolor("255 40 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2010,  msize(medium) mcolor("255 100 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2013,  msize(medium) mcolor("255 180 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2016,  msize(vlarge) mcolor("255 240 0") mlcolor(black) msymbol(s) ///
      xtitle("Mean Education Percentile", size(medlarge)) ytitle("Deaths per 100,000", size(medlarge)) subtitle("`subtitle'", size(large) ring(0) position(12)) ///
      xlabel(0(25)100, labsize(large)) scheme(pn) `ylabel' `ytick' `title' ///
       name(`name', replace) graphregion(color(white)) ylabel(,labsize(large)) `legend' ///
       text(`text_y1' `text_x1' "No High School", placement(e) size(medlarge)) ///
       text(`text_y2' `text_x2' "High School", placement(e) size(medlarge)) ///
       text(`text_y3' `text_x3' "Some College", placement(e) size(medlarge)) ///
       text(`text_y4' `text_x4' "B.A.+", placement(e) size(medlarge)) xtitle(,size(large)) ytitle(,size(large)) title(,size(vlarge))

    restore
}
end

local racet1 white
local racet2 black
local racet3 hisp
local racet4 other

use $tmp/mort_clean_nchs_smooth, clear

// global causelist t d h c
global causelist h
global agelist 25(5)65

foreach cause in $causelist {
  foreach age of numlist $agelist {
    foreach race in 1 2 {
      foreach sex in 1 2 {
        mortality_ed_fig, sex(`sex') age(`age') cause(`cause') race(`race') name(s`sex'_r`race') title(" ")
        graphout scatter-smooth-`cause'-`age'-`sex'-`race', pdf
      }
    }
  }
}
