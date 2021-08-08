set more 1

/*
File:	cepr_acs_POB09.do
Date:	Aug 16, 2011
	Oct 26, 2012
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Nov 9, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent place of birth variable for 2009-2011.
Note:	See copyright notice at end of program.

	Part the cepr_acs_demog.do */

/* Determine survey year */

local year=year in 1

/* Place of birth, 2009-2011*/

if 2009<=`year' & `year'<=2011 {
replace pobp=. if pobp<1
replace pobp=. if 554<pobp
replace pobp09=pobp
}
lab def pobp09 ///
1 "AL" ///
2 "AK" ///
4 "AZ" ///
5 "AR" ///
6 "CA" ///
8 "CO" ///
9 "CT" ///
10 "DE" ///
11 "DC" ///
12 "FL" ///
13 "GA" ///
15 "HI" ///
16 "ID" ///
17 "IL" ///
18 "IN" ///
19 "IA" ///
20 "KS" ///
21 "KY" ///
22 "LA" ///
23 "ME" ///
24 "MD" ///
25 "MA" ///
26 "MI" ///
27 "MN" ///
28 "MS" ///
29 "MO" ///
30 "MT" ///
31 "NE" ///
32 "NV" ///
33 "NH" ///
34 "NJ" ///
35 "NM" ///
36 "NY" ///
37 "NC" ///
38 "ND" ///
39 "OH" ///
40 "OK" ///
41 "OR" ///
42 "PA" ///
44 "RI" ///
45 "SC" ///
46 "SD" ///
47 "TN" ///
48 "TX" ///
49 "UT" ///
50 "VT" ///
51 "VA" ///
53 "WA" ///
54 "WV" ///
55 "WI" ///
56 "WY" ///
72 "PR" ///
78 "US Virgin Islands" ///
100 "Albania" ///
102 "Austria" ///
103 "Belgium" ///
104 "Bulgaria" ///
105 "Czechoslovakia" ///
106 "Denmark" ///
108 "Finland" ///
109 "France" ///
110 "Germany" ///
116 "Greece" ///
117 "Hungary" ///
118 "Iceland" ///
119 "Ireland" ///
120 "Italy" ///
126 "Netherlands" ///
127 "Norway" ///
128 "Poland" ///
129 "Portugal" ///
130 "Azores Islands" ///
132 "Romania" ///
134 "Spain" ///
136 "Sweden" ///
137 "Switzerland" ///
138 "United Kingdom, n.s." ///
139 "England" ///
140 "Scotland" ///
142 "Northern Ireland" ///
147 "Yugoslavia" ///
148 "Czech Republic" ///
149 "Slovakia" ///
150 "Bosnia and Herzegovina" ///
151 "Croatia" ///
152 "Macedonia" ///
155 "Estonia" ///
156 "Latvia" ///
157 "Lithuania" ///
158 "Armenia" ///
159 "Azerbaijan" ///
160 "Belarus" ///
161 "Georgia" ///
162 "Moldova" ///
163 "Russia" ///
164 "Ukraine" ///
165 "USSR" ///
166 "Europe, n.s." ///
169 "Other Europe, n.s." ///
200 "Afghanistan" ///
202 "Bangladesh" ///
205 "Burma" ///
206 "Cambodia" ///
207 "China" ///
209 "Hong Kong" ///
210 "India" ///
211 "Indonesia" ///
212 "Iran" ///
213 "Iraq" ///
214 "Israel" ///
215 "Japan" ///
216 "Jordan" ///
217 "Korea" ///
218 "Kazakhstan" ///
222 "Kuwait" ///
223 "Laos" ///
224 "Lebanon" ///
226 "Malaysia" ///
229 "Nepal" ///
231 "Pakistan" ///
233 "Philippines" ///
235 "Saudi Arabia" ///
236 "Singapore" ///
238 "Sri Lanka" ///
239 "Syria" ///
240 "Taiwan" ///
242 "Thailand" ///
243 "Turkey" ///
246 "Uzbekistan" ///
247 "Vietnam" ///
248 "Yemen" ///
249 "Asia" ///
251 "Eastern Asia, n.s." ///
253 "Other South Central Asia, n.s." ///
254 "Other Asia, n.s." ///
300 "Bermuda" ///
301 "Canada" ///
303 "Mexico" ///
310 "Belize" ///
311 "Costa Rica" ///
312 "El Salvador" ///
313 "Guatemala" ///
314 "Honduras" ///
315 "Nicaragua" ///
316 "Panama" ///
321 "Antigua & Barbuda" ///
323 "Bahamas" ///
324 "Barbados" ///
327 "Cuba" ///
328 "Dominica" ///
329 "Dominican Republic" ///
330 "Grenada" ///
332 "Haiti" ///
333 "Jamaica" ///
338 "St. Kitts-Nevis" ///
339 "St. Lucia" ///
340 "St. Vincent & the Grenadines" ///
341 "Trinidad & Tobago" ///
343 "West Indies" ///
344 "Caribbean, n.s." ///
360 "Argentina" ///
361 "Bolivia" ///
362 "Brazil" ///
363 "Chile" ///
364 "Colombia" ///
365 "Ecuador" ///
368 "Guyana" ///
369 "Parauay" ///
370 "Peru" ///
372 "Uruguay" ///
373 "Venezuela" ///
374 "South America" ///
399 "Americas, n.s." ///
400 "Algeria" ///
407 "Cameroon" ///
408 "Cape Verde" ///
414 "Egypt" ///
416 "Ethiopia" ///
417 "Eritrea" ///
421 "Ghana" ///
423 "Guinea" ///
427 "Kenya" ///
429 "Liberia" ///
436 "Morocco" ///
440 "Nigeria" ///
444 "Senegal" ///
447 "Sierra Leone" ///
448 "Somalia" ///
449 "South Africa" ///
451 "Sudan" ///
453 "Tanzania" ///
457 "Uganda" ///
461 "Zimbabwe" ///
462 "Africa" ///
463 "Eastern Africa, n.s." ///
464 "Northern Africa, n.s." ///
467 "Western Africa, n.s." ///
468 "Other Africa, n.s." ///
501 "Australia" ///
508 "Fiji" ///
512 "Micronesia" ///
515 "New Zealand" ///
523 "Tonga" ///
527 "Samoa" ///
554 "Other US Island Areas, Oceania, n.s., or at Sea"

lab var pobp09 "Place of birth"
lab val pobp09 pobp09
notes pobp09: Consistent for 2009-2011
notes pobp09: ACS: POBP


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
