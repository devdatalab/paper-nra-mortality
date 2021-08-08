/* reset working directory */
#delimit cr 
cd $mcode 
do $mcode/b/prep_nchs_mortality // NCHS data

#delimit cr 
do $mcode/b/prep_mort_rates_all.do

