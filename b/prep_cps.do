/*******************************************************/
/* THIS DOFILE IS LIGHTLY AMENDED FROM THE CASE-DEATON */
/* DOFILE                                              */
/*******************************************************/

/*************/
/* 1980-1989 */
/*************/
cap log close
cap drop _all
set more off
# delimit ;


/* combining March cps data on incomes 1980-89  */
/* we will do this for 1990-99 and 2000-18 but in batches */
tempfile tempbig;
local rawdata $mdata/raw/cps ;
local outfile $mdata/int ;

use `rawdata'/cepr_march_1980 ;
   keep month state mis hhid hhseq perno year age id famno famhh famtyp p*fam research st*yr female *wgt r*all female educ
   married marstat empl unem nilf csr centcity
   suburb rural occly* rhr* dis* relhdh* wbho state  ;
   save `tempbig';

forval i = 1981 (1) 1989 {;
  use `rawdata'/cepr_march_`i'.dta ;
   keep month state mis hhid hhseq perno year age id famno famhh famtyp p*fam research st*yr female *wgt r*all female educ
   married marstat empl unem nilf csr centcity
   suburb rural occly* rhr* dis* relhdh* wbho state  ;
  append using `tempbig';
  save `tempbig', replace;
};


gen edclass=1 if educ<=2;
replace edclass=2 if educ==3;
replace edclass=3 if educ>=4 & educ<=5 ;
label def edlab 1 LEHS 2 SomeC 3 College;
label val edclass edlab;
label var edclass "LEHS SomeC College";

save `outfile'/cps_march_incdata_8089.dta, replace ;

/**************/
/* 1990-1999  */
/**************/
clear ;
use `rawdata'/cepr_march_1990 ;
   keep month state mis hhid hhseq perno year age id famno famhh famtyp p*fam research st*yr female *wgt r*all female educ
   married marstat empl unem nilf csr centcity
   suburb rural occly* rhr* dis* relhdh* wbho state  ;
   tempfile temp1990;
   save `temp1990';


forval i = 1991 (1) 1999 {;
  use "`rawdata'/cepr_march_`i'.dta" ;
   keep month state mis hhid hhseq perno year age id famno famhh famtyp p*fam research st*yr female *wgt r*all female educ
   married marstat empl unem nilf csr centcity
   suburb rural occly* rhr* dis* relhdh* wbho state  ;
  append using `temp1990';
  save `temp1990', replace;
};

gen edclass=1 if educ<=2;
replace edclass=2 if educ==3;
replace edclass=3 if educ>=4 & educ<=5 ;
label def edlab 1 LEHS 2 SomeC 3 College;
label val edclass edlab;
label var edclass "LEHS SomeC College";

save `outfile'/cps_march_incdata_9099.dta, replace;


/**************/
/* 2000-2016  */
/**************/
clear ;
tempfile temp2000;
use `rawdata'/cepr_march_2000 ;
   keep month state mis hhid hhseq perno year age id famno famhh famtyp p*fam research st*yr female *wgt r*all female educ
   married marstat empl unem nilf csr centcity
   suburb rural occly* rhr* dis* relhdh* wbho state  ;
   save `temp2000';


forval i = 2001 (1) 2018 {;
  use "`rawdata'/cepr_march_`i'.dta" ;
   keep month state mis hhid hhseq perno year age id famno famhh famtyp p*fam research st*yr female *wgt r*all female educ
   married marstat empl unem nilf csr centcity
   suburb rural occly* rhr* dis* relhdh* wbho state  ;
  append using `temp2000';
  save `temp2000', replace;
};

/* case deaton educations */
gen edclass=1 if educ<=2;
replace edclass=2 if educ==3;
replace edclass=3 if educ>=4 & educ<=5 ;
label def edlab 1 LEHS 2 SomeC 3 College;
label val edclass edlab;
label var edclass "LEHS SomeC College";

save `outfile'/cps_march_incdata_0018.dta, replace;

/***********/
/* append  */
/***********/
use `outfile'/cps_march_incdata_8089 ;
append using `outfile'/cps_march_incdata_9099;
append using `outfile'/cps_march_incdata_0018;

/* make an identifier by each hh */
bysort year hhseq: gen one=1 if _n==1;

/* identify a head in this order:
   for relhdh: 1=head, 2=primary individual, 3=husband, 4=wife of head
   for relhdh8088: 1=head, 2=primary individual, 3 =spouse of head */

gen hhead=1 if relhdh8088==1;
replace hhead=1 if relhdh==1;
bysort year hhseq: egen hashead=max(hhead);

count if one==1;
count if one==1 & hashead==.;

replace hhead=1 if relhdh8088==2 & hashead==.;
replace hhead=1 if relhdh==2 & hashead==.;

drop hashead;
bysort year hhseq: egen hashead=max(hhead);
count if one==1 & hashead==.;


replace hhead=1 if relhdh8088==3 & hashead==.;
replace hhead=1 if relhdh==3 & hashead==.;

drop hashead;
bysort year hhseq: egen hashead=max(hhead);
count if one==1;
count if one==1 & hashead==.;

replace hhead=1 if relhdh==4 & hashead==.;

drop hashead;
bysort year hhseq: egen hashead=max(hhead);
count if one==1;
count if one==1 & hashead==.;


/* what's left unidentified is a head in 1% of cases where highest ranked person is son/daughter of head */
label var hashead "=1 if a householder has been identified";
label var hhead "=1 if person is householder";

tab relhdh if hhead==1;
tab relhdh8088 if hhead==1;




/*make some variables for head of household */
foreach var in age educ married marstat female wbho {;
   gen hhead`var' = `var'*hhead ;
   bysort year hhseq: egen H`var'=max(hhead`var') ;
   label var H`var' "householder `var'" ;
   drop hhead`var' ;
};

#delimit ;

/* prep ed class detailed */
gen edclass_4bin = edclass + 1 ; 
replace edclass_4bin = 1 if educ == 1  ;
ren edclass edclass_3bin ;
ren edclass_4bin edclass ;

save `outfile'/cps_march_inc_8018.dta, replace;




