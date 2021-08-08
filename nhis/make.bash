# this bash file opens and converts all the mortality files 
# last updated: September 2020 (added recent NHIS mortality data)
# author: CR 

# unzip 
bash nhis/unzip_persons.bash  

# convert everything to lowercase 
bash nhis/lowercase.bash

cd $mortdir
# these sed commands show how to change the raw nber dofiles to make them runable (though they have now been overwritten, so you will need to adjust whatever the current globals are) 
# sed -i 's?/homes/data/nhis/ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/NHIS?\$mdata/raw/nhis//?g' nhis/*.do
# sed -i 's?//?/?g' nhis/*.do
# sed -i 's?\$mdata/raw/nhis//?\$mdata/raw/nhis//?g' nhis/*.do
# sed -i 's?~/iec1/mortality/?\$mdata?g' nhis/*.do
# sed -i 's?\$mdatanhis?\$mdata/raw/nhis/?g' nhis/*.do
# sed -i 's?\$mdatanhis?\$mdata/raw/nhis/?g' nhis/*.do

# do the nber dofiles to build the persons files 
stata -b do nhis/build_personsx.do 

# build the dofiles for the mortality portion 
bash nhis/copy_mortfile.bash

# run these dofiles 
rm -f nhis/clean/*_pmort.dta 
stata -b do nhis/build_mortfile.do 

# merge the two datasets 
stata -b do nhis/merge_nhis.do

# collapse and create graph-ready dataset 
stata -b do nhis/collapse_nhis.do

# graph average percent change in mortality over time 
stata -b do nhis/graph_nhis_pn.do 
