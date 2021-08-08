set more 1

/*
File:	cepr_acs_empstat.do
Date:	Aug 4, 2011
	Oct 26, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent employment status variables for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Employment status last week */

if 2005<=`year' & `year'<=2018 {
gen byte lfstat=.
replace lfstat=1 if esr==1 | esr==2
replace lfstat=2 if esr==3
replace lfstat=3 if esr==6
replace lfstat=4 if esr==4 |esr==5
}
lab var lfstat "Labor-force status"
lab def lfstat	1 "Employed" ///
		2 "Unemployed" ///
		3 "NILF" ///
		4 "Armed Forces"
lab val lfstat lfstat
notes lfstat: ACS: ESR

/* Raw employment status recode */

#delimit ;
lab def esr
1 "Civilian employed, at work"
2 "Civilian employed, with a job but not at work"
3 "Unemployed"
4 "Armed forces, at work"
5 "Armed forces, with a job but not at work"
6 "Not in the labor force"
;
#delimit cr
lab val esr esr
lab var esr "Raw labor-force status"
notes esr: ACS: ESR

/* Military service */

if 2005<=`year' & `year'<=2012 {
gen byte milstat=.
replace milstat=1 if mil==1
replace milstat=2 if mil==2 | mil==3
replace milstat=3 if mil==4
replace milstat=4 if mil==5
}
if 2013<=`year' & `year'<=2018 {
gen byte milstat=mil if mil~=.
replace milstat=. if mil<1
replace milstat=. if 4<mil
}
lab def milstat 1 "Now on active duty" ///
		2 "On active duty in the past, but not now" ///
		3 "Only on active duty for training in Reserves/National Guard" ///
		4 "Never served in the military"	
lab var milstat "Military service"
lab val milstat milstat
notes milstat: Military service, ever
notes milstat: ACS: MIL


/* Military status last year (binary) */

if 2005<=`year' & `year'<=2012 {
gen byte mil_ly=0 if mil~=.
replace mil_ly=1 if (mil==1 | mil==2)
}
if 2013<=`year' & `year'<=2018 {
gen byte mil_ly=.
}
lab var mil_ly "Military status last 12 months"
lab val mil_ly noyes
notes mil_ly: ACS: Derived: MIL
notes mil_ly: Based on old (2005-2012) coding of MIL
notes mil_ly: Not available 2013-on

/* Civilian noninstitutionalized population */

if 2005<=`year' & `year'<=2018 {
gen byte civnonmil=1
replace civnonmil=0 if mil==1
replace civnonmil=0 if type==2
replace civnonmil=0 if esr==4 | esr==5
replace civnonmil=. if vacant==1
}
lab var civnonmil "Civilian noninstitutionalized population"
lab val civnonmil noyes
notes civnonmil: ACS: Derived: MIL TYPE AGE VACS

	/* Employment Status Last Year */

/* Weeks Worked Last Year */

	/* Continuous variable (2005-2007 only) */

if 2005<=`year' & `year'<=2007 {
replace wkw=. if wkw<1 | 52<wkw
gen wkw05=wkw if wkw~=.
}
if 2008<=`year' & `year'<=2018 {
gen byte wkw05=.
}
lab var wkw05 "Weeks worked during past 12 months"
notes wkw05: ACS: WKW
notes wkw05: Available 2005-2007 only

	/* Bracketed variable */
	
gen byte wkslyr=.

if 2005<=`year' & `year'<=2007 {
replace wkslyr=6 if 50<=wkw05 & wkw05<=52
replace wkslyr=5 if 48<=wkw05 & wkw05<=49
replace wkslyr=4 if 40<=wkw05 & wkw05<=47
replace wkslyr=3 if 27<=wkw05 & wkw05<=39
replace wkslyr=2 if 14<=wkw05 & wkw05<=26
replace wkslyr=1 if 1<=wkw05 & wkw05<14
}
if 2008<=`year' & `year'<=2018 {
replace wkslyr=1 if wkw==6
replace wkslyr=2 if wkw==5
replace wkslyr=3 if wkw==4
replace wkslyr=4 if wkw==3
replace wkslyr=5 if wkw==2
replace wkslyr=6 if wkw==1
}
lab def wkslyr 	1 "1-<14" /// 
		2 "14-26" ///
		3 "27-39" ///
		4 "40-47" ///
		5 "48-49" ///
		6 "50-52"
