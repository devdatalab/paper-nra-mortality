set more 1

/*
File:	cepr_acs_geog.do
Date:	Jan 31, 2011
	Aug 3, 2011
	Oct 26, 2012
	Dec 20, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent geographical variables for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Region */

if 2005<=`year' & `year'<=2018 { 
replace region=. if region<1
replace region=. if 9<region
/* drop if region==9 /* excluding Puerto Rico from sample */ */
}
lab def region 1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 9 "Puerto Rico"
lab val region region
notes region: Option 9 added in 2011, but dropped in extract
notes region: ACS: REGION

/* Division */

if 2005<=`year' & `year'<=2018 { 
replace division=. if division<0
replace division=. if 9<division
/* drop if division==0 /* excluding Puerto Rico from sample */ */
}
lab var division "Division"
lab def div 0 "Puerto Rico" 1 "New England" 2 "Middle Atlantic" 3 "East North Central" ///
4 "West North Central" 5 "South Atlantic" 6 "East South Central" ///
7 "West South Central" 8 "Mountain West" 9 "Pacific"
lab val division division
notes division: ACS: DIVISION

/* State (residence) */

rename st state
if 2005<=`year' & `year'<=2018 {
replace state=. if state<1
replace state=. if 72<state
/*drop if state==72 /* excluding Puerto Rico from sample */ */
} 
lab var state "State (residence)"
#delimit ;
lab def state
1 "Alabama"
2 "Alaska"
4 "Arizona"
5 "Arkansas"
6 "California"
8 "Colorado"
9 "Connecticut"
10 "Delaware"
11 "District of Columbia"
12 "Florida"
13 "Georgia"
15 "Hawaii"
16 "Idaho"
17 "Illinois"
18 "Indiana"
19 "Iowa"
20 "Kansas"
21 "Kentucky"
22 "Louisiana"
23 "Maine"
24 "Maryland"
25 "Massachusetts"
26 "Michigan"
27 "Minnesota"
28 "Mississippi"
29 "Missouri"
30 "Montana"
31 "Nebraska"
32 "Nevada"
33 "New Hampshire"
34 "New Jersey"
35 "New Mexico"
36 "New York"
37 "North Carolina"
38 "North Dakota"
39 "Ohio"
40 "Oklahoma"
41 "Oregon"
42 "Pennsylvania"
44 "Rhode Island"
45 "South Carolina"
46 "South Dakota"
47 "Tennessee"
48 "Texas"
49 "Utah"
50 "Vermont"
51 "Virginia"
53 "Washington"
54 "West Virginia"
55 "Wisconsin"
56 "Wyoming"
72 "Puerto Rico"
;
#delimit cr
lab val state state
notes state: ACS: ST


/* PUMA (residence) */

if 2005<=`year' & `year'<=2011 {
gen puma00=puma if puma~=.
}
if 2012<=`year' & `year'<=2018 {
gen puma00=.
}
lab var puma00 "PUMA (2000 census boundaries)"
notes puma00: Public use microdata area
notes puma00: Designates area of 100,000 or more population
notes puma00: Use with variable state for unique code	
notes puma00: Boundaries for 2005-2011 are based on 2000 Census delineations

if 2005<=`year' & `year'<=2011 {
gen puma10=.
}
if 2012<=`year' & `year'<=2018 {
gen puma10=puma if puma~=.
}
lab var puma10 "PUMA (2010 census boundaries)"
notes puma10: Public use microdata area
notes puma10: Designates area of 100,000 or more population
notes puma10: Use with variable state for unique code	
notes puma10: Boundaries for 2012-2018 are based on 2010 Census delineations

/* 
Additional geographic variables describing place of work (POW) 
and residence one year ago are located in cepr_acs_empstat.do and 
cepr_acs_migrate.do, respectively. 

cepr_acs_geog.do previously included variables pertaining to work commutes. 
Those variables have been moved to cepr_acs_empstat.do. 
*/



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
