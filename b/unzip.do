/* unzip mortality files */
cd $mdata/raw_data/
* !rm -f *.PUB
forv i = 1989/2015 {
  !unzip $mdata/raw_data/mort`i'us.zip
}


* !rm -f *cepr*.dta
forv i = 1980/2015 {
  !unzip $mdata/raw_data/cepr_march_`i'.zip
}

forv year = 2005/2018 {
    cap !rm -rf ~/iec1/mortality/acs/`year'
  */
    cap mkdir ~/iec1/mortality/acs/`year'/
    !cp  ~/iec1/mortality/acs/raw_acs*indiv*`year'*.zip ~/iec1/mortality/acs/`year'/csv_pus.zip
    !cp  ~/iec1/mortality/acs/raw_acs*hh*`year'*.zip ~/iec1/mortality/acs/`year'/csv_hus.zip  
}