lab val wkslyr wkslyr
lab var wkslyr "Weeks worked during past 12 months"
notes wkslyr: ACS: WKW

/* Hours worked per week last year */

if `year'==2014 {
/* wkhp is str2 in 2014 */
destring wkhp, replace
}
if 2005<=`year' & `year'<=2018 {
gen byte hrslyr=wkhp
replace hrslyr=. if hrslyr<1 | 99<hrslyr
}
lab var hrslyr "Usual hours worked per week past 12 months"
notes hrslyr: Topcoded: 99
notes hrslyr: ACS: WKHP

/* Employment status last year */

if 2005<=`year' & `year'<=2018 {
gen byte emp1014=0
replace emp1014=1 if 16<=age & (2<=wkslyr & wkslyr<=6) & ///
(10<=hrslyr & hrslyr~=.)
}
lab var emp1014 "Employees, worked at least 14 wks/yr, 10hrs/wk"
lab val emp1014 noyes
notes emp1014: Worked at least 14 weeks/yr, 10 hrs/wk last year
notes emp1014: ACS: Derived: WKW WKHP

/* Job Class */

if 2005<=`year' & `year'<=2018 {
gen byte clslyr=.
replace clslyr=1 if cow==1 
replace clslyr=2 if cow==5 
replace clslyr=3 if cow==4 
replace clslyr=4 if cow==3 
replace clslyr=5 if cow==7 
replace clslyr=6 if cow==6 
replace clslyr=7 if cow==8 
replace clslyr=8 if cow==2 
replace clslyr=9 if cow==9 
}
lab var clslyr "Class of Worker"
lab define clslyr	1 "Private, for-profit" ///
			2 "Federal Government" ///
			3 "State Government" ///
			4 "Local Government" ///
			5 "Self-employed, incorp" ///
			6 "Self-employed, not incorp/farm" ///
			7 "Without pay" ///
			8 "Private, not-for-profit" ///
			9 "Unemployed"
lab val clslyr clslyr
notes clslyr: ACS: COW

/* Full-time, full year */
if 2005<=`year' & `year'<=2018 {
gen byte ftfy=0 if wkslyr~=. & hrslyr~=.
replace ftfy=1 if wkslyr==6 & (35<=hrslyr & hrslyr~=.)
}
lab var ftfy "Full-time, full year"
lab val ftfy noyes
notes ftfy: ACS: Dreived: WKHP WKW
notes ftfy: Full-time: 35+ hrs/wk; Full year: 50+ wks last yr

/* Part-time, part year */
if 2005<=`year' & `year'<=2018 {
gen byte ptpy=0 if wkslyr~=. & hrslyr~=.
replace ptpy=1 if (1<=wkslyr & wkslyr<=5) & (0<hrslyr & hrslyr<35)
}
lab var ptpy "Part-time, part year"
lab val ptpy ptpy noyes
notes ptpy: ACS: Derived: WKHP WKW

/* No Work */
if 2005<=`year' & `year'<=2018 {
gen byte nowork=0
replace nowork=1 if wkslyr==.
replace nowork=1 if hrslyr==.
}
lab var nowork "No Work Hours/Weeks"
lab val nowork nowork
notes nowork: ACS: Derived: WKHP WKW 

/* Full/Part-time Status */

if 2005<=`year' & `year'<=2018 {
gen byte ftptlyr=. 
replace ftptlyr=1 if wkslyr==6 & (35<=hrslyr & hrslyr~=.) 
replace ftptlyr=2 if wkslyr==6 & (hrslyr<35 & hrslyr~=.) 
replace ftptlyr=3 if (1<=wkslyr & wkslyr<=5) & (35<=hrslyr & hrslyr~=.) 
replace ftptlyr=4 if (1<=wkslyr & wkslyr<=5) & (hrslyr<35 & hrslyr~=.) 
replace ftptlyr=5 if wkhp==0 | wkw==0
}
lab var ftptlyr "Full/part-time & year"
lab def ftptlyr	1 "Full-time, full year" ///
		2 "Part-time, full year" ///
		3 "Full-time, part year" ///
		4 "Part-time, part year" ///
		5 "Nonworker"
