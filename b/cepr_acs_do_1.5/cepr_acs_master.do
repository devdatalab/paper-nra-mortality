clear
set more 1
set mem 4g

/*

THIS IS THE NEW CEPR MASTER - note that educ is replaced

File:	cepr_acs_master.do
Date:	Jan 10, 2011
	Nov 15, 2011
	Oct 26, 2012
	Dec 20, 2013
	Jan 27, 2015, CEPR ACS Version 1.0
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Master file for CEPR extract of American Community Survey 2005-2018
*/

/* Part 1: set directories */

	/*Stata version*/

global statanew = 1 /* Set to 0 if using Stata 12 or older; 1 if using Stata 13 or newer */


global do "$mcode/b/cepr_acs_do_1.5"
global raw_data "$mdata/raw/acs"
global working "$tmp/cepr"
global dataout "$mdata/int/acs_prepped"
cap mkdir $dataout/
cap mkdir $working/
	/*Windows vs. GNU/Linux*/

global gnulin = 1 /* Set to 0 if you run Windows; 1 if GNU/Linux/Unix/Mac */
global version "1.5"

	/* Windows users will need to download Unix command line utilities 
	  to add the gzip command to the Command Prompt. */

	/*executables*/
global gzip "/usr/bin/gzip"
global unzip "/usr/bin/unzip/"
global zip "/usr/bin/zip"
global copy "/bin/cp"
global erase "/bin/rm"


/* set ACS version number  */

global version 1.5

/* read raw data */

cd "$do"
cd cepr_acs_read
do cepr_acs_read_2006.do
do cepr_acs_read_2007.do
do cepr_acs_read_2008.do
do cepr_acs_read_2009.do
do cepr_acs_read_2010.do
do cepr_acs_read_2011.do
do cepr_acs_read_2012.do
do cepr_acs_read_2013.do
do cepr_acs_read_2014.do
do cepr_acs_read_2015.do
do cepr_acs_read_2016.do
do cepr_acs_read_2017.do
do cepr_acs_read_2018.do

cd "$working"
save temp, replace

cd "$working"
use temp, clear

cd "$do"

/* generic labels */


lab def noyes 0 No 1 Yes

/* process raw data to create consistent extract */

capture program drop acscepr
program define acscepr
version 9.0
*
while "`1'"~="" {
cd "$working"
use "acs_`1'_pre_all", clear
gen int year=`1'
lab var year "Year"
*
*
cd "$do"
do "cepr_acs_idvar.do"
do "cepr_acs_geog.do"
do "cepr_acs_housing.do"
cd "$do"
cd cepr_acs_demog
do "cepr_acs_demog.do"
cd "$do"
do "cepr_acs_family.do"
do "cepr_acs_empstat.do"
do "cepr_acs_educ.do"
cd "$do"
cd cepr_acs_ind
do "cepr_acs_ind.do"
cd "$do"
cd cepr_acs_occ
do "cepr_acs_occ.do"
cd "$do"
do "cepr_acs_income.do"
do "cepr_acs_income_real.do"
do "cepr_acs_poverty.do"
do "cepr_acs_health.do"
do "cepr_acs_disability.do"
do "cepr_acs_language.do"
do "cepr_acs_migrate.do"
do "cepr_acs_keepord.do"  /* load program to keep and order output */ 

keepord /* keeps and orders consistent variables */

compress
sort serialno sporder
lab data "CEPR ACS, Version $version, `1'"
cd "$dataout"
saveold "cepr_acs_`1'.dta", replace
mac shift
}
end

/* program switches */
acscepr 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018

