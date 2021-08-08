set more 1

/*
File:	cepr_acs_health.do
Date:	Aug 5, 2011
	Oct 31, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent health insurance variables for CEPR extract of 
       American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Health insurance (binary) */

gen byte hins=.

if 2008<=`year' & `year'<=2018 {
replace hins=1 if hicov==1 
replace hins=0 if hicov==2 
}
lab var hins "Health insurance (binary)"
lab val hins noyes
notes hins: ACS: HICOV
notes hins: Available 2008-on only

/* Health insurance, private */

gen byte hipriv=.

if 2008<=`year' & `year'<=2018 {
replace hipriv=1 if privcov==1
replace hipriv=0 if privcov==2
}
lab var hipriv "Health insurance, private"
lab val hipriv noyes
notes hipriv: both employer-provided and privately purchased
notes hipriv: ACS: PRIVCOV
notes hipriv: Available 2008-on only

/* Health insurance provided by current/former employers or union */

gen byte hiep=.

if 2008<=`year' & `year'<=2018 {
replace hiep=1 if hins1==1
replace hiep=0 if hins1==2
}
lab var hiep "Health insurance, current or former employer/union"
lab val hiep noyes
notes hiep: ACS: HINS1
notes hiep: Available 2008-on only

/* Health insurance, purchased directly */

gen byte hipind=.

if 2008<=`year' & `year'<=2018 {
replace hipind=1 if hins2==1
replace hipind=0 if hins2==2
}
lab var hipind "Health insurance, purchased directly"
lab val hipind noyes
notes hipind: ACS: HINS2
notes hipind: Available 2008-on only

	/* Health insurance, public */

/* Covered by Medicaid */

gen byte himcaid=.

if 2008<=`year' & `year'<=2018 {
replace himcaid=1 if hins4==1
replace himcaid=0 if hins4==2
}
lab var himcaid "Medicaid"
lab val himcaid noyes
notes himcaid: ACS: HINS4
notes himcaid: Available 2008-on only

/* Covered by Medicare */

gen himcare=.

if 2008<=`year' & `year'<=2018 {
replace himcare=1 if hins3==1
replace himcare=0 if hins3==2
}
lab var himcare "Medicare"
lab val himcare noyes
notes himcare: ACS: HINS3
notes himcare: Available 2008-on only

/* Covered by TRICARE or VA */

gen hiothpub=.

if 2008<=`year' & `year'<=2018 {
replace hiothpub=1 if hins5==1 | hins6==1
replace hiothpub=0 if (hins5==2 & hins6==2)
}
lab var hiothpub "TRICARE or military"
lab val hiothpub noyes
notes hiothpub: ACS: HINS5 HINS6
notes hiothpub: Available 2008-on only

/* Covered by VA */

gen byte hiva=.

if 2008<=`year' & `year'<=2018 {
replace hiva=1 if hins6==1
replace hiva=0 if hins6==2
}
lab var hiva "VA"
lab val hiva noyes
notes hiva: Including those ever used or enrolled in VA
notes hiva: ACS: HINS6
notes hiva: Available 2008-on only

/* Covered by Indian Health Service */

gen byte hiihs=.

if 2008<=`year' & `year'<=2018 {
replace hiihs=1 if hins7==1
replace hiihs=0 if hins7==2
}
lab var hiihs "Indian Health Service"
lab val hiihs noyes
notes hiihs: ACS: HINS7
notes hiihs: Available 2008-on only

/* Total Public */

gen byte hipub=.

if 2008<=`year' & `year'<=2018 {
replace hipub=1 if pubcov==1
replace hipub=0 if pubcov==2
}
lab var hipub "Health insurance, public"
lab val hipub noyes
notes hipub: ACS: PUBCOV
notes hipub: Available 2008-on only


	/* Health Insurance, Flags for Imputated Values */
	
/* Health insurance coverage, imputed */

gen byte hins_imputed=.

if 2014<=`year' & `year'<=2018 {
replace hins_imputed=1 if fhicovp==1
replace hins_imputed=0 if fhicovp==0
}
lab var hins_imputed "HI coverage, imputed"
lab val hins_imputed noyes
notes hins_imputed: ACS FHICOVP
notes hins_imputed: Available 2014-present only

/* Health insurance, provided by employers, imputed */

gen byte hiep_imputed=.

