set more 1

/*
File:	cepr_acs_income.do
Date:	Aug 15, 2011
	Oct 31, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent wage variables for CEPR extract of American Community Survey
Notes:  cepr_acs_income_real.do converts nominal variables created here
	to real wage variables
*/

/*     

********************* A note on ACS rounding procedures *********************

PUMS income variables are subject to rounding to protect data confidentiality. 
From 2009 onward, values are rounded as follows:
   Values in the 0 < X ≤ 7 range are rounded to 4   
      (e.g., if the unrounded value is 6, it would be rounded to 4)
   Values in the 7 < X ≤ 999 range are rounded to the nearest ten
      (e.g., if the unrounded value is 12, it would be rounded to 10)
   Values in the 999 < X ≤ 49999 range are rounded to the nearest hundred
      (e.g., if the unrounded value is 5234, it would be rounded to 5200)
   Values that exceed 49999 are rounded to the nearest thousand
      (e.g., if the unrounded value is 54123, it would be rounded to 54000)
   Values in the -7 ≤ X < 0 range are rounded to -4   
      (e.g., if the unrounded value is -6, it would be rounded to -4)
   Values in the -999 ≤ X < -7 range are rounded to the nearest negative ten
      (e.g., if the unrounded value is -12, it would be rounded to -10)
   Values in the -49999 ≤ X <-999 range are rounded to the nearest negative hundred
      (e.g., if the unrounded value is -5234, it would be rounded to -5200)
   Values below -49,999 are rounded to the nearest negative thousand
      (e.g., if the unrounded value is -54123, it would be rounded to -54000)

Prior to 2009, the rounding rules above were only applied to positive values.

Note that until 2018, certain income variables in the PUMS Data Dictionary 
displayed values of 1 with a description of “$1 or break even”. However, due to 
the rounding rules, this value was rounded and was not on the microdata files. 

*/

/* Determine survey year */

local year=year in 1


/* Inflation adjustment factor (income) */

if 2005<=`year' & `year'<=2007 {
gen adj=adjust/1000000 /* only one adjustment factor for all dollar amounts */
}
if 2008<=`year' & `year'<=2018 {
gen adj=adjinc/1000000 /* adj factor for income and earnings dollar amounts */
}
lab var adj "Adjustment factor - Income"
notes adj: ACS: ADJUST for 2005-2007
notes adj: ACS: ADJINC for 2008-present
notes adj: For 2005-2007 ADJUST adjusts all dollar amounts
notes adj: For 2008-present ADJINC adjusts only income and earnings amounts

/* various income variables are string in 2014, so destring */

if `year'==2014 {
destring pincp pernp wagp semp pap ssp ssip retp intp oip fincp hincp, replace
}
			/******** Person Level ********/

/* Total income, including unearned income */

if 2005<=`year' & `year'<=2018 {
gen incp_all_adj=round(pincp*adj,1) if pincp~=.
replace incp_all_adj=. if pincp==0
}
lab var incp_all_adj "Total person's income adj"
notes incp_all_adj: 2005-2012 Rounded and Bottom/Top Code according to/*
*/ nominal INCP_ALL:-19998/9999999
notes incp_all_adj: 2013-2016 Rounded and Bottom/Top Code according to /*
*/ nominal INCP_ALL:-19999/9999999
notes incp_all_adj: 2017-2018 Rounded and Bottom/Top Code according to /*
*/ nominal INCP_ALL:-19998/4209995
notes incp_all_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_all_adj: Data dictionaries for 2005-2017 state that values of 1  /*
*/ indicate "$1 or break even". However, due to rounding rules, this value was  /*
*/ never included in the microdata files.
notes incp_all_adj: ACS: PINCP, ADJUST (2005-2007), ADJINC (2008-present)

/* Total income, excluding unearned income */

if 2005<=`year' & `year'<=2018 {
gen incp_ern_adj=round(pernp*adj,1) if pernp~=.
replace incp_ern_adj=. if pernp==0
}
lab var incp_ern_adj "Total person's earnings adj"
notes incp_ern_adj: 2005-2012 Rounded and Bottom/Top Code according to/*
*/ nominal INCP_ERN:-9999/9999999
notes incp_ern_adj: 2013-2016 Rounded and Bottom/Top Code according to/*
*/ nopminal INCP_ERN:-10000/9999999
notes incp_ern_adj: 2017-2018 Rounded and Bottom/Top Code according to/*
*/ nopminal INCP_ERN:-10000/1999998
notes incp_ern_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_ern_adj: Data dictionaries for 2005-2017 state that values of 1  /*
*/ indicate "$1 or break even". However, due to rounding rules, this value was  /*
*/ never included in the microdata files.
notes incp_ern_adj: ACS: PERNP, ADJUST (2005-2007), ADJINC (2008-present)

