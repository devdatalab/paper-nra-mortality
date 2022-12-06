/*********************************************************/
/* race options: WNH BNH H O                             */
/* ed options: "" = CD educations, _detailed = 4 classes  */
/*********************************************************/

/* 
to generate thee data INCORPORATING NCHS state records, it will output into the NCHS folder.
but must invoke nchs optional parameter
*/ 

capture pr drop gen_rates
pr define gen_rates
  syntax, race(string) [etype(string) dropstates granage nchs rep] 
  cd $mdata

  if ("`nchs'" == "") local data = "$mdata/int"
  if ("`nchs'" != "") local data = "$mdata/int/nchs"
  if ("`nchs'" != "") local dropstates = "dropstates"

  if inlist("`race'","WNH","BNH","H","O") == 0 {
    di "need to specify race correctly"
    stop
  }

  if inlist("`etype'","", "_3bin") == 0 {
    di "need to specify ed type correctly"
    stop
  }

  /* reassign the granular ages */
  if "`granage'" != "" { 
    local age_gp = "age"
  }
  if "`age_gp'" == "" {
    local age_gp = "age_gp"
  }

  /* make race strings to locals */ 
  if "`race'" == "WNH" {
    local racestring = "ind_WNH == 1"
    local cpsrace = 1
  }

  if "`race'" == "BNH" {
    local racestring = "ind_BNH == 1"
    local cpsrace = 2
  }

  if "`race'" == "H" {
    local racestring = "ind_hisp == 1"
    local cpsrace = 3
  }

  if "`race'" == "O" {
    local racestring = "ind_hisp + ind_BNH + ind_WNH == 0"
    local cpsrace = 4
  }

  /* Counting mortality by cause and all-cause for non-Hispanic whites 1992-2015 by 5-yr age group by sex and education class */
  /* EXCLUDING FOUR STATES THAT DON'T HAVE EDUCATION DATA IN EARLY 1990S ON DEATH CERTS: GA,OK,RI,SD */
  /* for education work: don't use data prior to 1992 */
  /* Use population counts for 5-yr age groups by sex and education from March CPS  */

  /* count overall death and death by cause by year   */
  /* here is what we'll call them:
  Tmort = total number of deaths in the sex/age/education group
  Pmort = deaths by accidental or intent undetermined poisoning from alcohol/drugs and sequelae
  Smort = suicide deaths and sequelae
  Cmort = cancer deaths
  Hmort = heart disease
  Lmort = alcoholic liver diseases (includes cirrhosis)
  CDmort= cerebrovascular disease
  CLmort= chrnc lower resp disease
*/

  /**********************************************************************/

  use "`data'/mort_8918", clear
  /**  keep white non-Hispanics  1992-2015  ****/
  keep if year>=1992
  keep if `racestring'

* drop the four states we won't use *
  if "`dropstates'" != "" {
    drop if (fipsstr==13|fipsstr==40|fipsstr==44|fipsstr==46)
  }

  keep  icd9 icd9n icd10 year  sex `age_gp' edclass`etype'
  gen str1 xcode = icd10 

  /* make our cause of death indicators */

  /*******************/
  /*** poison ***/

  gen pois = 0

  /* the icd9 and icd10 selection includes (the very few cases) of alcohol and drug poisoning with intent undetermined */
  replace pois=1 if icd9n>=8500 & icd9n<=8609 
  replace pois=1 if icd9n>=9800 & icd9n<=9804
  replace pois=1 if (icd9n>=850 & icd9n<=860 & length(icd9)==3)| (icd9n==980  & length(icd9)==3)

  forval i = 10(1)15{
    replace pois = 1 if icd10=="Y`i'" 
  }
  forval i = 40(1)45{
    replace pois = 1 if icd10=="X`i'" 
  }
  forval i = 45(2)49{
    replace pois = 1 if icd10=="Y`i'" 
  }


  /*******************/
  /***** suicide *****/

  gen suicide = 0

  replace suicide=1 if icd9n>=9500 & icd9n<=9599 
  replace suicide= 1 if icd9n>=950 & icd9n<=959 & length(icd9)==3

  forval i = 60(1)84{
    replace suicide = 1 if icd10=="X`i'" 
  }
  replace suicide = 1 if icd10=="Y870"

  /*******************/
  /****** liver ******/
  gen liver = 0

  replace liver=1 if icd9n>=5710 & icd9n<=5719 
  replace liver=1 if icd10=="K70"

  forval i = 0(1)9{
    replace liver=1 if icd10=="K70`i'"
  }

  forval i = 30(1)49{
    replace liver=1 if icd10=="K7`i'"
  }

  /****************************************/
  /*** heart disease as defined by CDC  ***/

  gen heart = 0

  replace heart=1 if icd9n>=390 & icd9n<=429 & length(icd9)==3
  replace heart=1 if icd9n>=3900 & icd9n<=4299


  forval i = 0(1)99{
    replace heart=1 if icd10=="I0`i'"
  }

  forval i = 11(2)13{
    replace heart=1 if icd10=="I`i'"
  }

  forval i = 0(1)9{
    replace heart=1 if icd10=="I11`i'"
    replace heart=1 if icd10=="I13`i'"
  }

  forval i = 20(1)51{
    replace heart=1 if icd10=="I`i'"
  }
  forval i = 200(1)519{
    replace heart=1 if icd10=="I`i'"
  }



  /************************************/
  /*** cancer (malignant neoplasms) ***/

  gen cancer=0

  replace cancer =1 if icd9n>=140 & icd9n<=208 & length(icd9)==3
  replace cancer =1 if icd9n>=1400 & icd9n<=2089
  replace cancer =1 if xcode=="C"

  /***************/
  /* LUNG CANCER */
  gen lungC=0
  replace lungC =1 if icd9n>=1622 & icd9n<=1629 & length(icd9)==4
  replace lungC=1 if substr(icd10,1,3)=="C34"


  /*******************/
  /* cerebrovascular */
  gen cereb=0
  replace cereb=1 if icd9n>=430 & icd9n<=438 & length(icd9)==3
  replace cereb=1 if icd9n>=4300 & icd9n<=4389
  forval i = 60(1)69 {
    replace cereb=1 if substr(icd10,1,3) == "I`i'"
  }

  /**********/
  /** CLRD **/
  gen resp=0
  replace resp=1 if icd9n>=490 & icd9n<=496 & length(icd9)==3
  replace resp=1 if icd9n>=4900 & icd9n<=4969 
  forval i = 40(1)47{
    replace resp=1 if substr(icd10,1,3)=="J`i'"
  }

  /***********/
  /*** accidents/war */
  gen accid = 0
  replace accid = 1 if inlist(substr(icd10,1,1),"V","W","X","Y") == 1 & pois + liver + suicide == 0
  replace accid = 1 if (icd9n > 8000 & icd9n <=9999 & pois + liver + suicide == 0 & length(icd9) == 4) | (icd9n > 800 & icd9n <= 999 & length(icd9) == 3 & pois + liver + suicide == 0 )

  /*******/
  /*** generate other */
  gen other_dis = accid + resp + cereb + cancer + heart + liver + suicide + pois == 0 


  /********/
  /*** for 1999-2015 only, generate other resp, infectious as subsets of respiratory ***/
  gen other_resp = substr(icd10,1,1) == "J" & other_dis == 1
  gen other_viral = inlist(substr(icd10,1,1),"A","B") & other_dis == 1 


  /*********/
  /*** get all of the other icd10 codes ***/ 
  foreach icd10code in a b d e f g h i j k l m n o p q r {  // note that there is no "U"
    gen icd10_`icd10code' = substr(icd10,1,1) == upper("`icd10code'") & other_dis == 1  
  } 

  sum

  save $tmp/`race'rates`etype'`dropstates'`granage'`rep', replace


  /******************************** sum by cause of death  *******************/

  use $tmp/`race'rates`etype'`dropstates'`granage'`rep' 

  gen one=1
  bysort `age_gp' sex edclass`etype' year: egen Tmort = total(one)
  bysort `age_gp' sex edclass`etype' year: egen Pmort = total(pois)
  bysort `age_gp' sex edclass`etype' year: egen Smort = total(suicide)
  bysort `age_gp' sex edclass`etype' year: egen Lmort = total(liver)
  bysort `age_gp' sex edclass`etype' year: egen Hmort = total(heart)
  bysort `age_gp' sex edclass`etype' year: egen Cmort = total(cancer)
  bysort `age_gp' sex edclass`etype' year: egen lungCmort = total(lungC)
  bysort `age_gp' sex edclass`etype' year: egen CDmort = total(cereb)
  bysort `age_gp' sex edclass`etype' year: egen CLmort = total(resp)
  bysort `age_gp' sex edclass`etype' year: egen Amort = total(accid)
  bysort `age_gp' sex edclass`etype' year: egen Omort = total(other_dis)
  bysort `age_gp' sex edclass`etype' year: egen ORmort = total(other_resp)
  bysort `age_gp' sex edclass`etype' year: egen OVmort = total(other_viral)


  foreach icd10code in a b d e f g h i j k l m n o p q r  {  // note that there is no "U"
    bysort `age_gp' sex edclass`etype' year: egen icd10`icd10code'mort = total(icd10_`icd10code')
  } 


  by `age_gp' sex edclass`etype' year, sort: keep if _n==1
  save $tmp/`race'rates`etype'_bysex`dropstates'`granage'`rep', replace

  /** for both sexes together **/
  use $tmp/`race'rates`etype'`dropstates'`granage'`rep' 
  drop sex

  gen one=1
  bysort `age_gp' edclass`etype' year: egen Tmort = total(one)
  bysort `age_gp' edclass`etype' year: egen Pmort = total(pois)
  bysort `age_gp' edclass`etype' year: egen Smort = total(suicide)
  bysort `age_gp' edclass`etype' year: egen Lmort = total(liver)
  bysort `age_gp' edclass`etype' year: egen Hmort = total(heart)
  bysort `age_gp' edclass`etype' year: egen Cmort = total(cancer)
  bysort `age_gp' edclass`etype' year: egen lungCmort = total(lungC)
  bysort `age_gp' edclass`etype' year: egen CDmort = total(cereb)
  bysort `age_gp' edclass`etype' year: egen CLmort = total(resp)
  bysort `age_gp' edclass`etype' year: egen Amort = total(accid)
  bysort `age_gp' edclass`etype' year: egen Omort = total(other_dis)
  bysort `age_gp' edclass`etype' year: egen ORmort = total(other_resp)
  bysort `age_gp' edclass`etype' year: egen OVmort = total(other_viral)

  foreach icd10code in a b d e f g h i j k l m n o p q r  {  // note that there is no "U"
    bysort `age_gp' edclass`etype' year: egen icd10`icd10code'mort = total(icd10_`icd10code')
  } 

  by `age_gp' edclass`etype' year, sort: keep if _n==1
  gen sex=0
  merge 1:1 year sex `age_gp' edclass`etype' using $tmp/`race'rates`etype'_bysex`dropstates'`granage'`rep'
  keep year sex `age_gp' edclass`etype' *mort
  save $tmp/`race'rates`etype'`dropstates'`granage'`rep', replace

  /** assigning deaths without education information **/

  use $tmp/`race'rates`etype'`dropstates'`granage'`rep' 

  reshape wide  Tmort Pmort Smort Lmort Hmort Cmort lungCmort CDmort CLmort Amort Omort ORmort OVmort
  icd10amort icd10bmort icd10dmort icd10emort icd10fmort
  icd10gmort icd10hmort icd10imort icd10jmort icd10kmort icd10lmort icd10mmort icd10nmort icd10omort icd10pmort icd10qmort icd10rmort
  , i(year `age_gp' sex) j(edclass`etype')

  sum *mort99

  
  foreach i in T P S L H C lungC CD CL O OR A OV icd10a icd10b icd10d icd10e icd10f
  icd10g icd10h icd10i icd10j icd10k icd10l icd10m icd10n icd10o icd10p icd10q icd10r
  {

    if "`etype'" != "" { 
      gen MORT`i' = `i'mort1 + `i'mort2 + `i'mort3
      replace `i'mort1 = `i'mort1 + (`i'mort1/MORT`i') * `i'mort99
      replace `i'mort2 = `i'mort2 + (`i'mort2/MORT`i') * `i'mort99
      replace `i'mort3 = `i'mort3 + (`i'mort3/MORT`i') * `i'mort99
    } 

    if "`etype'" == "" { 
      gen MORT`i' = `i'mort1 + `i'mort2 + `i'mort3 + `i'mort4 
      replace `i'mort1 = `i'mort1 + (`i'mort1/MORT`i') * `i'mort99
      replace `i'mort2 = `i'mort2 + (`i'mort2/MORT`i') * `i'mort99
      replace `i'mort3 = `i'mort3 + (`i'mort3/MORT`i') * `i'mort99
      replace `i'mort4 = `i'mort4 + (`i'mort4/MORT`i') * `i'mort99
    } 

  } 

  if "`etype'" == "" { 
    keep year sex `age_gp' *mort1 *mort2 *mort3 *mort4  
  } 

  else { 
    keep year sex `age_gp' *mort1 *mort2 *mort3   
  } 

  reshape long Tmort Pmort Smort Lmort Hmort Cmort lungCmort CDmort CLmort Amort Omort ORmort OVmort
  icd10amort icd10bmort icd10dmort icd10emort icd10fmort
  icd10gmort icd10hmort icd10imort icd10jmort icd10kmort icd10lmort icd10mmort icd10nmort icd10omort icd10pmort icd10qmort icd10rmort
  , i(year sex `age_gp') j(edclass`etype')

  save $tmp/`race'rates`etype'`dropstates'`granage'`rep', replace
  /**********************************************************************/
  /***********       make population counts by cell        **************/
  /**********************************************************************/



  tempfile tempdat

  /* make state identifiers compatible between death records and CPS */
  use $mdata/raw/misc/STCROSS.dta, clear
  ren State state
  merge 1:m  state using $mdata/int/cps_march_inc_8018.dta 
  drop _m

  keep if wbho==`cpsrace'
  gen sex = female + 1

  /* drop states that don't have education on death certificates */
  /* and keep records from 1992 on to use in education work */
  drop if year<1992
  if "`dropstates'" != "" { 
    drop if (fipsstr==13|fipsstr==40|fipsstr==44|fipsstr==46)
  }

  gen age_gp=.
  forval i = 25(5)70 {
    replace age_gp=`i' if age>=`i' & age<=`i'+4 
  }
  drop if age_gp==.

  bysort year sex `age_gp' edclass`etype': egen TPop = total(wgt)
  bysort year sex `age_gp' edclass`etype': keep if _n==1

  keep year sex `age_gp' edclass`etype' TPop 
  save `tempdat'

  /****  both sexes together ****/
  use $mdata/raw/misc/STCROSS.dta
  ren State state
  merge 1:m  state using $mdata/int/cps_march_inc_8018.dta 
  drop _m

  keep if wbho==`cpsrace'

  /* drop states that don't have education on death certificates */
  /* and keep records from 1992 on to use in education work */
  drop if year<1992
  if "`dropstates'" != "" { 
    drop if (fipsstr==13|fipsstr==40|fipsstr==44|fipsstr==46)
  }

  gen age_gp=.
  forval i = 25(5)70 {
    replace age_gp=`i' if age>=`i' & age<=`i'+4 
  }
  drop if age_gp==.

  bysort year `age_gp' edclass`etype': egen TPop = total(wgt)
  bysort year `age_gp' edclass`etype': keep if _n==1

  gen sex=0
  keep year sex `age_gp' edclass`etype' TPop 


  merge 1:1 year sex `age_gp' edclass`etype' using `tempdat'
  drop _m
  save `tempdat', replace



  /**********************************************************************/
  /***********  now combine deaths with population by cell **************/
  /**********************************************************************/

  merge 1:1 year `age_gp' sex edclass`etype' using $tmp/`race'rates`etype'`dropstates'`granage'`rep'

  /* _m==1 is for groups that recorded no deaths in that year */

  foreach var in T P S L H C lungC CD CL O OR A OV icd10a icd10b icd10d icd10e icd10f
  icd10g icd10h icd10i icd10j icd10k icd10l icd10m icd10n icd10o icd10p icd10q icd10r
  {
    replace `var'mort = 0 if _m==1 
    gen `var'rate   = (`var'mort/TPop)*100000
  }

  tab year if _m==2
  drop _m
  label var Prate "alc/drug poisoning"
  label var Hrate "heart disease"
  label var Crate "cancer"
  label var Srate "suicide"
  label var Trate "all cause"
  label var Lrate "alcoholic liver"
  label var lungCrate "lung cancer"
  label var CDrate "cerebrovascular disease"
  label var CLrate "chrnc lower resp disease"

  d


  /* hack to manually drop the dropstates local, for saving purposes, if the nchs optional parameter is invoked. as this is redundant */ 
  if ("`nchs'" != "") local dropstates = "" 

  save `data'/`race'rates`etype'`dropstates'`granage'`rep', replace


end

/* mortality rates */ 
gen_rates, race(WNH) nchs
gen_rates, race(O) nchs 
gen_rates, race(H) nchs
gen_rates, race(BNH) nchs

/* get rates for all ages */
gen_rates, race(O)  granage nchs 
gen_rates, race(H)  granage nchs
gen_rates, race(BNH)  granage nchs
gen_rates, race(WNH) granage nchs

/* mortality rates for 3 education groups */ 
gen_rates, etype("_3bin") race(WNH)  nchs
gen_rates, etype("_3bin") race(H)  nchs
gen_rates, etype("_3bin") race(BNH)  nchs
gen_rates, etype("_3bin") race(O)  nchs






/****************************************************/
/* /\* clean wipe everything *\/                    */
/* foreach race in WNH BNH H O {                    */
/*         capture !rm -f $mdata/int/`race'rates*.dta */
/*         capture !rm -f tmp/`race'rates*.dta      */
/* }                                                */
/* 
/* get version for replication */ 
gen_rates, etype("_3bin") race(WNH) dropstates 
gen_rates, etype("_3bin") race(H) dropstates
gen_rates, etype("_3bin") race(BNH) dropstates
gen_rates, etype("_3bin") race(O) dropstates

/* build without nchs 

gen_rates, race(O)
gen_rates, race(H)
gen_rates, race(BNH)
gen_rates, race(WNH)

gen_rates, etype("_3bin") race(WNH)
gen_rates, etype("_3bin") race(H)
gen_rates, etype("_3bin") race(BNH)
gen_rates, etype("_3bin") race(O)

/* get it for all states */
gen_rates, race(O)  granage
gen_rates, race(H)  granage
gen_rates, race(BNH)  granage 
gen_rates, race(WNH) granage 

gen_rates, etype("_3bin") race(WNH) granage 
gen_rates, etype("_3bin") race(H) granage 
gen_rates, etype("_3bin") race(BNH) granage 
gen_rates, etype("_3bin") race(O) granage 

*/
