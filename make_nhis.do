/**************/
/* BUILD NHIS */
/**************/

#delimit cr

* !bash $mcode/nhis/make.bash  // this is the master bash file that also builds the dofiles, but easier to just call the stata dofiles
cd $mortdir 

/* run the individual file */ 
do $mcode/nhis/build_personsx.do

/* build the deaths files */
do $mcode/nhis/build_mortfile.do

/* merge the individual records with the deaths */
do $mcode/nhis/merge_nhis.do

/* collapse the nhis deaths */ 
do $mcode/nhis/collapse_nhis.do
