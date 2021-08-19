set more 1

/*
File:	cepr_acs_disability.do
Date:	Aug 5, 2011
	Oct 30, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent disability variables for CEPR extract of American Community Survey  
*/

/* Determine survey year */

local year=year in 1

/* Disability recode */

if 2005<=`year' & `year'<=2007 {
gen byte dis=ds
replace dis=. if dis<1
replace dis=. if 2<dis
replace dis=0 if ds==2
}
if 2008<=`year' & `year'<=2018 {
replace dis=. if dis<1
replace dis=. if 2<dis
replace dis=0 if dis==2
}
lab var dis "With a disability"
lab val dis noyes
notes dis: ACS: DS for 2005-2007
notes dis: ACS: DIS for 2008-on

/* Self-care difficulty */

gen byte dself=.

if 2008<=`year' & `year'<=2018 {
replace dself=1 if ddrs==1
replace dself=0 if ddrs==2
}
lab var dself "Self-care difficulty"
lab val dself noyes
notes dself: ACS: DDRS
notes dself: Available 2008-on only

/* Hearing difficulty */

gen byte dhear=.

if 2008<=`year' & `year'<=2018 {
replace dhear=1 if dear==1
replace dhear=0 if dear==2
}
lab var dhear "Hearing difficulty"
lab val dhear noyes
notes dhear: ACS: DEAR
notes dhear: Available 2008-on only

/* Vision difficulty */

gen byte dvis=.

if 2008<=`year' & `year'<=2018 {
replace dvis=1 if deye==1
replace dvis=0 if deye==2
}
lab var dvis "Vision difficulty"
lab val dvis noyes
notes dvis: ACS: DEYE
notes dvis: Available 2008-on only

/* Independent living difficulty */

gen byte dind=.

if 2008<=`year' & `year'<=2018 {
replace dind=1 if dout==1
replace dind=0 if dout==2
}
lab var dind "Independent living difficulty"
lab val dind noyes
notes dind: ACS: DOUT
notes dind: Available 2008-on only

/* Ambulatory difficulty */ 

gen byte damb=.

if 2008<=`year' & `year'<=2018 {
replace damb=1 if dphy==1
replace damb=0 if dphy==2
}
lab var damb "Ambulatory difficulty"
lab val damb noyes
notes damb: ACS: DPHY
notes damb: Available 2008-on only

/* Cognitive difficulty */

gen byte dcog=.

if 2008<=`year' & `year'<=2018 {
replace dcog=1 if drem==1
replace dcog=0 if drem==2
}
lab var dcog "Cognitive difficulty"
lab val dcog noyes
notes dcog: ACS: DREM
notes dcog: Available 2008-on only

/* Veteran Service Disability Rating */

if 2005<=`year' & `year'<=2007 {
gen byte drat=.
}
if 2008<=`year' & `year'<=2018 {
replace drat=. if drat<1
replace drat=. if 5<drat
}
lab def drat	1 "O percent" ///
		2 "10 or 20 percent" ///
		3 "30 or 40 percent" ///
		4 "50 or 60 percent" ///
		5 "70, 80, 90, or 100 percent"
lab var drat "Veteran Service Disability Rating"
lab val drat drat
notes drat: ACS: DRAT
notes drat: Available 2008-on only

	/*Disability variables for 2005-2007*/

/* Difficulty dressing */

if 2005<=`year' & `year'<=2007 {
gen byte ddrs05=.
replace ddrs05=1 if ddrs==1
replace ddrs05=0 if ddrs==2
}
if 2008<=`year' & `year'<=2018 {
gen byte ddrs05=.
}
lab var ddrs05 "Difficulty dressing"
lab val ddrs05 noyes
notes ddrs05: ACS: DDRS for 2005-2007

/* Vision or hearing difficulty */

if 2005<=`year' & `year'<=2007 {
gen byte deye05=.
replace deye05=1 if deye==1
replace deye05=0 if deye==2
}
if 2008<=`year' & `year'<=2018 {
gen byte deye05=.
}
lab var deye05 "Vision or hearing difficulty"
lab val deye05 noyes
notes deye05: ACS: DEYE for 2005-2007

/* Difficulty going out */

if 2005<=`year' & `year'<=2007 {
gen byte dout05=.
replace dout05=1 if dout==1
replace dout05=0 if dout==2
}
if 2008<=`year' & `year'<=2018 {
gen byte dout05=.
}
lab var dout05 "Difficulty going out"
lab val dout05 noyes
notes dout05: ACS: DOUT for 2005-2007

/* Physical difficulty */

if 2005<=`year' & `year'<=2007 {
gen byte dphy05=.
replace dphy05=1 if dphy==1
replace dphy05=0 if dphy==2
}
if 2008<=`year' & `year'<=2018 {
gen byte dphy05=.
}
lab var dphy05 "Physical difficulty"
lab val dphy05 noyes
notes dphy05: ACS: DPHY for 2005-2007

/* Difficulty remembering */

if 2005<=`year' & `year'<=2007 {
gen byte drem05=.
replace drem05=1 if drem==1
replace drem05=0 if drem==2
}
if 2008<=`year' & `year'<=2018 {
gen byte drem05=.
}
lab var drem05 "Difficulty remembering"
lab val drem05 noyes
notes drem05: ACS: DREM for 2005=2007

/* Difficulty working */

if 2005<=`year' & `year'<=2007 {
gen byte dwrk05=.
replace dwrk05=1 if dwrk==1
replace dwrk05=0 if dwrk==2
}
if 2008<=`year' & `year'<=2018 {
gen byte dwrk05=.
}
lab var dwrk05 "Difficulty working"
lab val dwrk05 noyes
notes dwrk05: ACS: DWRK for 2005-2007

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
