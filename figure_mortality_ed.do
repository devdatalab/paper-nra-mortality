/********************************/
/* make a program to plot this  */
/********************************/
capture pr drop mortality_ed_fig
capture pr define mortality_ed_fig
syntax, sex(int) age(int) type(string) race(string) [etype(string) ] 

        use outfiles/appended_bins_rank_mort`etype' , clear 
        keep if sex == `sex' & age_gp == `age' & wbho == `race'
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

        local allname = "all" 
        local sexname = "within gender" 
        local race_sexname = "within gender & race" 

foreach ranktype in all sex race_sex { 
        scatter `type'rate ed_rank_`ranktype' if year_bin == 1990, legend(lab(1 "1992-1994")) || ///
        scatter `type'rate ed_rank_`ranktype' if year_bin == 1995, legend(lab(2 "1995-1999")) || ///
        scatter `type'rate ed_rank_`ranktype' if year_bin == 2000, legend(lab(3 "2000-2004")) || ///
        scatter `type'rate ed_rank_`ranktype' if year_bin == 2005, legend(lab(4 "2005-2009")) || ///
        scatter `type'rate ed_rank_`ranktype' if year_bin == 2010, legend(lab(5 "2010-2015")) mcolor(red) msymbol(+) ///
        xtitle("Ed Rank (within ``ranktype'name')") ytitle("Deaths / 100,000") title("Ranks: ``ranktype'name'") ///
        xlabel(0(25)100) legend(rows(2)) name(`ranktype',replace) 

      }


grc1leg all sex race_sex, ycommon xcommon title("``type't' Mortality for Age `age'-`age_plus_4'") subtitle("`racet`race'', `t`sex''") 

graphout cdmort`type'_`sex'_`racet`race''_`age'`etype', pdf large

end


/************************************************/
/* plot ed attainment for a given race and sex  */
/************************************************/

capture pr drop ed_fig
capture pr define ed_fig
syntax, sex(int) age(int)  race(string) [etype(string)]

        /* use data */ 
                use outfiles/appended_rank_mort`etype' , clear
                keep if sex == `sex' & age_gp == `age' & wbho == `race'

                local age_plus_4 = `age' + 4
                local racet1 white
                local racet2 black
                local racet3 hisp
                local racet4 other
                local sext0 = "all genders"
                local sext1 = "men"
                local sext2 = "women" 

        /* scatter ranks */ 
                scatter ed_rank_all year, msize(small) legend(lab(1 "National Rank"))  || /// 
                scatter ed_rank_race_sex year, msize(small) legend(lab(2 "Within Race/Sex Rank"))   || /// 
                scatter ed_rank_sex year, msize(medium) legend(lab(3 "Within Sex Rank")) ///
                  ytitle("Rank") xtitle("Year") title("Ranks by Year for Age `age'-`age_plus_4'") xlabel(1990(5)2015) ylabel(0(25)100) ///
                    subtitle("`racet`race'', `sext`sex''") 

        /* export */ 
                graphout rks_`sex'_`racet`race''_`age'`etype', pdf large

end 

/********************/
/* plot ed figures  */
/********************/

foreach i of numlist 25(5)70 {
  foreach r in 1 2 3 4 {                   
    ed_fig, sex(0) age(`i')  race(`r') etype(_detailed)
    ed_fig, sex(1) age(`i')  race(`r') etype(_detailed)
    ed_fig, sex(2) age(`i')  race(`r') etype(_detailed)
  
  /* close type */
  }

}




/********************/
/* plot deaths by ed  */
/********************/
foreach etype in "_detailed"  { 
        foreach typ in T P S L H C lunC CD CL { 

                        foreach i of numlist 25(5)70 {
                                foreach r in 1 2 3 4 {                   
                                mortality_ed_fig, sex(0) age(`i') type(`typ') race(`r') etype(`etype') 
                                mortality_ed_fig, sex(1) age(`i') type(`typ') race(`r') etype(`etype') 
                                mortality_ed_fig, sex(2) age(`i') type(`typ') race(`r') etype(`etype') 
                              }

                /* close type */
                  }



        /* race loop  */
        }
}


