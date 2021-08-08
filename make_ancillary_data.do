/***************************************************/
/* prepares ancillary data: CPS, ACS, Census, NHIS */
/***************************************************/

/* build acs data */
do $mcode/b/cepr_acs_do_1.5/cepr_acs_master.do

/* reset working directory */
#delimit cr 
cd $mcode 

/* build CPS and census */
do $mcode/b/prep_cps  

#delimit cr
do $mcode/b/raw_census_1990.do
do $mcode/b/raw_census_2000.do
do $mcode/b/prep_census_1990.do
do $mcode/b/prep_census_2000.do

#delimit cr
do $mcode/b/prep_institutionalized.do

/* NHIS build */
#delimit cr
cd $mcode 

/* run the individual file */ 
do $mcode/nhis/build_personsx.do

/* build the deaths files */
do $mcode/nhis/build_mortfile.do

/* merge the individual records with the deaths */
do $mcode/nhis/merge_nhis.do

/* collapse the nhis deaths */ 
do $mcode/nhis/collapse_nhis.do
