/*
File:	cepr_acs_read_2011.do
Date:	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Reads and pre-processes raw American Community Survey 1-year PUMS data from 2011
*/

capture program drop rd2011
if $statanew==1 {
program define rd2011
version 9.0

/* read raw ACS person and household records
* syntax: macro 1 refers to a and b files
*/
/* read person records */

cd "$raw_data"
cd 2011
unzipfile csv_pus.zip
qui insheet using ss11pusa.csv, comma names clear
sort serialno
compress
cd "$working"
save "p_2011_temp_a.dta", replace

cd "$raw_data"
cd 2011
qui insheet using ss11pusb.csv, comma names clear
sort serialno
compress
cd "$working"
save "p_2011_temp_b.dta", replace

cd "$raw_data"
cd 2011
zipfile *.csv, saving(csv_pus.zip, replace)
erase ss11pusa.csv
erase ss11pusb.csv

/* read household records */

cd "$raw_data"
cd 2011
unzipfile csv_hus.zip
qui insheet using ss11husa.csv, comma names clear
sort serialno
compress
cd "$working"
save "h_2011_temp_a.dta", replace

cd "$raw_data"
cd 2011
qui insheet using ss11husb.csv, comma names clear
sort serialno
compress
cd "$working"
save "h_2011_temp_b.dta", replace

cd "$raw_data"
cd 2011
zipfile *.csv, saving(csv_hus.zip, replace)
erase ss11husa.csv
erase ss11husb.csv

end
}
if $statanew==0 {
program define rd2011
version 9.0

/* read raw ACS person and household records
* syntax: macro 1 refers to a and b files
*/
/* read person records */

cd "$raw_data"
cd 2011
!unzip csv_pus.zip
qui insheet using ss11pusa.csv, comma names clear
sort serialno
compress
cd "$working"
save "p_2011_temp_a.dta", replace

cd "$raw_data"
cd 2011
qui insheet using ss11pusb.csv, comma names clear
sort serialno
compress
cd "$working"
save "p_2011_temp_b.dta", replace

cd "$raw_data"
cd 2011
!zip -r csv_pus.zip . -i \*.csv
!$erase ss11pusa.csv
!$erase ss11pusb.csv

/* read household records */

cd "$raw_data"
cd 2011
!unzip csv_hus.zip
qui insheet using ss11husa.csv, comma names clear
sort serialno
compress
cd "$working"
save "h_2011_temp_a.dta", replace

cd "$raw_data"
cd 2011
qui insheet using ss11husb.csv, comma names clear
sort serialno
compress
cd "$working"
save "h_2011_temp_b.dta", replace

cd "$raw_data"
cd 2011
!zip -r csv_hus.zip . -i \*.csv
!$erase ss11husa.csv
!$erase ss11husb.csv

end
}

capture program drop com2011
program define com2011
version 9.0

/* append p files */

cd "$working"
use "p_2011_temp_a", clear
append using "p_2011_temp_b"
sort serialno sporder
save "p_2011_temp_ab", replace
cd "$raw_data"
sort serialno sporder
label data "Raw 2011 ACS person level data, converted to Stata format"
save "acs_2011_P_raw", replace

/* append and merge p, h files

append h files */

cd "$working"
use "h_2011_temp_a", clear
append using "h_2011_temp_b"
sort serialno
save "h_2011_temp_ab", replace
cd "$raw_data"
sort serialno
label data "Raw 2011 ACS household level data, converted to Stata format"
save "acs_2011_H_raw", replace

/* attach household variables to person records

merge p, h files */

cd "$working"
use "h_2011_temp_ab", clear
merge serialno using "p_2011_temp_ab"

drop rt /* drop record type, since the P and H are now combined */
assert _merge==1 /* vacant houses */ | _merge==3
	/* keep vacant housing units for subsequent analysis of vacancies */
drop _merge

sort serialno sporder
compress
cd "$working"
save "acs_2011_pre_all", replace

cd "$working"
!rm "p_2011_temp_a.dta"
!rm "p_2011_temp_b.dta"
!rm "p_2011_temp_ab.dta"
!rm "h_2011_temp_a.dta"
!rm "h_2011_temp_b.dta"
!rm "h_2011_temp_ab.dta"

end

/* program switches */

	/* read raw data */

clear
set mem 2g

rd2011

	/* combine all variables in all state files 
	   (if RAM is sufficiently large) */

clear
set mem 4g

com2011

cd "$do"
cd cepr_acs_read

/* 
Copyright 2020 CEPR, John Schmitt, Janelle Jones, and Hayley Brown

Center for Economic and Policy Research
1611 Connecticut Avenue, NW Suite 400
Washington, DC 20009
Tel: (202) 293-5380
Fax: (202) 588-1356
http://www.cepr.net

This file is part of the cepr_acs_master.do program. This file and all
programs referenced in it are free software. You can redistribute the
program or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA.
*/