lab val ftptlyr ftptlyr
notes ftptlyr: ACS: derived: WKHP WKW
notes ftptlyr: Full-time: 35+ hrs/week; Full year: 50+ weeks last yr

/* Current military status */

if 2005<=`year' & `year'<=2018 {
gen byte military=.
replace military=0 if 1<=esr & esr<=6
replace military=1 if (esr==4 | esr==5) 
}
lab var military "Active Duty Military, Current"
lab val military noyes
notes military: Current military status
notes military: ACS: ESR

/* When last worked */

if 2005<=`year' & `year'<=2018 {
replace wkl=. if wkl<1
replace wkl=. if 3<wkl
}
lab def wkl	1 "Within past year" ///
		2 "1-5 yrs ago" ///
		3 "Over 5 yrs ago or never worked"
lab var wkl "When last worked"
lab val wkl wkl
notes wkl: ACS: WKL

/* Looking for work */

if 2005<=`year' & `year'<=2018 {
replace nwlk=. if nwlk<1 | 2<nwlk
replace nwlk=0 if nwlk==2
}
lab var nwlk "Looking for work"
lab val nwlk noyes
notes nwlk: ACS: NWLK

/* Temporary absence from work */

if 2005<=`year' & `year'<=2018 {
replace nwab=. if nwab<1 | 2<nwab
replace nwab=0 if nwab==2
}
lab var nwab "Temporary absence from work"
lab val nwab noyes
notes nwab: ACS: NWAB

/* On layoff from work */

if 2005<=`year' & `year'<=2018 {
replace nwla=. if nwla<1 | 2<nwla
replace nwla=0 if nwla==2
}
lab var nwla "On layoff from work"
lab val nwla noyes
notes nwla: ACS: NWLA

/* Available for work */

if 2005<=`year' & `year'<=2018 {
replace nwav=. if nwav<1 | 4<nwav
lab def nwav	1 "Yes" ///
		2 "No, temporarily ill" ///
		3 "No, other reasons" ///
		4 "No, unspecified"
}
lab var nwav "Available for Work"
lab val nwav nwav
notes nwav: ACS: nwav

/* Unincorporated self-employed */

if 2005<=`year' & `year'<=2018 {
gen byte selfemp=0 if cow~=.
replace selfemp=1 if cow==6 
replace selfemp=. if cow==9 /*unemployed*/
}
lab var selfemp "Unincorporated self-employed"
lab val selfemp noyes
notes selfemp: Unincorporated self-employed only
notes selfemp: ACS: derived: COW

/* Incorporated self-employed */

if 2005<=`year' & `year'<=2018 {
gen byte selfinc=0 if cow~=. 
replace selfinc=1 if cow==7
replace selfinc=. if cow==9 /*unemployed*/
}
lab var selfinc "Incorporated self-employed"
lab val selfinc noyes
notes selfinc: Incorporated self-employed only
notes selfinc: ACS: derived: COW

/* Public sector */

if 2005<=`year' & `year'<=2018 {
gen byte pubsect=0 if cow~=.
replace pubsect=1 if 3<=cow & cow<=5 
replace pubsect=. if cow==9 /*unemployed*/
}
lab var pubsect "Public sector"
lab val pubsect noyes
notes pubsect: Federal, state, and local
notes pubsect: ACS: derived: COW

/* Federal */

if 2005<=`year' & `year'<=2018 {
gen byte pubfed=0 if cow~=.
replace pubfed=1 if cow==5 
replace pubfed=. if cow==9 /*unemployed*/
}
lab var pubfed "Federal employee"
lab val pubfed noyes
notes pubfed: ACS: derived: COW

/* State */

if 2005<=`year' & `year'<=2018 {
gen byte pubst=0 if cow~=.
replace pubst=1 if cow==4 
replace pubst=. if cow==9 /*unemployed*/
}
lab var pubst "State employee"
lab val pubst noyes
notes pubst: ACS: derived: COW

