set more 1

/*
File:	cepr_acs_migrate.do
Date:	Aug 9, 2011
	Oct 30, 2012 
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent migration variables for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Mobility status (lived here 1 year ago) */

if 2005<=`year' & `year'<=2018 {
replace mig=. if mig<1
replace mig=. if 3<mig
}
lab def mig	1 "Yes, same house (nonmovers)" ///
		2 "No, outside of US and Puerto Rico" ///
		3 "No, different house in US or Puerto Rico"
lab var mig "Mobility status (lived here 1 year ago)"
lab val mig mig
notes mig: ACS: MIG

/* Mover */

if 2005<=`year' & `year'<=2018 {
gen byte mover=.
replace mover=1 if (mig==2 | mig==3)
replace mover=0 if mig==1
}
lab var mover "Moved since last year"
lab val mover noyes
notes mover: ACS: Derived: MIG

/* Migration */


/* State (residence one year ago) */

if 2005<=`year' & `year'<=2011 {
replace migsp=. if migsp<1
replace migsp=. if 554<migsp
}
#delimit;
lab def migsp
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
96 "US Island Areas, n.s."
109 "France"
110 "Germany"
111 "Northern Europe, n.s."
112 "Western Europe, n.s."
113 "Eastern Europe, n.s."
120 "Italy"
128 "Poland"
138 "United Kingdom, excluding England"
139 "England"
163 "Russia"
164 "Ukraine"
169 "Other Europe, n.s."
207 "China, Hong Kong & Paracel Islands"
210 "India"
213 "Iraq"
214 "Israel"
215 "Japan"
217 "Korea"
233 "Philippines"
240 "Taiwan"
242 "Thailand"
247 "Vietnam"
251 "Eastern Asia, n.s."
252 "Western Asia, n.s."
253 "South Central Asia or Asia, n.s."
301 "Canada"
303 "Mexico"
312 "El Salvador"
313 "Guatemala"
314 "Honduras"
317 "Central America, n.s."
327 "Cuba"
329 "Dominican Republic"
333 "Jamaica"
344 "Caribbean & North America, n.s."
362 "Brazil"
364 "Colombia"
370 "Peru"
374 "South America, n.s."
462 "Africa"
463 "Eastern Africa, n.s."
464 "Northern Africa, n.s."
467 "Western Africa, n.s."
468 "Other Africa, n.s."
501 "Australia"
554 "Australian & New Zealand Subregions, n.s., Oceania & at Sea"
;
#delimit cr
lab var migsp "Migration recode (2005-2011)"
lab val migsp migsp
notes migsp: ACS: MIGSP
notes migsp: Available 2005-2011


if 2005<=`year' & `year'<=2011 {
gen byte migsp12=.
}
if 2012<=`year' & `year'<=2016 {
replace migsp=. if migsp<1
replace migsp=. if 555<migsp
rename migsp migsp12
#delimit;
lab def migsp12
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
109 "France"
110 "Germany"
111 "Northern Europe, n.s."
112 "Western Europe, n.s."
113 "Eastern Europe, n.s."
120 "Italy"
134 "Spain"
138 "United Kingdom, excluding England"
139 "England"
163 "Russia"
200 "Afghanistan"
207 "China, Hong Kong, Macau & Paracel Islands"
210 "India"
213 "Iraq"
215 "Japan"
217 "Korea"
233 "Philippines"
235 "Saudi Arabia"
240 "Taiwan"
242 "Thailand"
247 "Vietnam"
251 "Eastern Asia, n.s."
252 "Western Asia, n.s."
253 "South Central Asia or Asia, n.s."
301 "Canada"
303 "Mexico"
312 "El Salvador"
313 "Guatemala"
314 "Honduras"
317 "Central America, n.s."
327 "Cuba"
329 "Dominican Republic"
332 "Haiti"
333 "Jamaica"
344 "Caribbean & North America, n.s."
362 "Brazil"
364 "Colombia"
374 "South America, n.s."
414 "Egypt"
440 "Nigeria"
463 "Eastern Africa, n.s."
467 "Western Africa, n.s."
468 "Other Africa, n.s."
501 "Australia"
555 "Other US Island Areas, Oceania, n.s. & at Sea"
;
#delimit cr
lab var migsp12 "Migration recode (2012-2016)"
lab val migsp12 migsp12
notes migsp12: ACS: MIGSP
notes migsp12: Available 2012-2016
}

