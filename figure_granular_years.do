// global pn_png 
global out $tmp

global dir ~/iec1/mortality

use $dir/outfiles/appended_rank_mort, clear 

drop *mort *survrate

foreach v in T P S L H C D {
    local lv = lower("`v'")
    ren `v'mortrate `lv'rate
}

save $tmp/mort_granular, replace

use $dir/outfiles/appended_rank_mort_3bin, clear 

drop *mort *survrate

foreach v in T P S L H C D {
    local lv = lower("`v'")
    ren `v'mortrate `lv'rate
}

save $tmp/mort_granular_3bin, replace

local age = 50
local sex = 2
local race white 
local type t

/*********************************************/
/* plot mortality over time against ed rank  */
/*********************************************/
capture pr drop mortality_ed_fig_zoom
capture pr define mortality_ed_fig_zoom 
{
    syntax, sex(int) age(int) type(string) race(string) [ylabel(passthru) name(string) supplegend _3bin title text(passthru)]

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

    /* keep only this sex/race group */
    keep if sex == `sex' & wbho == `race'
    local t0 "all genders" 
    local t1 "men"
    local t2 "women"
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
    local racet1 white
    local racet2 black
    local racet3 hisp
    local racet4 other    
    local racet0 all
    
    if "`title'" != "" {
      local title title(`"``type't' for Age `age'-`age_plus_4'"')
    }

    gen label = string(year)
    replace label = "" if edclass > 1

    gen mlabpos = 3
    replace mlabpos = 9 if year == 2000
    
    tempfile alldata
    save `alldata'
    
    
    use `alldata', clear 
    keep if edclass == 1
    
    /* sort so lines are well-ordered */
    sort year

    
      line `type'rate ed_rank_sex if edclass == 1, lcolor("200 200 150") || ///
      scatter `type'rate ed_rank_sex if year == 1992,  mcolor(" 0 0 0") msymbol(O) msize(small) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 1993,  mcolor(" 20 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 1994,  mcolor(" 40 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 1995,  mcolor("60 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 1996,  mcolor("80 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 1997,  mcolor("100 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 1998,  mcolor("120 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 1999,  mcolor("140 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2000,  mcolor(" 160 0 0") msize(small) msymbol(+) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 2001,  mcolor(" 180 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2002,  mcolor(" 200 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2003,  mcolor(" 220 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2004,  mcolor("240 0 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2005,  mcolor("255 0 0") msize(small) msymbol(+)  mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 2006,  mcolor("255 20 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2007,  mcolor("255 40 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2008,  mcolor("255 60 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2009,  mcolor("255 80 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2010,  mcolor("255 100 0") msize(small) msymbol(+) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 2011,  mcolor("255 120 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2012,  mcolor("255 140 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2013,  mcolor("255 160 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2014,  mcolor("255 180 0") msize(small) msymbol(+) || ///
      scatter `type'rate ed_rank_sex if year == 2015,  mcolor("255 200 0") msymbol(O)  msize(small) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) ///
      xtitle("Education Rank (within gender and year)", size(large)) ytitle("Deaths / 100,000", size(large)) ///
      xlabel(0(25)100) `title' ylabel(0(200)600) ///
      legend(off) name(, replace) graphregion(color(white))
    graphout gran_mort`type'_`sex'_`racet`race''_`age'_zoom, large pdf 

    use `alldata', clear 

      line `type'rate ed_rank_sex if edclass == 1, lcolor("200 200 150") || ///
      line `type'rate ed_rank_sex if edclass == 2, lcolor("200 200 150") || ///
      line `type'rate ed_rank_sex if edclass == 3, lcolor("200 200 150") || ///
      line `type'rate ed_rank_sex if edclass == 4, lcolor("200 200 150") || ///
      scatter `type'rate ed_rank_sex if year == 1992,  mcolor(" 0 0 0") msymbol(O) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 1993,  mcolor(" 20 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 1994,  mcolor(" 40 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 1995,  mcolor("60 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 1996,  mcolor("80 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 1997,  mcolor("100 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 1998,  mcolor("120 0 0") msymbol(+) msize(small)   || ///
      scatter `type'rate ed_rank_sex if year == 1999,  mcolor("140 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2000,  mcolor(" 160 0 0") msymbol(+) msize(small) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 2001,  mcolor(" 180 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2002,  mcolor(" 200 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2003,  mcolor(" 220 0 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2004,  mcolor("240 0 0") msymbol(+)  msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2005,  mcolor("255 0 0") msymbol(+)  msize(small) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 2006,  mcolor("255 20 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2007,  mcolor("255 40 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2008,  mcolor("255 60 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2009,  mcolor("255 80 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2010,  mcolor("255 100 0") msymbol(+) msize(small) mlabel(label) mlabvpos(mlabpos) mlabcolor(black) || ///
      scatter `type'rate ed_rank_sex if year == 2011,  mcolor("255 120 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2012,  mcolor("255 140 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2013,  mcolor("255 160 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2014,  mcolor("255 180 0") msymbol(+) msize(small) || ///
      scatter `type'rate ed_rank_sex if year == 2015,  mcolor("255 200 0") msymbol(O) mlabel(label) mlabvpos(mlabpos) msize(medium) mlabcolor(black) ///
      xtitle("Education Rank (within gender and year)", size(large)) ytitle("Deaths / 100,000", size(large)) `text' /// 
      xlabel(0(25)100) `ylabel' `title' ///
      legend(off) name(, replace) graphregion(color(white))
      graphout gran_mort`type'_`sex'_`racet`race''_`age'_onepanel, large pdf    

}
end

local racet1 white
local racet2 black
local racet3 hisp
local racet4 other
local racet0 all
local _3bin 
use $tmp/mort_granular`_3bin', clear

foreach typ in t d {
    foreach age of numlist 50(5)55 {
        foreach r in 1  {                   
            mortality_ed_fig_zoom, sex(2) age(`age') type(`typ') race(`r') name(s1_r`r') supplegend `_3bin' text(550 35 "{&le}HS" 375 60 "Some College" 325 92 "{&ge}BA") 
        }
    }
}



* !mv $out/gran_mort* ~/iec1/output/mortality