/* Local */

if 2005<=`year' & `year'<=2018 {
gen byte publoc=0 if cow~=.
replace publoc=1 if cow==3 
replace publoc=. if cow==9 /*unemployed*/
}
lab var publoc "Local employee"
lab val publoc noyes
notes publoc: ACS: derived: COW

/* Non-Profit */

if 2005<=`year' & `year'<=2018 {
gen byte nonprof=0 if cow~=.
replace nonprof=1 if cow==2 
replace nonprof=. if cow==9 /*unemployed*/
}
lab var nonprof "Non-Profit"
lab val nonprof noyes
notes nonprof: ACS: derived: COW

/* Place of Work */

/* State (place of work) */ 

if 2005<=`year' & `year'<=2011 {
gen powsp00=powsp if powsp~=.
replace powsp00=. if powsp<1
replace powsp00=. if 555<powsp
}
if 2012<=`year' & `year'<=2018 {
gen powsp00=.
}
#delimit;
lab def powsp00
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
166 "Europe"
213 "Iraq"
251 "Eastern Asia"
254 "Other Asia, n.s."
301 "Canada"
303 "Mexico"
399 "Americas, n.s."
555 "Other US Island Areas n.s., Africa, Oceania, at Sea, or Abroad, n.s."
;
#delimit cr
lab var powsp00 "Place of Work - State (2000 Census boundaries)"
lab val powsp00 powsp00
notes powsp00: ACS: POWSP


if 2005<=`year' & `year'<=2011 {
gen powsp10=.
}
if 2012<=`year' & `year'<=2018 {
gen powsp10=powsp if powsp~=.
replace powsp10=. if powsp<1
replace powsp10=. if 555<powsp
}
#delimit;
lab def powsp10
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
166 "Europe"
251 "Eastern Asia"
254 "Other Asia, Not Specified"
301 "Canada"
303 "Mexico"
399 "Americas, Not Specified"
555 "Other US Island Areas Not Specified, Africa, Oceania, at Sea, or Abroad, Not Specified"
;
#delimit cr
lab var powsp10 "Place of Work - State (2010 Census boundaries)"
lab val powsp10 powsp10
notes powsp10: ACS: POWSP


/* PUMA (place of work) */

if 2005<=`year' & `year'<=2011 {
gen powpuma00=powpuma if powpuma~=.
replace powpuma00=. if powpuma<1
replace powpuma00=. if 8200<powpuma
}
if 2012<=`year' & `year'<=2018 {
gen powpuma00=.
}
lab var powpuma00 "Place of Work PUMA (2000 Census boundaries)"
lab val powpuma00 powpuma00
notes powpuma00: ACS: POWPUMA
notes powpuma00: Use with variable powsp00 for unique code
notes powpuma00: Boundaries for 2005-2011 are based on 2000 Census definition


if 2005<=`year' & `year'<=2011 {
gen powpuma10=.
}
if 2012<=`year' & `year'<=2018 {
gen powpuma10=powpuma if powpuma~=.
replace powpuma10=. if powpuma<1
replace powpuma10=. if 70100<powpuma
}
lab var powpuma10 "Place of Work PUMA (2010 Census boundaries)"
lab val powpuma10 powpuma10
notes powpuma10: ACS: POWPUMA
notes powpuma10: Use with variable powsp10 for unique code
notes powpuma10: Boundaries for 2012-2018 are based on 2010 Census definition
notes powpuma10: 2010 Place of Work PUMAs and Migration PUMAs are identical, so /*
*/  their relationships to PUMAs (place of residence) are the same


/* Travel time to work */

if `year'==2014 {
/* jwmnp is str3 for 2014 */
destring jwmnp, replace
}
if 2005<=`year' & `year'<=2018 {
replace jwmnp=. if jwmnp<1 | jwmnp>200
}
lab var jwmnp "Travel time to work (mins)"

notes jwmnp: ACS: JWMNP
notes jwmnp: Topcode 200

/* Vehicle Occupancy (to work) */

