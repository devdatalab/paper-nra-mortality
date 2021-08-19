/***************************/
/* /\* unzip nchs data *\/ */
/***************************/
cd ~/iec1/mortality/nchs

* !rm -f *.txt
! find . -name "*.zip" -print0 | xargs -0 -n1 unzip

***** NOTE: the 2015 data have to be hand-extracted on your windows machine, since
***** there is a .zipx file 