/* Income from wage and salary */

if 2005<=`year' & `year'<=2018 {
gen incp_wag_adj=round(wagp*adj,1) if wagp~=.
replace incp_wag_adj=. if wagp==0
}
lab var incp_wag_adj "Wage or salary income adj"
notes incp_wag_adj: Rounded and Top-coded according to nominal INCP_WAG: $999999
notes incp_wag_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_wag_adj: ACS: WAGP, ADJUST (2005-2007), ADJINC (2008-present)

/* Hourly earnings */

if 2005<=`year' & `year'<=2007 {
gen hrearn05_adj=incp_ern_adj/(wkw05*hrslyr)
}
if 2008<=`year' & `year'<=2018 {
gen byte hrearn05_adj=.
}
lab var hrearn05_adj "Hourly earnings adj"
notes hrearn05_adj: uses continuous weeks worked variable, WKW, for 05-07
notes hrearn05_adj: Not available 2008-on b/c no continuous weeks worked variable
notes hrearn05_adj: Uses adjust to adjust to constant calendar year $
notes hrearn05_adj: ACS: Derived: PERNP WKW WKHP, ADJUST (2005-2007)

	
/* Hourly wage */

if 2005<=`year' & `year'<=2007 {
gen hrwage05_adj=incp_wag_adj/(wkw05*hrslyr)
}
if 2008<=`year' & `year'<=2018 {
gen byte hrwage05_adj=.
}
lab var hrwage05_adj "Hourly wage adj"
notes hrwage05_adj: uses continuous weeks worked variable, WKW, for 05-07
notes hrwage05_adj: Not available 2008-on b/c no continuous weeks worked variable
notes hrwage05_adj: Uses adjust to adjust to constant calendar year $
notes hrwage05_adj: ACS: Derived: WAGP WKW WKHP, ADJUST (2005-2007),
  
/* Income from self-employment */

if 2005<=`year' & `year'<=2018 {
gen incp_se_adj=round(semp*adj,1) if semp~=.
replace incp_se_adj=. if semp==0
}
lab var incp_se_adj "Income from self-employment adj"
notes incp_se_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_se_adj: 2005-2008 Rounded and Bottom/Top Code according to/*
*/ nominal INCP_SE:-9999/999999
notes incp_se_adj: 2009-on Rounded and Bottom/Top Code according to/*
*/ nominal INCP_SE:-10000/999999
notes incp_se_adj: Data dictionaries for 2005-2017 state that values of 1  /*
*/ indicate "$1 or break even". However, due to rounding rules, this value was  /*
*/ never included in the microdata files.
notes incp_se_adj: ACS: SEMP, ADJUST (2005-2007), ADJINC (2008-present)

/* Income from public assistance */

if 2005<=`year' & `year'<=2018 {
gen incp_paw_adj=round(pap*adj,1) if pap~=.
replace incp_paw_adj=. if pap==0
}
lab var incp_paw_adj "Public assistance income adj"
notes incp_paw_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_paw_adj: Rounded and Top-coded according to /*
*/ nominal INCP_PAW: 99999 (2005-2016) or nominal INCP_PAW: 30000 (2017-present)
notes incp_paw_adj: ACS: PAP, ADJUST (2005-2007), ADJINC (2008-present)

/* Income from social security */

if 2005<=`year' & `year'<=2018 {
gen incp_ss_adj=round(ssp*adj,1) if ssp~=.
replace incp_ss_adj=. if ssp==0
}
lab var incp_ss_adj "Social Security Income adj"
notes incp_ss_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_ss_adj: Rounded and Top-coded according to /*
*/ nominal INCP_SS: $99999 (2005-2016), $50000 (2017-2018)
notes incp_ss_adj: ACS: SSP, ADJUST (2005-2007), ADJINC (2008-present)

/* Income from supplemental security */

if 2005<=`year' & `year'<=2018 {
gen incp_ssi_adj=round(ssip*adj,1) if ssip~=.
replace incp_ssi_adj=. if ssip==0
}
lab var incp_ssi_adj "Supplementary Security Income adj"
notes incp_ssi_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_ssi_adj: Rounded and Top-coded according to /*
*/ nominal INCP_SSI: $99999 (2005-2016), $30000 (2017-2018)
notes incp_ssi_adj: ACS: SSIP, ADJUST (2005-2007), ADJINC (2008-present)

/* Income from retirement funds */

if 2005<=`year' & `year'<=2018 {
gen incp_ret_adj=round(retp*adj,1) if retp~=.
replace incp_ret_adj=. if retp==0
}
lab var incp_ret_adj "Retirement income adj"
notes incp_ret_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_ret_adj: Rounded and Top-coded according to nominal INCP_RET: $999999
notes incp_ret_adj: ACS: RETP, ADJUST (2005-2007), ADJINC (2008-present)


