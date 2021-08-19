/* build all the persons files */ 
       
forv i = 1997/2017 {
  clear 
  capture log close 
  cd $mdata/int/nhis/clean/
  do $mcode/nhis/nhis`i'_personsx.do
}