if `year'==2014 {
/* jwrip is str2 for 2014 */
destring jwrip, replace
}
if 2005<=`year' & `year'<=2018 {
replace jwrip=. if jwrip<1 | jwrip>10
}
#delimit ;
lab def jwrip
1 "Drove alone"
2 "In 2-person carpool"
3 "In 3-person carpool"
4 "In 4-person carpool"
5 "In 5-person carpool"
6 "In 6-person carpool"
7 "In 7-person carpool"
8 "In 8-person carpool"
9 "In 9-person carpool"
10 "In 10-person or more carpool"
;
#delimit cr

lab var jwrip "Vehicle occupancy (to work)"
lab val jwrip jwrip

notes jwrip: ACS: JWRIP
notes jwrip: Topcode 10

/* Means of Transportation to Work */

if 2005<=`year' & `year'<=2018 {
replace jwtr=. if jwtr<1 | jwtr>12
}
#delimit ;
lab def jwtr
1 "Car, truck, or van"
2 "Bus or trolley bus"
3 "Streetcar or trolley care (carro publico in PR)"
4 "Subway or elevated"
5 "Railroad"
6 "Ferryboat"
7 "Taxicab"
8 "Motorcycle"
9 "Bicycle"
10 "Walked"
11 "Worked at home"
12 "Other method"
;
#delimit cr
lab var jwtr "Means of transportation to work"
lab val jwtr jwtr
notes jwtr: ACS: JWTR

/* Uses public transit to commute to work */
if 2005<=`year' & `year'<=2018 { 
gen byte pubtran=. if jwtr~=.
replace pubtran=0 if jwtr==1 | (7<=jwtr & jwtr<=12)
replace pubtran=1 if (2<=jwtr & jwtr<=6)
}
lab var pubtran "Uses public transit to commute to work"
lab val pubtran noyes
notes pubtran: ACS: Derived: JWTR

/* Time of arrival at work */

if 2005<=`year' & `year'<=2018 {
replace jwap=. if jwap<1 | jwap>285
replace jwap=1 if (1<=jwap & jwap<=10)
replace jwap=2 if (11<=jwap & jwap<=21)
replace jwap=3 if (22<=jwap & jwap<=33)
replace jwap=4 if (34<=jwap & jwap<=45)
replace jwap=5 if (46<=jwap & jwap<=57)
replace jwap=6 if (58<=jwap & jwap<=69)
replace jwap=7 if (70<=jwap & jwap<=81)
replace jwap=8 if (82<=jwap & jwap<=93)
replace jwap=9 if (94<=jwap & jwap<=105)
replace jwap=10 if (106<=jwap & jwap<=117)
replace jwap=11 if (118<=jwap & jwap<=129)
replace jwap=12 if (130<=jwap & jwap<=141)
replace jwap=13 if (142<=jwap & jwap<=153)
replace jwap=14 if (154<=jwap & jwap<=165)
replace jwap=15 if (166<=jwap & jwap<=177)
replace jwap=16 if (178<=jwap & jwap<=189)
replace jwap=17 if (190<=jwap & jwap<=201)
replace jwap=18 if (202<=jwap & jwap<=213)
replace jwap=19 if (214<=jwap & jwap<=225)
replace jwap=20 if (226<=jwap & jwap<=237)
replace jwap=21 if (238<=jwap & jwap<=249)
replace jwap=22 if (250<=jwap & jwap<=261)
replace jwap=23 if (262<=jwap & jwap<=273)
replace jwap=24 if (274<=jwap & jwap<=285)
}
#delimit ;
lab def jwap
1 "12:00 a.m. to 12:59 a.m."
2 "1:00 a.m. to 1:59 a.m."
3 "2:00 a.m. to 2:59 a.m."
4 "3:00 a.m. to 3:59 a.m."
5 "4:00 a.m. to 4:59 a.m."
6 "5:00 a.m. to 5:59 a.m."
7 "6:00 a.m. to 6:59 a.m."
8 "7:00 a.m. to 7:59 a.m."
9 "8:00 a.m. to 8:59 a.m."
10 "9:00 a.m. to 9:59 a.m."
11 "10:00 a.m. to 10:59 a.m."
12 "11:00 a.m. to 11:59 a.m."
13 "12:00 p.m. to 12:59 p.m."
14 "1:00 p.m. to 1:59 p.m."
15 "2:00 p.m. to 2:59 p.m."
16 "3:00 p.m. to 3:59 p.m."
17 "4:00 p.m. to 4:59 p.m."
18 "5:00 p.m. to 5:59 p.m."
19 "6:00 p.m. to 6:59 p.m."
20 "7:00 p.m. to 7:59 p.m."
21 "8:00 p.m. to 8:59 p.m."
22 "9:00 p.m. to 9:59 p.m."
23 "10:00 p.m. to 10:59 p.m."
24 "11:00 p.m. to 11:59 p.m."
;
#delimit cr
lab var jwap "Time of arrival at work (hr & min)"
lab val jwap jwap
notes jwap: ACS: JWAP
notes jwap: In hour increments

