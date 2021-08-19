set more 1

/*
File:	cepr_acs_poverty.do
Date:	Aug 9, 2011
	Oct 29, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent poverty variables for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1


/* Percent of poverty status */

if `year'==2014 {
/* povpip is str3 in 2014 */
destring povpip, replace
}
if 2005<=`year' & `year'<=2018 {
replace povpip=. if povpip<0
replace povpip=. if 501<povpip
}
lab var povpip "Percent of poverty status"
notes povpip: Topcode: 501
notes povpip: ACS: POVPIP


/* In poverty (below poverty line) */

if 2005<=`year' & `year'<=2018 {
gen byte poor=0 if povpip~=.
replace poor=1 if 0<=povpip & povpip<100
}
lab var poor "In poverty (below poverty line)"
lab val poor noyes
notes poor: ACS: Derived: POVPIP
notes poor: ACS defines poor as strictly less than 100% poverty line


/* Low-income (<200% poverty line) */

if 2005<=`year' & `year'<=2018 {
gen byte pov200=0 if povpip~=.
replace pov200=1 if 0<=povpip & povpip<200
}
lab var pov200 "Low income (<200% poverty line)"
lab val pov200 noyes
notes pov200: ACS: Derived: POVPIP

/* 
Copyright 2020 CEPR, John Schmitt, Hye Jin Rho, Janelle Jones, Cherrie Bucknor,
Brian Dew, Hayley Brown

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

