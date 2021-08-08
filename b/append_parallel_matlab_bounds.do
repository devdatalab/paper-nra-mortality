global agelist 25(5)65
global racelist 1 2 3 5

/* loop over age-race and convert everything to stata */
forval age = $agelist {
  foreach race in $racelist {
    di "`age'-`race'"
    
    /* open this age-race file */
    /* note to replicator: this intentionally uses bounds/ and not int/bounds/ -- see makefile
       for explanation */
    import delimited using $mdata/bounds/mort_bounds_all_`age'_`race'.csv, clear

    /* drop ages / races that didn't fit this category -- from a prior parallel bug */
    keep if age == `age' & race == `race'
    
    /* save it in stata format */
    save $tmp/mba_`age'_`race', replace
  }
}

/* append all the age-race stata files */
clear
forval age = $agelist {
  foreach race in $racelist {
    di "`age'-`race'"
    cap append using $tmp/mba_`age'_`race'
  }
}

/* export the file as a CSV (since we need to replicate the output of the serial matlab program) */
export delimited using $mdata/int/bounds/mort_bounds_all_parallel.csv, replace


/******************************/
/* repeat for granular bounds */
/******************************/
forval age = $agelist {
  foreach race in $racelist {
    di "`age'-`race'"
    
    /* open this age-race file */
    /* note to replicator: this intentionally uses bounds/ and not int/bounds/ -- see makefile
       for explanation */
    import delimited using $mdata/bounds/mort_bounds_granular_`age'_`race'.csv, clear

    /* drop ages / races that didn't fit this category -- from a prior parallel bug */
    assert age == `age' & race == `race'
    
    /* save it in stata format */
    save $tmp/mba_granular_`age'_`race', replace
  }
}

/* append all the age-race stata files */
clear
forval age = $agelist {
  foreach race in $racelist {
    di "`age'-`race'"
    cap append using $tmp/mba_granular_`age'_`race'
  }
}

/* export the file as a CSV (since we need to replicate the output of the serial matlab program) */
export delimited using $mdata/int/bounds/mort_bounds_all_granular_parallel.csv, replace
