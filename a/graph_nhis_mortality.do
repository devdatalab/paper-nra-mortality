/*

Goal: Compare mortality change estimates in NHIS vs. NCHS / vital stats

Notes about this dofile
first must run nhis/collapse_nhis.do 

updated 2020 with latest data 

*/

/*************************************/
/* Bring in NCHS data for comparison */
/*************************************/

/* open granular age mortality database */
use $mdata/int/nchs/appended_rank_mortgranage, clear

keep edclass sex race year age tmort tpop_rolling tmortrate
ren edclass ed

/* create 1, 2, 3, 4, 5, 6-year mortality by adding up deaths in subsequent years for same cohorts */
gen bc = year - age
drep ed sex race bc year

egen cohort = group(sex ed race bc)
xtset cohort year

/* aggregate mortality rates (deaths per 100,000) rather than population, i.e. assume population is always correct */
gen tmortrate1 = tmortrate
gen tmortrate2 = tmortrate + F.tmortrate
gen tmortrate3 = tmortrate + F.tmortrate + F2.tmortrate
gen tmortrate4 = tmortrate + F.tmortrate + F2.tmortrate + F3.tmortrate
gen tmortrate5 = tmortrate + F.tmortrate + F2.tmortrate + F3.tmortrate + F4.tmortrate
gen tmortrate6 = tmortrate + F.tmortrate + F2.tmortrate + F3.tmortrate + F4.tmortrate + F5.tmortrate

/* reshape X-year mortality to be long */
drop tmortrate
drop bc
drop cohort
drop tmort
reshape long tmortrate, j(span) i(year age ed sex race)

/* limit to 25-54 year olds */
keep if inrange(age, 25, 54)

/* collapse on total mortality and total population -- to get rid of age */
gen tmort = tpop_rolling * tmortrate / 100000
collapse (sum) tmort tpop_rolling, by(year ed sex race span)
gen tmortrate = tmort / tpop_rolling * 100000
ren tpop_rolling tpop_nchs

drop if race == 0 | sex == 0
save $tmp/nchs_fm, replace


import delimited using $mdata/int/nhis/clean/nhis_ses, clear
drop if year > 2014 & mort == 1
drop if year > 2013 & mort == 2
drop if year > 2012 & mort == 3 
drop if year > 2011 & mort == 4
drop if year > 2010 & mort == 5
drop if year > 2009 & mort == 6
keep if type == "ed"
ren mort span

merge m:1 race sex year ed span using $tmp/nchs_fm, assert(using match) 

save $tmp/nhis_nchs_combined, replace


use $tmp/nhis_nchs_combined, clear