if 2008<=`year' & `year'<=2018 {
replace hiep_imputed=1 if fhins1p==1
replace hiep_imputed=0 if fhins1p==0
}
lab var hiep_imputed "HI, current or former employer/union, imputed"
lab val hiep_imputed noyes
notes hiep_imputed: ACS: FHINS1P
notes hiep_imputed: Available 2008-on only

/* Health insurance, purchased directly, imputed */

gen byte hipind_imputed=.

if 2008<=`year' & `year'<=2018 {
replace hipind_imputed=1 if fhins2p==1
replace hipind_imputed=0 if fhins2p==0
}
lab var hipind_imputed "HI, purchased directly, imputed"
lab val hipind_imputed noyes
notes hipind_imputed: ACS: FHINS2P
notes hipind_imputed: Available 2008-on only

/* Health insurance, Medicaid, imputed */

gen byte himcaid_imputed=.

if 2008<=`year' & `year'<=2018 {
replace himcaid_imputed=1 if fhins4p==1
replace himcaid_imputed=0 if fhins4p==0
}
lab var himcaid_imputed "HI, Medicaid, imputed"
lab val himcaid_imputed noyes
notes himcaid_imputed: ACS: FHINS4P
notes himcaid_imputed: Available 2008-on only

/* Health insurance, Medicare, imputed */

gen byte himcare_imputed=.

if 2008<=`year' & `year'<=2018 {
replace himcare_imputed=1 if fhins3p==1
replace himcare_imputed=0 if fhins3p==0
}
lab var himcare_imputed "HI, Medicare, imputed"
lab val himcare_imputed noyes
notes himcare_imputed: ACS: FHINS3P
notes himcare_imputed: Available 2008-on only

/* Health insurance, TRICARE or VA, imputed */

gen byte hiothpub_imputed=.

if 2008<=`year' & `year'<=2018 { 
replace hiothpub_imputed=1 if fhins5p==1 | fhins6p==1
replace hiothpub_imputed=0 if (fhins5p==0 & fhins6p==0)
}
lab var hiothpub_imputed "HI, TRICARE or military, imputed"
lab val hiothpub_imputed noyes
notes hiothpub_imputed: ACS: FHINS5P FHINS6P
notes hiothpub_imputed: Available 2008-on only

/* Health insurance, VA, imputed */

gen byte hiva_imputed=.

if 2008<=`year' & `year'<=2018 {
replace hiva_imputed=1 if fhins6p==1
replace hiva_imputed=0 if fhins6p==0
}
lab var hiva_imputed "HI, VA, imputed"
lab val hiva_imputed noyes
notes hiva_imputed: ACS: FHINS6P
notes hiva_imputed: Available 2008-on only

/* Health insurance, Indian Health Service, imputed*/

gen byte hiihs_imputed=.

if 2008<=`year' & `year'<=2018 {
replace hiihs_imputed=1 if fhins7p==1
replace hiihs_imputed=0 if fhins7p==0
}
lab var hiihs_imputed "HI, Indian Health Service, imputed"
lab val hiihs_imputed noyes
notes hiihs_imputed: ACS: FHINS7P
notes hiihs_imputed: Available 2008-on only

/* Health insurance, total public, imputed */

gen byte hipub_imputed=.

if 2008<=`year' & `year'<=2018 {
tempvar thesum
egen `thesum'= rsum(himcare_imputed himcaid_imputed hiothpub_imputed /*
*/hiva_imputed hiihs_imputed hins_imputed)
replace hipub_imputed=1 if 1<=`thesum' & `thesum'~=.
replace hipub_imputed=0 if `thesum'==0
}
lab var hipub_imputed "HI, public, imputed"
lab val hipub_imputed noyes
notes hipub_imputed: ACS: FHINS3P FHINS5P FHINS4P FHINS6P
notes hipub_imputed: Available 2008-on only

/* Health insurance, total private, imputed */

gen byte hipriv_imputed=.

if 2008<=`year' & `year'<=2018 {
tempvar TheSum
egen `TheSum'=rsum(hiep_imputed hipind_imputed)
replace hipriv_imputed=1 if 1<=`TheSum' & `TheSum'~=.
replace hipriv_imputed=0 if `TheSum'==0
}
lab var hipriv_imputed "HI, private, imputed"
lab val hipriv_imputed noyes
notes hipriv_imputed: ACS: FHINS1P FHINS2P
notes hipriv_imputed: Available 2008-on only


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