/* Release Notes
1.5	Apr 16, 2020
	  1. Added 2018 data
	  2. Incorporated updates to CPI-U-RS price adjustment values
	  3. Created variables puma00, puma10, powsp00, powsp10, powpuma00, powpuma10, 
	     migpuma00, and migpuma10, to distinguish between 2000 and 2010 geographic
		 vintages
	  4. Renamed migsp2012 to migsp12, and migsp2017 to migsp17
	  5. Changed program file locations of jwmnp, jwrip, jwtr, jwap, and jwdp
	  6. Added variables anc1p18 and anc2p18, incorporating newly suppressed 
	     values and updated value labels 
	  7. Added variables and program files for ind3d_18, ind_naics18, and socp18
	     to reflect new categories
	  8. Added variable occp18 to reflect new occupation categories
	  9. Added variable pubtran to indicate use of public transit to commute to work
	  10. Added variable hmrnt to indicate renter status
	  11. Added variable taxp_amt (available 2018 onward) for numerical property 
	      tax values
	  12. Updated variable taxp to create brackets for 2018
	  13. Incorporated 2018 ACS flag variables into coding for elep_adj, fulp_adj, 
	      gasp_adj, and watp_adj
	  14. Added variable waob18 to reflect alternate categorization of American Samoa
	  15. Added variables yoep05, yoep12, yoep17, yoep18 to reflect variations in
	      collapsed categories
	  16. Added variables citwp08, citwp12, and citwp17 to reflect variations in
	      collapsed categories
      17. Added variable pov200 to indicate low-income (>200% poverty line)
	  18. Added comment on ACS rounding procedures for income variables
	  19. Updated top-coding notes for incp_all_adj, incp_paw_adj, 
	      incp_ss_adj, incp_ssi_adj, and incp_ern_adj
	  20. Corrected errors in read files for 2005 and 2006
	  21. Renamed program files for individual variables to incorporate the
	      subject of their root program files
	  22. Changed directory pathways for read, occupation, industry, and demographic 
	      program files
1.4	May 30, 2019
	  1. Added 2017 data
	  2. Updated value labels for lanp, hhlanp, anc1p, anc2p, migsp, and pobp
	  3. Corrections to include 2016 data for anc1p, anc2p, and pobp
	  4. Fixed 2016 code for labeling values for lanp
	  5. Updated read file in order to account for changes in naming conventions
	  6. Added zip and unzip functionality to read files for all years
	  7. Updates to CPI-U-RS price adjustment values
	  8. Added variable misgp2017
	  8. Added variables wbhapo and wbhapom
	  9. Added variables lanp17 and hhlanp17
	  10. Dropped variable race1
	  11. Excluded "and other races" from variables asian_d2005, asian_d2012, pi_d2005, 
	     pi_d2012, aapisub2_2005, and aapisub2_2012
	  12. Adjustments to categories for variable lfstat
1.3	Nov 9, 2017
	  1. Added new variables: hispeed, smartphone, tablet
	  2. Added new value labels for lanp and hhlanp
	  3. For 2016 only, dropped: bus, toil, dsl, fiberop, handheld, modem 
	     (underlying variables discontinued by Census)
1.2	Oct 24, 2016
	  1. added raw esr variable
	  2. fixed error in civnonmil variable - not available all years
	  3. fixed error in nhhchild
	  4. dropped unadjusted housing variables: conp, elep, fulp, gasp, insp, mhp, mrgp,
	     rntp, smp, value08, watp, grntp, smocp
	  5. fixed error in mrgx
	  6. fixed error in ybl_all
1.1.1	Sep 19, 2016
	  1. Fixed error in wbho, wbhao, race1 that didn't properly identify Hispanic respondents
	  2. Added LNGI - limited English speaking household
	  3. Deleted unadjusted wage variables
1.1	Nov 3, 2015
	  1. Added 2014 data
	  2. Corrected error in age that set those age 0 to missing
	  3. Renamed rac2p to rac2p2005, rac3p to rac3p2005, asian_d to asian_d2005,
	     pi_d to pi_d2005, aapisub2 to aapisub2_2005, vps05 to vps in demog program
	  4. Deleted partner05 and partner07. Added partner variable
	  5. Added new school variables: sch, enrolled, grade, grade05, and grade08
	  6. Updated real.do program with updated CPI-U-RS values for several years
	  7. Added new variable hins_imputed (health insurance imputed)
1.0	Jan 16, 2015
	  1. Added 2013 Data
	  2. Added new housing and income variables that take into account internal
	      ACS adjustment factors. Their names end with "_adj".
	  3. Corrected wbhao, asian_d, asian_d2012, pi_d2012 variables
	  4. Corrected anc1p08, anc2p08 variables
	  5. Corrected income from retirement variable, incp_ret
	  6. Corrected CPI values for years 2005-2010
	  7. Corrected tricare or military insurance variable, hiothpub
	  8. Renamed military service variable mil to milstat, and made consistent
	      over 2005-2013.
	  9. Corrected industry and occupation variables and attached labels.
	
0.93	Dec 23, 2013
	1. Added 2012 Data

0.92	Oct 26, 2012
	  1. Added 2011 Data

0.91	Sep 6, 2012
	  1. Added 2010 data
	  2. Changed occupation and industry variables from bytes to strings. This allows
	      for combining variables across years
	  3. Corrected full-time full year variable, ftfy
  
0.9	October 2011
	  Beta release
  
*/

/*
Copyright 2020 CEPR, John Schmitt, Janelle Jones, Cherrie Bucknor, 
Brian Dew, Hayley Brown

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
