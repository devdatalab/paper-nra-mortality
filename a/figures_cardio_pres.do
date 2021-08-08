/*********************************************/
/* plot mortality over time against ed rank  */
/*********************************************/
capture pr drop mortality_ed_fig
capture pr define mortality_ed_fig
{
    syntax, sex(int) age(int) cause(string) race(string) [ylabel(passthru) name(string) title(string) presentation text]

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
//      local ytick ymtick(0(`yhalfhalf')`ymax', grid)
    }
    // noi di "`ylabel'"
    // error 123

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
      local subtitle
    }
  if !mi("`text'") {
    local textboxes ///
        text(`text_y1' `text_x1' "No High School", placement(e) size(medlarge)) ///
        text(`text_y2' `text_x2' "High School", placement(e) size(medlarge)) ///
        text(`text_y3' `text_x3' "Some College", placement(e) size(medlarge)) ///
        text(`text_y4' `text_x4' "B.A.+", placement(e) size(medlarge)) 
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
      scatter `cause'mortrate ed_rank_sex if year == 2014,  msize(medium) mcolor("255 180 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2015,  msize(medium) mcolor("255 180 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2016,  msize(medium) mcolor("255 180 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2017,  msize(medium) mcolor("255 180 0") msymbol(+) || ///
      scatter `cause'mortrate ed_rank_sex if year == 2018,  msize(vlarge) mcolor("255 240 0") mlcolor(black) msymbol(s) ///
      xtitle("Mean Education Percentile", size(medlarge)) ytitle("Deaths per 100,000", size(medlarge)) subtitle("`subtitle'", size(large) ring(0) position(12)) ///
      xlabel(0(25)100, labsize(large)) scheme(pn) `ylabel' `ytick' `title' ///
      name(`name', replace) graphregion(color(white)) ylabel(,labsize(large)) `legend' ///
      `textboxes' ///
      xtitle(,size(large)) ytitle(,size(large)) title(,size(vlarge))

    restore
}
end

local racet1 white
local racet2 black
local racet3 hisp
local racet4 other
local racet0 all

use $mdata/int/nchs/appended_rank_mort, clear

/* smooth the mortrate series */
egen g = group(age sex race edclass)
sort g year
xtset g year

replace tmortrate = (L.tmortrate + tmortrate + F.tmortrate) / 3 if !mi(L.tmortrate) & !mi(F.tmortrate)
replace tmortrate = (L.tmortrate + tmortrate) / 2 if mi(F.tmortrate)
replace tmortrate = (F.tmortrate + tmortrate) / 2 if mi(L.tmortrate)

save $tmp/hmort, replace

// global causelist t d h c
global causelist h
global agelist 35 40 45 50 55 60 65

// foreach cause in $causelist {
//   foreach age of numlist $agelist {
//     foreach race in 0 1 2 3 4 {
//       foreach sex in 1 2 {
//         mortality_ed_fig, sex(`sex') age(`age') cause(`cause') race(`race') name(s`sex'_r`race') title(" ")
//         graphout scatter-granular-`cause'-`age'-`sex'-`race', pdf
//       }
//     }
//   }
// }


/* slide 1: ed3, first point only */
use $tmp/hmort, clear
keep if edclass == 3 & year == 1992
mortality_ed_fig, sex(1) age(35) cause(h) race(0) name(f1) title(" ") presentation ylabel(0(20)80)
graphout f1

/* slide 2: ed3 series */
use $tmp/hmort, clear
keep if edclass == 3
mortality_ed_fig, sex(1) age(35) cause(h) race(0) name(f2) title(" ") presentation ylabel(0(20)80)
graphout f2

/* slide 3: ed3 series with data points from 1992 */
use $tmp/hmort, clear
keep if edclass == 3 | year == 1992
mortality_ed_fig, sex(1) age(35) cause(h) race(0) name(f2) title(" ") presentation ylabel(0(20)80)
graphout f3

/* slide 4: everything */
use $tmp/hmort, clear
mortality_ed_fig, sex(1) age(35) cause(h) race(0) name(f2) title(" ") presentation ylabel(0(20)80)
graphout f4
