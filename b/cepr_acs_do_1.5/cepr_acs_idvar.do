set more 1

/*
File:	cepr_acs_idvar.do
Date:	Jan 31, 2011
	Aug 4, 2011
	Oct 26, 2012
	Dec 20, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent household and personal identifiers and weights
	  for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Household ID */


lab var serialno "Household ID"
notes serialno: Unique household identifier
notes serialno: ACS: SERIALNO

/* Person Number */

if 2005<=`year' & `year'<=2018 {
replace sporder=. if sporder<1 | 20<sporder
}

lab var sporder "Person Number"
notes sporder: ACS: SPORDER

/* Response mode */

if 2005<=`year' & `year'<=2012 {
replace resmode=. if resmode<1 | 2<resmode
}
if 2013<=`year' & `year'<=2018 { /* 3rd category added */
replace resmode=. if resmode<1 | 3<resmode
}

lab var resmode "Response mode"
lab def resmode 1 "Mail" 2 "CATI/CAPI" 3 "Internet"
lab val resmode resmode
notes resmode: ACS: RESMODE
notes resmode: Internet added in 2013

/* Weights */

	/* Housing weight */

if 2005<=`year' & `year'<=2018 {
rename wgtp hsgwgt
}

lab var hsgwgt "Housing weight"
notes hsgwgt: Integer weight of housing unit
notes hsgwgt: ACS: WGTP

	/* Household level replicate weights */

lab var wgtp1 "Housing weight replicate 1"
lab var wgtp2 "Housing weight replicate 2"
lab var wgtp3	"Housing weight replicate 3"
lab var wgtp4	"Housing weight replicate 4"
lab var wgtp5	"Housing weight replicate 5"
lab var wgtp6	"Housing weight replicate 6"
lab var wgtp7	"Housing weight replicate 7"
lab var wgtp8	"Housing weight replicate 8"
lab var wgtp9	"Housing weight replicate 9"
lab var wgtp10	"Housing weight replicate 10"
lab var wgtp11	"Housing weight replicate 11"
lab var wgtp12	"Housing weight replicate 12"
lab var wgtp13	"Housing weight replicate 13"
lab var wgtp14	"Housing weight replicate 14"
lab var wgtp15	"Housing weight replicate 15"
lab var wgtp16	"Housing weight replicate 16"
lab var wgtp17	"Housing weight replicate 17"
lab var wgtp18	"Housing weight replicate 18"
lab var wgtp19	"Housing weight replicate 19"
lab var wgtp20	"Housing weight replicate 20"
lab var wgtp21	"Housing weight replicate 21"
lab var wgtp22	"Housing weight replicate 22"
lab var	wgtp23	"Housing weight replicate 23"
lab var wgtp24	"Housing weight replicate 24"
lab var wgtp25	"Housing weight replicate 25"
lab var wgtp26	"Housing weight replicate 26"
lab var wgtp27	"Housing weight replicate 27"
lab var wgtp28	"Housing weight replicate 28"
lab var wgtp29	"Housing weight replicate 29"
lab var wgtp30	"Housing weight replicate 30"
lab var wgtp31	"Housing weight replicate 31"
lab var wgtp32	"Housing weight replicate 32"
lab var wgtp33	"Housing weight replicate 33"
lab var wgtp34	"Housing weight replicate 34"
lab var wgtp35	"Housing weight replicate 35"
lab var wgtp36	"Housing weight replicate 36"
lab var wgtp37	"Housing weight replicate 37"
lab var wgtp38	"Housing weight replicate 38"
lab var wgtp39	"Housing weight replicate 39"
lab var wgtp40	"Housing weight replicate 40"
lab var wgtp41	"Housing weight replicate 41"
lab var wgtp42	"Housing weight replicate 42"
lab var wgtp43	"Housing weight replicate 43"
lab var wgtp44	"Housing weight replicate 44"
lab var wgtp45	"Housing weight replicate 45"
lab var wgtp46	"Housing weight replicate 46"
lab var wgtp47	"Housing weight replicate 47"
lab var wgtp48	"Housing weight replicate 48"
lab var wgtp49	"Housing weight replicate 49"
lab var wgtp50	"Housing weight replicate 50"
lab var wgtp51	"Housing weight replicate 51"
lab var wgtp52	"Housing weight replicate 52"
lab var wgtp53	"Housing weight replicate 53"
lab var wgtp54	"Housing weight replicate 54"
lab var wgtp55	"Housing weight replicate 55"
lab var wgtp56	"Housing weight replicate 56"
lab var wgtp57	"Housing weight replicate 57"
lab var wgtp58	"Housing weight replicate 58"
lab var wgtp59	"Housing weight replicate 59"
lab var wgtp60	"Housing weight replicate 60"
lab var wgtp61	"Housing weight replicate 61"
lab var wgtp62	"Housing weight replicate 62"
lab var wgtp63	"Housing weight replicate 63"
lab var wgtp64	"Housing weight replicate 64"
lab var wgtp65	"Housing weight replicate 65"
lab var wgtp66	"Housing weight replicate 66"
lab var wgtp67	"Housing weight replicate 67"
lab var wgtp68	"Housing weight replicate 68"
lab var wgtp69	"Housing weight replicate 69"
lab var wgtp70	"Housing weight replicate 70"
lab var wgtp71	"Housing weight replicate 71"
lab var wgtp72	"Housing weight replicate 72"
lab var wgtp73	"Housing weight replicate 73"
lab var wgtp74	"Housing weight replicate 74"
lab var wgtp75	"Housing weight replicate 75"
lab var wgtp76	"Housing weight replicate 76"
lab var wgtp77	"Housing weight replicate 77"
lab var wgtp78	"Housing weight replicate 78"
lab var wgtp79	"Housing weight replicate 79"
lab var wgtp80	"Housing weight replicate 80"

	/* Person weight */

