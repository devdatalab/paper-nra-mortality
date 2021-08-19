global f $tmp/mort_ests_age_fe.csv
cap erase $f
append_to_file using $f, s(src,race,ed,sex,span,mid,low,high)

/********************/
/* GET NCHS NUMBERS */
/********************/
use $tmp/nhis_nchs_combined, clear

foreach race in 1 {
  foreach ed in 1 2 {
    foreach sex in 1 2 {
      foreach span in 1 2 3 4 5 6 {

        /* get trend in NHIS data */
        reg mean year if race == `race' & ed == `ed' & sex == `sex' & span == `span'
    
        /* get baseline value in NHIS data */
        sum mean if year == 1997 & ed == `ed' & race == `race' & sex == `sex' & span == `span'
    
        /* store annualized growth, and high and low est */
        local  mid = (_b["year"]) / `r(mean)'
        local  low = (_b["year"] - 1.96 * _se["year"]) / `r(mean)'
        local high = (_b["year"] + 1.96 * _se["year"]) / `r(mean)'
        append_to_file using $f, s(nhis,`race',`ed',`sex',`span',`mid',`low',`high')

        /* get trend in NCHS data on sample that is non-missing for NHIS */
        capdrop sample
        gen sample = race == `race' & ed == `ed' & sex == `sex' & span == `span' & !mi(mean)
        reg tmortrate year if sample
  
        /* get baseline value in NCHS data */
        sum tmortrate if year == 1997 & sample
        
        /* store annualized growth, and high and low est */
        local  mid = (_b["year"]) / `r(mean)'
        append_to_file using $f, s(nchs,`race',`ed',`sex',`span',`mid',.,.)
      }
    }
  }
}


/* create a set of estimates from raw NHIS data, since these standard errors are probably too small */
use $tmp/nhis_uncollapsed, clear

/* cut out late years for long-run mortality */
replace mort_2 = . if year > 2012
replace mort_3 = . if year > 2011
replace mort_4 = . if year > 2010
replace mort_5 = . if year > 2009
replace mort_6 = . if year > 2008

foreach race in 1 2 {
  foreach ed in 1 2 {
    foreach sex in 1 2 {
      foreach span in 1 2 3 4 5 6 {
        capdrop sample
        gen sample = sex == `sex' & race == `race' & ed == `ed' & age_gp == 25

        /* get average mortality change estimate, with age fixed effects */
        reg mort_`span' year i.gran_age [pw=wgt_new] if sample == 1


        /* note: would we better if we could age-adjust the baseline number */
        sum mort_`span'                 [aw=wgt_new] if sample == 1 & year == 1997

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
import delimited using $f, clear

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
        sum mid if span == 1 & race == `race' & ed == `ed' & sex == `sex' & src == "nchs"
        local mid `r(mean)'
        local midtext = `r(mean)' + .015
        gen mid_nchs = `r(mean)' if race == `race' & ed == `ed' & sex == `sex' & src == "nchs" 
        twoway ///
          (rcap    high low span if race == `race' & ed == `ed' & sex == `sex' & src == "nhis_raw") ///
          (scatter mid span if race == `race' & ed == `ed' & sex == `sex' & src == "nhis_raw") ///
          (line mid_nchs span if race == `race' & ed == `ed' & sex == `sex' & src == "nchs", lpattern("-") color("20 80 20")) ///
          , legend(order(1 3) lab(1 "NHIS 95% Confidence Interval") lab(3 "NCHS Estimate")) ///
        name(_`race'`ed'`sex'_y, replace) xtitle("Measured over X years in NHIS") ytitle("Annualized Percent Change" "in Mortality (1997-2009)") ///
        title("`racet`race'' `sext`sex'' `edt`ed''")  ///
        ylab(`ylabels')
          graphout ests_`race'_`ed'_`sex'_yline
    }
  }
}

grc1leg _111_y _112_y _121_y _122_y, rows(2) xcommon
graphout ests_yline_age_fe, pdf