if 2012<=`year' & `year'<=2016 {
gen byte migsp=.
} 

if 2005<=`year' & `year'<=2016 {
gen byte migsp17=.
}


if 2017<=`year' & `year'<=2018 {
replace migsp=. if migsp<1
replace migsp=. if 555<migsp
rename migsp migsp17
#delimit;
lab def migsp17
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
109 "France"
110 "Germany"
111 "Northern Europe, n.s."
112 "Western Europe, n.s."
113 "Eastern Europe, n.s."
120 "Italy"
134 "Spain"
138 "United Kingdom, excluding England"
139 "England"
163 "Russia"
164 "Ukraine"
200 "Afghanistan"
207 "China, Hong Kong, Macau & Paracel Islands"
210 "India"
213 "Iraq"
215 "Japan"
217 "Korea"
233 "Philippines"
235 "Saudi Arabia"
240 "Taiwan"
242 "Thailand"
245 "United Arab Emirates"
247 "Vietnam"
251 "Eastern Asia, n.s."
252 "Western Asia, n.s."
253 "South Central Asia or Asia, n.s."
301 "Canada"
303 "Mexico"
312 "El Salvador"
313 "Guatemala"
314 "Honduras"
317 "Central America, n.s."
327 "Cuba"
329 "Dominican Republic"
332 "Haiti"
333 "Jamaica"
344 "Caribbean & North America, n.s."
362 "Brazil"
364 "Colombia"
365 "Ecuador"
370 "Peru"
373 "Venezuela"
374 "South America, n.s."
414 "Egypt"
416 "Ethiopia"
427 "Kenya"
440 "Nigeria"
467 "Western Africa, n.s."
468 "Other Africa, n.s."
469 "Eastern Africa, n.s."
501 "Australia"
555 "Other US Island Areas, Oceania, n.s. & at Sea"
;
#delimit cr
lab var migsp17 "Migration recode (2017-2018)"
lab val migsp17 migsp17
notes migsp17: ACS: MIGSP
notes migsp17: Available 2017-present
}

if 2017<=`year' & `year'<=2018 {
gen byte migsp=.
gen byte migsp12=.
}

/* PUMA (residence one year ago) */

if 2005<=`year' & `year'<=2011 {
gen migpuma00=migpuma if migpuma~=.
replace migpuma00=. if migpuma<1
replace migpuma00=. if 8200<migpuma
}
if 2012<=`year' & `year'<=2018 {
gen migpuma00=.
}
lab var migpuma00 "Migration PUMA (2000 census boundaries)"
lab val migpuma00 migpuma00
notes migpuma00: ACS: MIGPUMA
notes migpuma00: Use with migsp
notes migpuma00: Boundaries for 2005-2011 are based on 2000 Census definition


if 2005<=`year' & `year'<=2011 {
gen migpuma10=.
}
if 2012<=`year' & `year'<=2018 {
gen migpuma10=migpuma if migpuma~=.
replace migpuma10=. if migpuma<1
replace migpuma10=. if 70100<migpuma
}
lab var migpuma10 "Migration PUMA (2010 census boundaries)"
lab val migpuma10 migpuma10
notes migpuma10: ACS: MIGPUMA
notes migpuma10: Use with migsp12 (2012-2016) or migsp17 (2017-2018)
notes migpuma10: Boundaries for 2012-2018 are based on 2010 Census definition
notes migpuma10: 2010 Migration PUMAs and Place of Work PUMAs are identical, so /*
*/  their relationships to PUMAs (place of residence) are the same


/* Mobility Status, imputed */

if 2005<=`year' & `year'<=2018 {
replace fmigp=. if fmigp<0 | 1<fmigp
}
lab var fmigp "Mobility status allocation flag"
lab val fmigp noyes
notes fmigp: ACS: FMIGP

/* Migration, imputed */

if 2005<=`year' & `year'<=2018 {
replace fmigsp=. if fmigsp<0 | 1<fmigsp
}
lab var fmigsp "Migration state allocation flag"
lab val fmigsp noyes
notes fmigsp: ACS: FMIGSP

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