/* Time of departure for work */

if 2005<=`year' & `year'<=2018 {
replace jwdp=. if jwdp<1 | jwdp>150
replace jwdp=1 if (1<=jwdp & jwdp<=2)
replace jwdp=2 if (3<=jwdp & jwdp<=4)
replace jwdp=3 if (5<=jwdp & jwdp<=6)
replace jwdp=4 if (7<=jwdp & jwdp<=12)
replace jwdp=5 if (13<=jwdp & jwdp<=18)
replace jwdp=6 if (19<=jwdp & jwdp<=30)
replace jwdp=7 if (31<=jwdp & jwdp<=42)
replace jwdp=8 if (43<=jwdp & jwdp<=54)
replace jwdp=9 if (55<=jwdp & jwdp<=66)
replace jwdp=10 if (67<=jwdp & jwdp<=78)
replace jwdp=11 if (79<=jwdp & jwdp<=84)
replace jwdp=12 if (85<=jwdp & jwdp<=90)
replace jwdp=13 if (91<=jwdp & jwdp<=96)
replace jwdp=14 if (97<=jwdp & jwdp<=102)
replace jwdp=15 if (103<=jwdp & jwdp<=108)
replace jwdp=16 if (109<=jwdp & jwdp<=114)
replace jwdp=17 if (115<=jwdp & jwdp<=120)
replace jwdp=18 if (121<=jwdp & jwdp<=126)
replace jwdp=19 if (127<=jwdp & jwdp<=132)
replace jwdp=20 if (133<=jwdp & jwdp<=134)
replace jwdp=21 if (135<=jwdp & jwdp<=136)
replace jwdp=22 if (137<=jwdp & jwdp<=142)
replace jwdp=23 if (143<=jwdp & jwdp<=148)
replace jwdp=24 if (149<=jwdp & jwdp<=150)
}
#delimit ;
lab def jwdp
1 "12:00 a.m. to 12:59 a.m."
2 "1:00 a.m. to 1:59 a.m."
3 "2:00 a.m. to 2:59 a.m."
4 "3:00 a.m. to 3:59 a.m."
5 "4:00 a.m. to 4:59 a.m."
6 "5:00 a.m. to 5:59 a.m."
7 "6:00 a.m. to 6:59 a.m."
8 "7:00 a.m. to 7:59 a.m."
9 "8:00 a.m. to 8:59 a.m."
10 "9:00 a.m. to 9:59 a.m."
11 "10:00 a.m. to 10:59 a.m."
12 "11:00 a.m. to 11:59 a.m."
13 "12:00 p.m. to 12:59 p.m."
14 "1:00 p.m. to 1:59 p.m."
15 "2:00 p.m. to 2:59 p.m."
16 "3:00 p.m. to 3:59 p.m."
17 "4:00 p.m. to 4:59 p.m."
18 "5:00 p.m. to 5:59 p.m."
19 "6:00 p.m. to 6:59 p.m."
20 "7:00 p.m. to 7:59 p.m."
21 "8:00 p.m. to 8:59 p.m."
22 "9:00 p.m. to 9:59 p.m."
23 "10:00 p.m. to 10:59 p.m."
24 "11:00 p.m. to 11:59 p.m."
;
#delimit cr
lab var jwdp "Time of departure for work (hr & min)"
lab val jwdp jwdp
notes jwdp: ACS: JWDP
notes jwdp: In hour increments



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
