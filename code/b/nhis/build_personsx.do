/* build all the persons files */ 
       
forv i = 1997/2017 {
  clear all
  capture log close 
  cd $mdata
  do $mcode/nhis/nhis`i'_personsx.do
}