foreach race in 1 {   
  foreach ed in 1 2 {   
    foreach sex in 1 2 {
      foreach span in 1 2 4 6 {
        
        local racet1 White
        local racet2 Black 
        local racet3 Hisp
        local racet4 Other

        local sext1 Men
        local sext2 Women

        local edt1 <HS
        local edt2 HS
        local edt3 Some College
        local edt4 BA+
        
        twoway ///
        (scatter mean year   if span == `span' & sex == `sex' & race == `race' & ed == `ed', xtitle("Year") ytitle("Deaths per 100,000") name(_`sex'_`span', replace) legend(off) title("`span'-Year Mortality") msymbol(O)) ///
        (rcap high low year  if span == `span' & sex == `sex' & race == `race' & ed == `ed', lcolor(black)) ///
        (line tmortrate year if span == `span' & sex == `sex' & race == `race' & ed == `ed' & !mi(mean), lcolor(orange) lwidth(medthick))  ///
        , legend(order(1 3) lab(1 "NHIS") lab(3 "NCHS"))
        
        graphout mortcomp_`sex'_`race'_`ed'_`span'
      }
      grc1leg _`sex'_1 _`sex'_2 _`sex'_4 _`sex'_6, xcommon title("Mortality Trends: `racet`race'' `sext`sex'', `edt`ed'', Ages 25-54")
      graphout mortcomp_`sex'_`race'_`ed'
    }
  }
}

/* create male+female paired graphs for klenow response */
gen sample = inrange(year, 1997, 2014)
keep if sample
foreach ed in 1 2 {
        local edt1 <HS
        local edt2 HS
        local edt3 Some College
        local edt4 BA+
  foreach span in 1 2 3 4 5 6 {
    twoway ///
    (scatter mean year   if span == `span' & sex == 1 & race == 1 & ed == `ed', mlabel(nhisdeath) mlabcolor(black) color(black) xtitle("Year") ytitle("Deaths per 100,000") name(_1_`ed'_`span', replace) legend(off) title("`span'-year Mortality, White Men") msymbol(O)) ///
    (rcap high low year  if span == `span' & sex == 1 & race == 1 & ed == `ed', lcolor(black)) ///
    (line tmortrate year if span == `span' & sex == 1 & race == 1 & ed == `ed' & !mi(mean), lcolor(orange) lwidth(medthick))  ///
        , legend(rows(1) order(1 3) lab(1 "NHIS") lab(3 "NCHS (Novosad-Rafkin-Asher)") )
    
    twoway ///
    (scatter mean year   if span == `span' & sex == 2 & race == 1 & ed == `ed', mlabel(nhisdeath) mlabcolor(black) color(black) xtitle("Year") ytitle("Deaths per 100,000") name(_2_`ed'_`span', replace) legend(off) title("`span'-year Mortality, White Women") msymbol(O)) ///
    (rcap high low year  if span == `span' & sex == 2 & race == 1 & ed == `ed', lcolor(black)) ///
    (line tmortrate year if span == `span' & sex == 2 & race == 1 & ed == `ed' & !mi(mean), lcolor(orange) lwidth(medthick))  ///
        , legend(rows(1) order(1 3) lab(1 "NHIS") lab(3 "NCHS (Novosad-Rafkin-Asher)") )

     grc1leg _1_`ed'_`span' _2_`ed'_`span', cols(2) ycommon title("`span'-year Mortality (Ed `edt`ed'': NCHS (Novosad-Rafkin-Asher) vs NHIS")
     graphout mortcomp_`ed'_`span'
  }
}

/* combine 1- and 2-year mortality graphs */
grc1leg _1_1_1 _2_1_1 _1_1_2 _2_1_2, cols(2) title("Mortality Estimates for HS Dropouts: NCHS vs NHIS")
graphout mort_r1, pdf

/************************************/
/* regression version of comparison */
/************************************/
use $tmp/nhis_nchs_combined, clear
global f $tmp/mort_ests.csv
cap erase $f
append_to_file using $f, s(src,race,ed,sex,span,mid,low,high)
foreach race in 1 2 {
  foreach ed in 1 2 {
    foreach sex in 1 2 {
      foreach span in 1 2 3 4 5 6 {

        /* get trend in NHIS data */
        reg mean year if race == `race' & ed == `ed' & sex == `sex' & span == `span'
        di "NHIS" 
        tab year if e(sample) 
        /* get baseline value in NHIS data */
        sum mean if inrange(year,1997,1999) & ed == `ed' & race == `race' & sex == `sex' & span == `span'
    
        /* store annualized growth, and high and low est */
        local  mid = (_b["year"]) / `r(mean)'
        local  low = (_b["year"] - 1.96 * _se["year"]) / `r(mean)'
        local high = (_b["year"] + 1.96 * _se["year"]) / `r(mean)'
        append_to_file using $f, s(nhis,`race',`ed',`sex',`span',`mid',`low',`high')

        /* get trend in NCHS data on sample that is non-missing for NHIS */
        capdrop sample
        gen sample = race == `race' & ed == `ed' & sex == `sex' & span == `span' & !mi(mean) // note that !mi(mean) is 1997--2014 
        
        reg tmortrate year if sample
        di "NCHS" 
        tab year if e(sample)
        
        /* get baseline value in NCHS data */
        sum tmortrate if inrange(year,1997,1999) & sample
        
        /* store annualized growth, and high and low est */
        local  mid = (_b["year"]) / `r(mean)'
        append_to_file using $f, s(nchs,`race',`ed',`sex',`span',`mid',.,.)
      }
    }
  }
}

/* create a set of estimates from raw NHIS data, since these standard errors are probably too small */
use $mdata/int/nhis_uncollapsed, clear

/* cut out late years for long-run mortality */
replace mort_1 = . if year > 2014
replace mort_2 = . if year > 2013
replace mort_3 = . if year > 2012
replace mort_4 = . if year > 2011
replace mort_5 = . if year > 2010
replace mort_6 = . if year > 2009

foreach race in 1 2 {
  foreach ed in 1 2 {
    foreach sex in 1 2 {
      foreach span in 1 2 3 4 5 6 {
        capdrop sample
        gen sample = sex == `sex' & race == `race' & ed == `ed' & age_gp == 25
        reg mort_`span' year [pw=wtfa] if sample == 1
        tab year if e(sample)
        
        sum mort_`span'      [aw=wtfa] if sample == 1 & inrange(year,1997,1999)

        /* store annualized growth, and high and low est */
        local  mid = (_b["year"]) / `r(mean)'
        local  low = (_b["year"] - 1.96 * _se["year"]) / `r(mean)'
        local high = (_b["year"] + 1.96 * _se["year"]) / `r(mean)'
        append_to_file using $f, s(nhis_raw,`race',`ed',`sex',`span',`mid',`low',`high')

      }
    }
  }
}

/* graph estimates */
import delimited using $tmp/mort_ests.csv, clear 

replace high = high * 100
replace mid = mid * 100
replace low = low * 100

foreach race in 1 {
  foreach ed in 1 2 {
    foreach sex in 1 2 {
        local racet1 White
        local racet2 Black 
        local racet3 Hisp
        local racet4 Other

        local sext1 Men
        local sext2 Women

        local edt1 <HS
        local edt2 HS
        local edt3 Some College
        local edt4 BA+

        /* define ylabel (damn you stata!!) */
        qui sum high if race == `race' & ed == `ed' & sex == `sex' & src == "nhis_raw"  
        local ymax = ceil(`r(max)'/10)*10
        qui sum low if race == `race' & ed == `ed' & sex == `sex' & src == "nhis_raw"  
        local ymin = floor(`r(min)'/10)*10
        local ylabels
        forval y = `ymin'(10)`ymax' {
          local ylabels `ylabels' `y' "`y'%"
        }
        
        /* get NCHS 1-year estimate for this group */
        capdrop mid_nchs
        qui sum mid if span == 1 & race == `race' & ed == `ed' & sex == `sex' & src == "nchs"
        local mid `r(mean)'
        local midtext = `r(mean)' + .015
        gen mid_nchs = `r(mean)' if race == `race' & ed == `ed' & sex == `sex' & src == "nchs" 
        twoway ///
          (rcap    high low span if race == `race' & ed == `ed' & sex == `sex' & src == "nhis_raw") ///
          (scatter mid span if race == `race' & ed == `ed' & sex == `sex' & src == "nhis_raw") ///
          (line mid_nchs span if race == `race' & ed == `ed' & sex == `sex' & src == "nchs", lpattern("-") color("20 80 20")) ///
          , legend(order(1 3) lab(1 "NHIS 95% Confidence Interval") lab(3 "NCHS Estimate")) ///
        name(_`race'`ed'`sex'_y, replace) xtitle("Measured over X years in NHIS") ytitle("Annualized Percent Change" "in Mortality (1997-2014)") ///
        title("`racet`race'' `sext`sex'' `edt`ed''")  ///
        ylab(`ylabels')
          graphout ests_`race'_`ed'_`sex'_yline
    }
  }
}

grc1leg _111_y _112_y _121_y _122_y, rows(2) xcommon
graphout ests_yline, pdf

exit
exit
exit

/*************************************************************************/
/* calculate ed1, ed2, ed1+1 mortality change over all periods from NHIS */
/*************************************************************************/
use $mdata/int/nhis_uncollapsed, clear

/* cut out late years for long-run mortality */
replace mort_1 = . if year > 2014
replace mort_2 = . if year > 2013
replace mort_3 = . if year > 2012
replace mort_4 = . if year > 2011
replace mort_5 = . if year > 2010
replace mort_6 = . if year > 2009

keep if race == 1 & age_gp == 25
reg mort_4 year i.gran_age [pw=wtfa] if ed == 1 & sex == 2
sum mort_4 if ed == 1 & inrange(year,1997,1999) & sex == 2
local wf1 =  _b["year"]/`r(mean)' * 100

reg mort_4 year i.gran_age [pw=wtfa] if ed == 2 & sex == 2
sum mort_4 if ed == 1 & inrange(year,1997,1999) & sex == 2
local wf2 = _b["year"]/`r(mean)' * 100

reg mort_4 year i.gran_age [pw=wtfa] if ed == 1 & sex == 1
sum mort_4 if ed == 1 & inrange(year,1997,1999) & sex == 1
local wm1 =  _b["year"]/`r(mean)' * 100

reg mort_4 year i.gran_age [pw=wtfa] if ed == 2 & sex == 1
sum mort_4 if ed == 1 & inrange(year,1997,1999) & sex == 1
local wm2 =  _b["year"]/`r(mean)' * 100

di `wf1'
di `wf2'
di `wm1'
di `wm2'


foreach race in 1 2 {
  foreach ed in 1 2 {
    foreach sex in 1 2 {
      foreach span in 1 2 3 4 5 6 {
        capdrop sample
        gen sample = sex == `sex' & race == `race' & ed == `ed' & age_gp == 25
        reg mort_`span' year [pw=wtfa] if sample == 1
        sum mort_`span'      [aw=wtfa] if sample == 1 & inrange(year,1997,1999)

        /* store annualized growth, and high and low est */
        local  mid = (_b["year"]) / `r(mean)'
        local  low = (_b["year"] - 1.96 * _se["year"]) / `r(mean)'
        local high = (_b["year"] + 1.96 * _se["year"]) / `r(mean)'
        append_to_file using $f, s(nhis_raw,`race',`ed',`sex',`span',`mid',`low',`high')

      }
    }
  }
}