/* Income from interest, dividends, and net rentals */

if 2005<=`year' & `year'<=2018 {
gen incp_int_adj=round(intp*adj,1) if intp~=.
replace incp_int_adj=. if intp==0
}
lab var incp_int_adj "Income from int, div, net rentals adj"
notes incp_int_adj: Rounded and Bottom/Top Code according to /*
*/ nominal INCP_INT:-9999/999999 (2005-2016), -10000/999999 (2017-2018)
notes incp_int_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_int_adj: Data dictionaries for 2005-2017 state that values of 1  /*
*/ indicate "$1 or break even". However, due to rounding rules, this value was  /*
*/ never included in the microdata files.
notes incp_int_adj: ACS: INTP, ADJUST (2005-2007), ADJINC (2008-present)

/* Income from other sources */

if 2005<=`year' & `year'<=2018 {
gen incp_oth_adj=round(oip*adj,1) if oip~=.
replace incp_oth_adj=. if oip==0
}
lab var incp_oth_adj "All other income adj"
notes incp_oth_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_oth_adj: Rounded and Top-coded according to nominal INCP_OTH: 999999
notes incp_oth_adj: ACS: OIP, ADJUST (2005-2007), ADJINC (2008-present)

/* Unearned income

Note: Sum of variables above */

if 2005<=`year' & `year'<=2018 {
egen incp_uer_adj=rsum(incp_paw_adj incp_ss_adj incp_ssi_adj incp_ret_adj/*
*/ incp_int_adj incp_oth_adj)
}
lab var incp_uer_adj "Income from all unearned sources adj"
notes incp_uer_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incp_uer_adj: ACS: Derived: PAP SSP SSIP RETP INTP OIP,/*
*/ ADJUST (2005-2007), ADJINC (2008-present)

			/******** Family Level ********/

/* Total income, including unearned income */

if 2005<=`year' & `year'<=2018 {
gen incf_all_adj=round(fincp*adj,1) if fincp~=.
replace incf_all_adj=. if fincp==0
}
lab var incf_all_adj "Total family income adj"
notes incf_all_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes incf_all_adj: 2005-2010 Rounded and Bottom/Top coded according to/*
*/ nominal INCF_ALL: $-59999/$99999999
notes incf_all_adj: 2011-on Rounded and Bottom/Top coded according to /*
*/ nominal INCF_ALL: -59999/999999999
notes incf_all_adj: Data dictionaries for 2005-2017 state that values of 1  /*
*/ indicate "$1 or break even". However, due to rounding rules, this value was  /*
*/ never included in the microdata files.
notes incf_all_adj: ACS: FINCP, ADJUST (2005-2007), ADJINC (2008-present)

			/******** Household Level ********/

/* Total income, including unearned income */

if 2005<=`year' & `year'<=2018 {
gen inch_all_adj=round(hincp*adj,1) if hincp~=.
replace inch_all_adj=. if hincp==0
}
lab var inch_all_adj "Total household income adj"
notes inch_all_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes inch_all_adj: 2005-2010 Rounded and Bottom/Top coded according to/*
*/ nominal INCH_ALL: $-59999/$99999999
notes inch_all_adj: 2011-on Rounded and Bottom/Top coded according to/*
*/ nominal INCH_ALL: $-59999/$999999999
notes inch_all_adj: Data dictionaries for 2005-2017 state that values of 1  /*
*/ indicate "$1 or break even". However, due to rounding rules, this value was  /*
*/ never included in the microdata files.
notes inch_all_adj: ACS: HINCP, ADJUST (2005-2007), ADJINC (2008-present)

/* Food stamp amount */

if 2005<=`year' & `year'<=2007 {
gen inch_fs_adj=round(fs*adj,1) if fs~=.
replace inch_fs_adj=. if fs==0
}
if 2008<=`year' & `year'<=2018 {
gen inch_fs_adj=.
}
lab var inch_fs_adj "Food stamp amount, yearly adj"
notes inch_fs_adj: only available 2005-2007
notes inch_fs_adj: Top-coded according to nominal INCH_FS: 99999
notes inch_fs_adj: Uses adjust or adjinc to adjust to constant calendar year $
notes inch_fs_adj: ACS: FS, ADJUST (2005-2007)

/* Food stamp recipiency */

if 2005<=`year' & `year'<=2007 {
gen byte foodst=.
replace foodst=0 if fs==0
replace foodst=1 if 1<=fs & fs<=99999
}
if 2008<=`year' & `year'<=2018 {
gen byte foodst=0 if fs~=.
replace foodst=1 if fs==1
}
lab var foodst "Food stamp recipiency"
lab val foodst noyes
notes foodst: ACS: FS

/*
Copyright 2020 CEPR, John Schmitt, Hye Jin Rho, Janelle Jones, Cherrie Bucknor,
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