if 2005<=`year' & `year'<=2018 {
rename pwgtp perwgt
}
lab var perwgt "Person weight"
notes perwgt: Integer weight of person
notes perwgt: ACS: PWGTP

	/* Percson level replicate weights */

lab var	pwgtp1	"Person's weight replicate 1"
lab var	pwgtp2	"Person's weight replicate 2"
lab var pwgtp3	"Person's weight replicate 3"
lab var pwgtp4	"Person's weight replicate 4"
lab var pwgtp5	"Person's weight replicate 5"
lab var pwgtp6	"Person's weight replicate 6"
lab var pwgtp7	"Person's weight replicate 7"
lab var pwgtp8	"Person's weight replicate 8"
lab var pwgtp9	"Person's weight replicate 9"
lab var pwgtp10	"Person's weight replicate 10"
lab var pwgtp11	"Person's weight replicate 11"
lab var pwgtp12	"Person's weight replicate 12"
lab var pwgtp13	"Person's weight replicate 13"
lab var pwgtp14	"Person's weight replicate 14"
lab var pwgtp15	"Person's weight replicate 15"
lab var pwgtp16	"Person's weight replicate 16"
lab var pwgtp17	"Person's weight replicate 17"
lab var pwgtp18	"Person's weight replicate 18"
lab var pwgtp19	"Person's weight replicate 19"
lab var pwgtp20	"Person's weight replicate 20"
lab var pwgtp21	"Person's weight replicate 21"
lab var pwgtp22	"Person's weight replicate 22"
lab var	pwgtp23	"Person's weight replicate 23"
lab var pwgtp24	"Person's weight replicate 24"
lab var pwgtp25	"Person's weight replicate 25"
lab var pwgtp26	"Person's weight replicate 26"
lab var pwgtp27	"Person's weight replicate 27"
lab var pwgtp28	"Person's weight replicate 28"
lab var pwgtp29	"Person's weight replicate 29"
lab var pwgtp30	"Person's weight replicate 30"
lab var pwgtp31	"Person's weight replicate 31"
lab var pwgtp32	"Person's weight replicate 32"
lab var pwgtp33	"Person's weight replicate 33"
lab var pwgtp34	"Person's weight replicate 34"
lab var pwgtp35	"Person's weight replicate 35"
lab var pwgtp36	"Person's weight replicate 36"
lab var pwgtp37	"Person's weight replicate 37"
lab var pwgtp38	"Person's weight replicate 38"
lab var pwgtp39	"Person's weight replicate 39"
lab var pwgtp40	"Person's weight replicate 40"
lab var pwgtp41	"Person's weight replicate 41"
lab var pwgtp42	"Person's weight replicate 42"
lab var pwgtp43	"Person's weight replicate 43"
lab var pwgtp44	"Person's weight replicate 44"
lab var pwgtp45	"Person's weight replicate 45"
lab var pwgtp46	"Person's weight replicate 46"
lab var pwgtp47	"Person's weight replicate 47"
lab var pwgtp48	"Person's weight replicate 48"
lab var pwgtp49	"Person's weight replicate 49"
lab var pwgtp50	"Person's weight replicate 50"
lab var pwgtp51	"Person's weight replicate 51"
lab var pwgtp52	"Person's weight replicate 52"
lab var pwgtp53	"Person's weight replicate 53"
lab var pwgtp54	"Person's weight replicate 54"
lab var pwgtp55	"Person's weight replicate 55"
lab var pwgtp56	"Person's weight replicate 56"
lab var pwgtp57	"Person's weight replicate 57"
lab var pwgtp58	"Person's weight replicate 58"
lab var pwgtp59	"Person's weight replicate 59"
lab var pwgtp60	"Person's weight replicate 60"
lab var pwgtp61	"Person's weight replicate 61"
lab var pwgtp62	"Person's weight replicate 62"
lab var pwgtp63	"Person's weight replicate 63"
lab var pwgtp64	"Person's weight replicate 64"
lab var pwgtp65	"Person's weight replicate 65"
lab var pwgtp66	"Person's weight replicate 66"
lab var pwgtp67	"Person's weight replicate 67"
lab var pwgtp68	"Person's weight replicate 68"
lab var pwgtp69	"Person's weight replicate 69"
lab var pwgtp70	"Person's weight replicate 70"
lab var pwgtp71	"Person's weight replicate 71"
lab var pwgtp72	"Person's weight replicate 72"
lab var pwgtp73	"Person's weight replicate 73"
lab var pwgtp74	"Person's weight replicate 74"
lab var pwgtp75	"Person's weight replicate 75"
lab var pwgtp76	"Person's weight replicate 76"
lab var pwgtp77	"Person's weight replicate 77"
lab var pwgtp78	"Person's weight replicate 78"
lab var pwgtp79	"Person's weight replicate 79"
lab var pwgtp80	"Person's weight replicate 80"

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
