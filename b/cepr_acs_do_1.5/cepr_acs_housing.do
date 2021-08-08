set more 1

/*
File:	cepr_acs_housing.do
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
Desc:	Creates consistent housing variables for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Inflation adjustment factor (housing) */

if 2005<=`year' & `year'<=2007 {
gen adj_h=adjust/1000000 /* only one adjustment factor for all dollar amounts */
}
if 2008<=`year' & `year'<=2018 {
gen adj_h=adjhsg/1000000 /* adj factor for housing dollar amounts */
}
lab var adj_h "Adjustment Factor - Housing"
notes adj_h: ACS: ADJHSG
notes adj_h: For 2005-2007, uses same adjustment factor as income amounts
notes adj_h: Adjusts only housing dollar amounts 2008-present


/* various housing variables were string in 2014, so destring */
if `year'==2014 {
destring bdsp conp elep fulp gasp insp mhp mrgp rmsp rntp smp /*
*/ valp watp grntp smocp, replace
}


/* Housing type */

if 2005<=`year' & `year'<=2018 {
lab var type "Housing type"
lab def type 	1 "Housing unit" ///
		2 "Institutional group quarters" ///
		3 "Noninstitutional group quarters"
lab val type type
notes type: ACS: TYPE
}

/* Vacant */

if 2005<=`year' & `year'<=2018 {
gen byte vacant=0
replace vacant=1 if np==0
}
lab var vacant "Vacant unit"
lab val vacant noyes
notes vacant: ACS: NP

/* Lot size */

if 2005<=`year' & `year'<=2018 {
replace acr=. if acr<1 | 3<acr
}
lab var acr "Lot size (acres)"
lab def acr 1 "<1 acre" 2 "1-<10 acres" 3 "10+ acres"
lab val acr acr
notes acr: ACS: ACR


/* Sales of agricultural products */

if 2005<=`year' & `year'<=2018 {
replace ags=. if ags<1 | 6<ags
}
lab var ags "Sales of ag products ($/Yr)"
lab def ags 	1 "None" ///
		2 "$1-999" ///
		3 "$1000-2499" ///
		4 "$2500-4999" ///
		5 "$5000-9999" ///
		6 "$10000+"
lab val ags ags
notes ags: No adjustment factor is applied to ags.
notes ags: ACS: AGS

/* Has bathtub or shower */

if 2005<=`year' & `year'<=2007 {
gen byte bath=.
}
if 2008<=`year' & `year'<=2018 {
replace bath=. if bath<1 | 2<bath
replace bath=0 if bath==2
}
lab var bath "Has bath or shower"
lab val bath noyes
notes bath: ACS: BATH

/* Number of bedrooms */

if 2005<=`year' & `year'<=2007 {
rename bds bdsp
}
if 2008<=`year' & `year'<=2018 {
replace bdsp=5 if 5<=bdsp
}
replace bdsp=. if bdsp<0 | 5<bdsp
lab var bdsp "Number of bedrooms"
lab def bdsp	0 "0" ///
		1 "1" ///
		2 "2" ///
		3 "3" ///
		4 "4" ///
		5 "5+"
lab val bdsp bdsp
notes bds: ACS: BDS for 2005-2007
notes bdsp: ACS: BDSP for 2008-

/* Units in structure */

if 2005<=`year' & `year'<=2018 {
replace bld=. if bld<1 | 10<bld
}
lab var bld "Units in structure"
lab def bld 	1 "Mobile home or trailer" ///
		2 "One-family house detached" ///
		3 "One-family house attached" ///
		4 "2 apartments"  ///
		5 "3-4 apartments" ///
		6 "5-9 apartments" ///
		7 "10-19 apartments" ///
		8 "20-49 apartments" ///
		9 "50+ apartments" ///
		10 "Boat, RV, van, etc."
lab val bld bld
notes bld: ACS: BLD

/* Business or medical office on property */
* Note: Only available 2005-2015

if 2005<=`year' & `year'<=2015 {
replace bus=. if bus<1 | 2<bus
replace bus=0 if bus==2
}
if 2016<=`year' & `year'<=2018 {
gen bus=.
}
lab var bus "Business or medical office on property"
lab val bus noyes
notes bus: ACS: Only available 2005-2015

/* Condo fee (monthly amount) */

if 2005<=`year' & `year'<=2018 {
gen conp_adj=round(conp*adj_h,1) if conp~=.
replace conp_adj=. if conp<1 | 9999<conp
}
lab var conp_adj "Condo fee adj ($/month)"
notes conp_adj: Topcoded according to nominal CONP, $9999; data rounded
notes conp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes conp_adj: Does not include vacant units
notes conp_adj: ACS: CONP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Electricity (monthly cost) */

if 2005<=`year' & `year'<=2017 {
gen elep_adj=round(elep*adj_h,1) if elep~=.
replace elep_adj=. if elep<1 | 999<elep
replace elep_adj=0 if elep==1 | elep==2
}
if `year'==2018 {
gen elep_adj=. if elefp~=.
replace elep_adj=0 if elefp==1 | elefp==2
replace elep_adj=round(elep*adj_h,1) if elefp==3
}
lab var elep_adj "Electricity adj ($/month)"
notes elep_adj: $0 indicates included in rent or condo fee, no charge, or not used
notes elep_adj: Topcoded according to nominal ELEP, $999; data rounded
notes elep_adj: Bottomcoded according to nominal ELEP, $3; data rounded
notes elep_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes elep_adj: ACS: ELEP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Other fuel costs (monthly cost) */

if 2005<=`year' & `year'<=2017 {
gen fulp_adj=round(fulp*adj_h,1) if fulp~=.
replace fulp_adj=. if fulp<1 | 9999<fulp
replace fulp_adj=0 if fulp==1 | fulp==2
replace fulp_adj=round(fulp_adj/12,1) /* convert annual cost to monthly cost */
}
if `year'==2018 {
gen fulp_adj=. if fulfp~=.
replace fulp_adj=0 if fulfp==1 | fulfp==2
replace fulp_adj=round(fulp*adj_h,1) if fulfp==3
replace fulp_adj=round(fulp_adj/12,1) /* convert annual cost to monthly cost */
}
lab var fulp_adj "Other fuel adj ($/month)"
notes fulp_adj: $0 indicates included in rent/condo fee, no charge, or not used
notes fulp_adj: Topcoded according to nominal FULP, $9999 annually; data rounded
notes elep_adj: Bottomcoded according to nominal FULP, $3; data rounded
notes fulp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes fulp_adj: ACS: FULP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Natural gas costs (monthly cost) */

if 2005<=`year' & `year'<=2017 {
gen gasp_adj=round(gasp*adj_h,1) if gasp~=.
replace gasp_adj=. if gasp<1 | 999<gasp
replace gasp_adj=0 if gasp==1 | gasp==2 | gasp==3
}
if `year'==2018 {
gen gasp_adj=. if gasfp~=.
replace gasp_adj=0 if gasfp==1 | gasfp==2 | gasfp==3
replace gasp_adj=round(gasp*adj_h,1) if gasfp==4
}
lab var gasp_adj "Natural gas adj ($/month)"
notes gasp_adj: $0 indicates included in rent or condo fee, /* 
*/ in electricity payment, no charge, or not used
notes gasp_adj: Topcoded according to nominal GASP, $999; data rounded
notes elep_adj: Bottomcoded according to nominal GASP, $4; data rounded
notes gasp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes gasp_adj: ACS: GASP, ADJUST (2005-2007), ADJHSG (2008-present)


/* Type of house heating fuel */

if 2005<=`year' & `year'<=2018 {
replace hfl=. if hfl<1 | 9<hfl
replace hfl=0 if hfl==9 
}
lab var hfl "Heating fuel type"
lab def hfl 	0 "No fuel used" ///
		1 "Utility gas" ///
           	2 "Bottled, tank, or LP gas" ///
           	3 "Electricity" ///
           	4 "Fuel oil, kerosene, etc." ///
           	5 "Coal or coke" ///
           	6 "Wood" ///
           	7 "Solar energy" ///
          	8 "Other fuel"
lab val hfl hfl
notes hfl: ACS: HFL


/* Fire/hazard/flood insurance (monthly cost) */

if 2005<=`year' & `year'<=2010 {
gen insp_adj=round(insp*adj_h,1) if insp~=.
replace insp_adj=. if insp<0 | 9999<insp
replace insp_adj=round(insp_adj/12,1) /* convert annual cost to monthly cost */
}
if 2011<=`year' & `year'<=2018 {
gen insp_adj=round(insp*adj_h,1) if insp~=.
replace insp_adj=. if insp<0 | 10000<insp
replace insp_adj=round(insp_adj/12,1) /* convert annual cost to monthly cost */
}
lab var insp_adj "Fire/hazard/flood insurance adj ($/month)"
notes insp_adj: Topcoded according to nominal INSP
notes insp_adj: Topcode: 2005-2010, 9999 annually; data rounded
notes insp_adj: Topcode: 2011-, 10,000 annually; data rounded
notes insp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes insp: ACS: INSP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Mobile home costs (monthly cost) */

if 2005<=`year' & `year'<=2018 {
gen mhp_adj=round(mhp*adj_h,1) if mhp~=.
replace mhp_adj=. if mhp<1 | 99999<mhp
replace mhp_adj=round(mhp_adj/12,1) /* convert annual cost to monthly cost */
}

lab var mhp_adj "Mobile home costs adj ($/month)"
notes mhp_adj: Topcoded according to nominal MHP, 99999 annually; data rounded
notes mhp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes mhp_adj: ACS: MHP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Mortgage payment includes fire/hazard/flood insurance */

if 2005<=`year' & `year'<=2018 {
replace mrgi=. if mrgi<1 | 2<mrgi
replace mrgi=0 if mrgi==2
}
lab var mrgi "Mortgage payment incl fire/hazard/flood insurance"
lab val mrgi noyes
notes mrgi: ACS: MRGI

/* Mortgage payment (monthly cost) */

if 2005<=`year' & `year'<=2018 {
gen mrgp_adj=round(mrgp*adj_h,1) if mrgp~=.
replace mrgp_adj=. if mrgp<1 | 99999<mrgp
}
lab var mrgp_adj "Mortgage payment adj ($/month)"
notes mrgp_adj: Topcoded according to nominal MRGP, 99999; data rounded
notes mrgp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes mrgp: ACS: MRGP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Mortgage payment includes real estate taxes */

if 2005<=`year' & `year'<=2018 {
replace mrgt=. if mrgt<1 | 2<mrgt
replace mrgt=0 if mrgt==2
}
lab var mrgt "Mortgage payment incl real estate taxes"
lab val mrgt noyes
notes mrgt: ACS: MRGT


/* Mortgage status */

if 2005<=`year' & `year'<=2018 {
replace mrgx=. if mrgx<1 | 3<mrgx
}
lab var mrgx "Mortgage status"
lab def mrgx	1 "Mortgage deed of trust, or similar debt" ///
           	2 "Contract to purchase" ///
	        3 "None"
lab val mrgx mrgx
notes mrgx: ACS: MRGX


/* Has refrigerator */

if 2005<=`year' & `year'<=2007 {
gen byte refr=.
}
if 2008<=`year' & `year'<=2018 {
replace refr=. if refr<1 | 2<refr
replace refr=0 if refr==2
}
lab var refr "Refrigerator"
lab val refr noyes
notes refr: ACS: REFR

/* Number of rooms */

if 2005<=`year' & `year'<=2007 {
rename rms rmsp
}
if 2008<=`year' & `year'<=2018 {
replace rmsp=9 if 9<=rmsp
}
replace rmsp=. if rmsp<1
lab var rmsp "Number of rooms"
lab def rmsp	1 "1" ///
		2 "2" ///
		3 "3" ///
		4 "4" ///
		5 "5" ///
		6 "6" ///
		7 "7" ///
		8 "8" ///
		9 "9+"
lab val rmsp rmsp
notes rmsp: ACS: RMS for 2005-2007, RMSP 2008-on

/* Meals included in rent */

if 2005<=`year' & `year'<=2018 {
replace rntm=. if rntm<1 | 2<rntm
replace rntm=0 if rntm==2
}
lab var rntm "Meals included in rent"
lab val rntm noyes
notes rntm: ACS: RNTM


/* Monthly rent */

if 2005<=`year' & `year'<=2018 {
gen rntp_adj=round(rntp*adj_h,1) if rntp~=.
replace rntp_adj=. if rntp<1 | 99999<rntp
}
lab var rntp_adj "Rent adj ($/month)"
notes rntp_adj: Topcoded according to nominal RNTP, 99999; data rounded
notes rntp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes rntp_adj: ACS: RNTP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Has hot and cold running water */

if 2005<=`year' & `year'<=2007 {
gen byte rwat=.
}
if 2008<=`year' & `year'<=2018 {
replace rwat=. if rwat<1 | 2<rwat
replace rwat=0 if rwat==2
}
lab var rwat "Hot and cold running water"
lab val rwat noyes
notes rwat: ACS: RWAT
notes rwat: Available 2008-on

/* Has sink with a faucet */

if 2005<=`year' & `year'<=2007 {
gen byte sink=.
}
if 2008<=`year' & `year'<=2018 {
replace sink=. if sink<1 | 2<sink
replace sink=0 if sink==2
}
lab var sink "Sink with faucet"
lab val sink noyes
notes sink: ACS: SINK
notes sink: Available 2008-on

/* Second mortgage payment (monthly cost) */

if 2005<=`year' & `year'<=2018 {
gen smp_adj=round(smp*adj_h,1) if smp~=.
replace smp_adj=. if smp<1 | 99999<smp
}
lab var smp_adj "2nd mortgage payment adj ($/month)"
notes smp_adj: Topcoded according to nominal SMP, $99999; data rounded
notes smp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes smp_adj: ACS: SMP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Stove or range */


gen byte stove=.

if 2008<=`year' & `year'<=2018 {
replace stove=1 if stov==1
replace stove=0 if stov==2
}
lab var stove "Stove or range"
lab val stove noyes
notes stove: ACS: STOV
notes stove: Available 2008-on

/* Telephone in unit */

if 2005<=`year' & `year'<=2018 {
replace tel=. if tel<1 | 2<tel
replace tel=0 if tel==2
}
lab var tel "Telephone in unit"
lab val tel noyes
notes tel: ACS: TEL
/*
NOTE: Problems in the collection of data on the availability 
of telephone service (TEL) in 2012 led to suppressing this 
variable in 6 PUMAs in Georgia. This only affects data from 
the 2012 1-year ACS PUMS.

NOTE: Problems in the collection of data on the availability of telephone
service (TEL) in 2015 led to suppressing this variable in five PUMAs: one
PUMA in Arkansas, two in Florida, one in Kentucky, and one in Wisconsin.
They are set to missing in this extract and set to 8 in the raw data. See the
Estimation section of the Accuracy of the Data for the 2015 1-year PUMS for
more information on ACS PUMS estimates using TEL.
*/


/* Housing tenure */

if 2005<=`year' & `year'<=2018 {
replace ten=. if ten<1 | 4<ten
}
lab var ten "Housing tenure"
lab def ten	1 "Owned with mortgage or loan" ///
	        2 "Owned free and clear" ///
	        3 "Rented" ///
	        4 "Occupied without payment of rent"
lab val ten ten
notes ten: ACS: TEN

/* Home ownership */

if 2005<=`year' & `year'<=2018 {
gen byte hmown=0
replace hmown=1 if ten==1 | ten==2
}
lab var hmown "Home ownership"
lab val hmown noyes
notes hmown: ACS: Derived: TEN

/* Renter status */

if 2005<=`year' & `year'<=2018 {
gen byte hmrnt=0
replace hmrnt=1 if ten==3
}
lab var hmrnt "Renter status"
lab val hmrnt noyes
notes hmrnt: ACS: Derived: TEN

/* Has flush toilet */
* Note: Variable only available 2008-2015

gen byte toilet=.

if 2008<=`year' & `year'<=2015 {
replace toilet=. if toil<1 | 2<toil
replace toilet=1 if toil==1
replace toilet=0 if toil==2
}
lab var toilet "Flush toilet"
lab val toilet noyes
notes toilet: ACS: TOIL
notes toilet: Available 2008-2015

/* Vacancy status */

if 2005<=`year' & `year'<=2018 {
replace vacs=. if vacs<1 | 7<vacs
}
lab var vacs "Vacancy status"
lab def vacs	1 "For rent" ///
		2 "Rented, not occupied" ///
		3 "For sale only" ///
		4 "Sold, not occupied" ///
		5 "For seasonal/recreational/occasional use" ///
		6 "For migratory workers" ///
		7 "Other vacant"
lab val vacs vacs
notes vacs: ACS: VACS


/* Property value */

	/*Bracketed for 2005-present */

if 2005<=`year' & `year'<=2007 {
gen byte value=val if val~=.
}
if 2008<=`year' & `year'<=2018 {
gen byte value=.
replace valp=. if valp<1 | 9999999<valp
replace value=1 if valp<10000
replace value=2 if 10000<=valp & valp<15000
replace value=3 if 15000<=valp & valp<20000
replace value=4 if 20000<=valp & valp<25000
replace value=5 if 25000<=valp & valp<30000
replace value=6 if 30000<=valp & valp<35000
replace value=7 if 35000<=valp & valp<40000
replace value=8 if 40000<=valp & valp<50000
replace value=9 if 50000<=valp & valp<60000
replace value=10 if 60000<=valp & valp<70000
replace value=11 if 70000<=valp & valp<80000
replace value=12 if 80000<=valp & valp<90000
replace value=13 if 90000<=valp & valp<100000
replace value=14 if 100000<=valp & valp<125000
replace value=15 if 125000<=valp & valp<150000
replace value=16 if 150000<=valp & valp<175000
replace value=17 if 175000<=valp & valp<200000
replace value=18 if 200000<=valp & valp<250000
replace value=19 if 250000<=valp & valp<300000
replace value=20 if 300000<=valp & valp<400000
replace value=21 if 400000<=valp & valp<500000
replace value=22 if 500000<=valp & valp<750000
replace value=23 if 750000<=valp & valp<1000000
replace value=24 if 1000000<=valp
}
lab var value "Property value ($)"
lab def value ///
1 "Less than $ 10000" ///
2 "$10000-14999" ///
3 "$15000-19999" ///
4 "$20000-24999" ///
5 "$25000-29999" ///
6 "$30000-34999" ///
7 "$35000-39999" ///
8 "$40000-49999" ///
9 "$50000-59999" ///
10 "$60000-69999" ///
11 "$70000-79999" ///
12 "$80000-89999" ///
13 "$90000-99999" ///
14 "$100000-124999" ///
15 "$125000-149999" ///
16 "$150000-174999" ///
17 "$175000-199999" ///
18 "$200000-249999" ///
19 "$250000-299999" ///
20 "$300000-399999" ///
21 "$400000-499999" ///
22 "$500000-749999" ///
23 "$750000-999999" ///
24 "$1000000+"
lab val value value
notes value: Topcode: $9999999; data rounded
notes value: no adjustment factor applied to value
notes value: ACS: VAL for 2005-07, VALP for 2008-

	/* Continuous variable for 2008-present */

if 2005<=`year' & `year'<=2007 {
gen byte value08_adj=.
}
if 2008<=`year' & `year'<=2018 {
gen value08_adj=round(valp*adj_h,1) if valp~=.
replace value08_adj=. if valp<1 | 9999999<valp
}

lab var value08_adj "Property Value adj"
notes value08_adj: Rounded and Topcoded according to nominal VALP, 9999999
notes value08_adj: Uses adjhsg to adjust to constant calendar year $
notes value08_adj: ACS: VALP, ADJHSG (2008-present)

/* Water (monthly cost) */

if 2005<=`year' & `year'<=2017 {
gen watp_adj=round(watp*adj_h,1) if watp~=.
replace watp_adj=. if watp<1 | 9999<watp
replace watp_adj=0 if watp==1 | watp==2
replace watp_adj=round(watp_adj/12,1) /* convert annual cost to monthly cost */
}
if `year'==2018 {
gen watp_adj=. if watfp~=.
replace watp_adj=0 if watfp==1 | watfp==2
replace watp_adj=round(watp*adj_h,1) if watfp==3
replace watp_adj=round(watp_adj/12,1) /* convert annual cost to monthly cost */
}
lab var watp_adj "Water adj ($/month)"
notes watp_adj: $0 indicates included in rent or condo fee or no charge
notes watp_adj: Topcoded according to nominal WATP, $9999 annually; data rounded
notes watp_adj: Bottomcoded according to nominal WATP, $4 annually; data rounded
notes watp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes watp_adj: ACS: WATP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Year structure first built */

/* Create ybl08, consistent for 2008-present */

gen byte ybl08=.

if `year'==2008 {
replace ybl08=1 if ybl==12
replace ybl08=2 if ybl==11
replace ybl08=3 if ybl==10
replace ybl08=4 if ybl==9
replace ybl08=5 if ybl==8
replace ybl08=6 if ybl==7
replace ybl08=7 if ybl==6
replace ybl08=8 if ybl==5
replace ybl08=9 if ybl==4
replace ybl08=10 if ybl==3
replace ybl08=11 if ybl==2
replace ybl08=12 if ybl==1
}
if 2009<=`year' & `year'<=2018 {
replace ybl08=ybl
}
#delimit;
lab def ybl08	
		1 "1939 or earlier" 
		2 "1940-49" 
		3 "1950-59" 
		4 "1960-69" 
		5 "1970-79" 
		6 "1980-89" 
		7 "1990-99"
		8 "2000-04"
		9 "2005"
		10 "2006"
		11 "2007"
		12 "2008"
		13 "2009"
		14 "2010"
		15 "2011"
		16 "2012"
		17 "2013"
		18 "2014"
		19 "2015"
		20 "2016"
		21 "2017"
		22 "2018"
		;
#delimit cr
lab var ybl08 "Year structure first built"
lab val ybl08 ybl08
notes ybl08: ACS: YBL 2008-on

/* Create ybl05, consistent for 2005-2007 */

gen byte ybl05=.

if 2005<=`year' & `year'<=2007 {
replace ybl05=ybl
}
lab var ybl05 "Year structure first built"
lab def ybl05	1 "2005 or later" ///
		2 "2000-04" ///
		3 "1990-99" ///
		4 "1980-89" ///
		5 "1970-79" ///
		6 "1960-69" ///
		7 "1950-59" ///
		8 "1940-49" ///
		9 "1939 or earlier"
lab val ybl05 ybl05
notes ybl05: ACS: YBL 2005-2007

/* Make ybl consistent across all years */

if 2005<=`year' & `year'<=2007 {
gen byte ybl_all=ybl05
}
if 2008<=`year' & `year'<=2018 {
gen byte ybl_all=.
replace ybl_all=1 if (9<=ybl08 & ybl08~=.)
replace ybl_all=2 if ybl08==08
replace ybl_all=3 if ybl08==07
replace ybl_all=4 if ybl08==06
replace ybl_all=5 if ybl08==05
replace ybl_all=6 if ybl08==04
replace ybl_all=7 if ybl08==03
replace ybl_all=8 if ybl08==02
replace ybl_all=9 if ybl08==01
}
lab var ybl_all "Year structure first built"
lab def ybl_all	1 "2005 or later" ///
		2 "2000-04" ///
		3 "1990-99" ///
		4 "1980-89" ///
		5 "1970-79" ///
		6 "1960-69" ///
		7 "1950-59" ///
		8 "1940-49" ///
		9 "1939 or earlier"
lab val ybl_all ybl_all
notes ybl: Consistent for 2005-on
notes ybl: ACS: YBL

/* Gross rent (monthly amount) */

if 2005<=`year' & `year'<=2018 {
gen grntp_adj=round(grntp*adj_h,1) if grntp~=.
replace grntp_adj=. if grntp<1 | 99999<grntp
}
lab var grntp_adj "Gross rent adj ($/month)"
notes grntp_adj: Topcoded according to nominal GRNTP, $99999 annually; data rounded
notes grntp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes grntp_adj: ACS: GRNTP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Has complete kitchen facilities */

gen byte kitchen=.

if 2008<=`year' & `year'<=2018 {
replace kitchen=. if kit<1 | 2<kit
replace kitchen=1 if kit==1
replace kitchen=0 if kit==2
}
lab var kitchen "Complete kitchen"
lab val kitchen noyes
notes kitchen: Complete kitchen: stove/range, refrig, and sink w/ faucet
notes kitchen: ACS: KIT

/* When moved into house or apartment */

if 2005<=`year' & `year'<=2018 {
replace mv=. if mv<1 | 7<mv
}
lab var mv "How long living here (years)"
lab def mv	1 "<=1" ///
		2 ">1-<2" ///
		3 "2-<5" ///
		4 "5-<10" ///
		5 "10-<20" ///
		6 "20-<30" ///
		7 "30+"
lab val mv mv
notes mv: ACS: MV

/* Has complete plumbing facilities */

gen byte plumbing=.

if 2008<=`year' & `year'<=2018 {
replace plumbing=. if plm<1 | 2<plm
replace plumbing=1 if plm==1
replace plumbing=0 if plm==2
}
lab var plumbing "Complete plumbing"
lab val plumbing noyes
notes plumbing: Hot & cold running water, flush toilet, bathtub/shower
notes plumbing: ACS: PLM

/* Selected monthly owner costs */

if 2005<=`year' & `year'<=2018 {
gen smocp_adj=round(smocp*adj_h,1) if smocp~=.
replace smocp_adj=. if smocp<0 | 99999<smocp
}
lab var smocp_adj "Selected monthly owner costs adj ($/month)"
notes smocp_adj: Topcoded according to nominal SMOCP, $99999 annually; data rounded
notes smocp_adj: Uses adjust or adjhsg to adjust to constant calendar year $
notes smocp_adj: ACS: SMOCP, ADJUST (2005-2007), ADJHSG (2008-present)

/* Second mortgage or home equity loan status */

if 2005<=`year' & `year'<=2018 {
replace smx=. if smx<1 | 4<smx
}
lab var smx "2nd mortgage, HEL status"
lab def smx	1 "Yes, a second mortgage" ///
		2 "Yes, a home equity loan" ///
		3 "No" ///
		4 "Both, 2nd mortgage & HEL"
lab val smx smx
notes smx: ACS: SMX


/* Specified rent unit */

if 2005<=`year' & `year'<=2018 {
replace srnt=. if srnt<0 | 1<srnt
}
lab var srnt "Specified rent unit"
lab val srnt noyes
notes srnt: ACS: SRNT


/* Specified value owner unit */

if 2005<=`year' & `year'<=2018 {
replace sval=. if sval<0 | 1<sval
}
lab var sval "Specified value owner unit"
lab val sval noyes
notes sval: ACS: SVAL

/* Property tax (yearly amount, unbracketed) */

if 2005<=`year' & `year'<=2017 {
gen taxp_amt=.
}
if `year'==2018 {
gen taxp_amt=taxamt if 0<=taxamt & taxamt<=22500
}
lab var taxp_amt "Property Tax, ($/Yr) - unbracketed"
notes taxp_amt: ACS: TAXAMT
notes taxp_amt: Available 2018
notes taxp_amt: Topcoded using state-level thresholds and values


/* Property tax (yearly amount, bracketed) */

if 2005<=`year' & `year'<=2017 {
replace taxp=. if taxp<1 | 68<taxp
}
if `year'==2018 {
gen taxp=. /* if taxamt~=. */
replace taxp=1 if taxamt==0	
replace taxp=2 if 1<=taxamt & taxamt<=49
replace taxp=3 if 50<=taxamt & taxamt<=99
replace taxp=4 if 100<=taxamt & taxamt<=149
replace taxp=5 if 150<=taxamt & taxamt<=199
replace taxp=6 if 200<=taxamt & taxamt<=249
replace taxp=7 if 250<=taxamt & taxamt<=299
replace taxp=8 if 300<=taxamt & taxamt<=349
replace taxp=9 if 350<=taxamt & taxamt<=399
replace taxp=10 if 400<=taxamt & taxamt<=449
replace taxp=11 if 450<=taxamt & taxamt<=499
replace taxp=12 if 500<=taxamt & taxamt<=549
replace taxp=13 if 550<=taxamt & taxamt<=599
replace taxp=14 if 600<=taxamt & taxamt<=649
replace taxp=15 if 650<=taxamt & taxamt<=699
replace taxp=16 if 700<=taxamt & taxamt<=749
replace taxp=17 if 750<=taxamt & taxamt<=799
replace taxp=18 if 800<=taxamt & taxamt<=849
replace taxp=19 if 850<=taxamt & taxamt<=899
replace taxp=20 if 900<=taxamt & taxamt<=949
replace taxp=21 if 950<=taxamt & taxamt<=999
replace taxp=22 if 1000<=taxamt & taxamt<=1099
replace taxp=23 if 1100<=taxamt & taxamt<=1199
replace taxp=24 if 1200<=taxamt & taxamt<=1299
replace taxp=25 if 1300<=taxamt & taxamt<=1399
replace taxp=26 if 1400<=taxamt & taxamt<=1499
replace taxp=27 if 1500<=taxamt & taxamt<=1599
replace taxp=28 if 1600<=taxamt & taxamt<=1699
replace taxp=29 if 1700<=taxamt & taxamt<=1799
replace taxp=30 if 1800<=taxamt & taxamt<=1899
replace taxp=31 if 1900<=taxamt & taxamt<=1999
replace taxp=32 if 2000<=taxamt & taxamt<=2099
replace taxp=33 if 2100<=taxamt & taxamt<=2199
replace taxp=34 if 2200<=taxamt & taxamt<=2299
replace taxp=35 if 2300<=taxamt & taxamt<=2399
replace taxp=36 if 2400<=taxamt & taxamt<=2499
replace taxp=37 if 2500<=taxamt & taxamt<=2599
replace taxp=38 if 2600<=taxamt & taxamt<=2699
replace taxp=39 if 2700<=taxamt & taxamt<=2799
replace taxp=40 if 2800<=taxamt & taxamt<=2899
replace taxp=41 if 2900<=taxamt & taxamt<=2999
replace taxp=42 if 3000<=taxamt & taxamt<=3099
replace taxp=43 if 3100<=taxamt & taxamt<=3199
replace taxp=44 if 3200<=taxamt & taxamt<=3299
replace taxp=45 if 3300<=taxamt & taxamt<=3399
replace taxp=46 if 3400<=taxamt & taxamt<=3499
replace taxp=47 if 3500<=taxamt & taxamt<=3599
replace taxp=48 if 3600<=taxamt & taxamt<=3699
replace taxp=49 if 3700<=taxamt & taxamt<=3799
replace taxp=50 if 3800<=taxamt & taxamt<=3899
replace taxp=51 if 3900<=taxamt & taxamt<=3999
replace taxp=52 if 4000<=taxamt & taxamt<=4099
replace taxp=53 if 4100<=taxamt & taxamt<=4199
replace taxp=54 if 4200<=taxamt & taxamt<=4299
replace taxp=55 if 4300<=taxamt & taxamt<=4399
replace taxp=56 if 4400<=taxamt & taxamt<=4499
replace taxp=57 if 4500<=taxamt & taxamt<=4599
replace taxp=58 if 4600<=taxamt & taxamt<=4699
replace taxp=59 if 4700<=taxamt & taxamt<=4799
replace taxp=60 if 4800<=taxamt & taxamt<=4899
replace taxp=61 if 4900<=taxamt & taxamt<=4999
replace taxp=62 if 5000<=taxamt & taxamt<=5499
replace taxp=63 if 5500<=taxamt & taxamt<=5999
replace taxp=64 if 6000<=taxamt & taxamt<=6999
replace taxp=65 if 7000<=taxamt & taxamt<=7999
replace taxp=66 if 8000<=taxamt & taxamt<=8999
replace taxp=67 if 9000<=taxamt & taxamt<=9999
replace taxp=68 if 10000<=taxamt
}
#delimit ;
lab def taxp
1 "None"
2 "$1-49"
3 "$50-99"
4 "$100-149"
5 "$150-199"
6 "$200-249"
7 "$250-299"
8 "$300-349"
9 "$350-399"
10 "$400-449"
11 "$450-499"
12 "$500-549"
13 "$550-599"
14 "$600-649"
15 "$650-699"
16 "$700-749"
17 "$750-799"
18 "$800-849"
19 "$850-899"
20 "$900-949"
21 "$950-999"
22 "$1000-1099"
23 "$1100-1199"
24 "$1200-1299"
25 "$1300-1399"
26 "$1400-1499"
27 "$1500-1599"
28 "$1600-1699"
29 "$1700-1799"
30 "$1800-1899"
31 "$1900-1999"
32 "$2000-2099"
33 "$2100-2199"
34 "$2200-2299"
35 "$2300-2399"
36 "$2400-2499"
37 "$2500-2599"
38 "$2600-2699"
39 "$2700-2799"
40 "$2800-2899"
41 "$2900-2999"
42 "$3000-3099"
43 "$3100-3199"
44 "$3200-3299"
45 "$3300-3399"
46 "$3400-3499"
47 "$3500-3599"
48 "$3600-3699"
49 "$3700-3799"
50 "$3800-3899"
51 "$3900-3999"
52 "$4000-4099"
53 "$4100-4199"
54 "$4200-4299"
55 "$4300-4399"
56 "$4400-4499"
57 "$4500-4599"
58 "$4600-4699"
59 "$4700-4799"
60 "$4800-4899"
61 "$4900-4999"
62 "$5000-5499"
63 "$5500-5999"
64 "$6000-6999"
65 "$7000-7999"
66 "$8000-8999"
67 "$9000-9999"
68 "$10000+"
;
#delimit cr
lab var taxp "Property Tax, ($/Yr) - bracketed"
notes taxp: Topcode: 10000 annually (2005-2017), 22500 (2018)
notes taxp: Additional topcoding using state-level thresholds in 2018 
notes taxp: no adjustment factor is applied to TAXP
notes taxp: ACS: TAXP, TAXAMT

/* Vehicles available */

if 2005<=`year' & `year'<=2018 {
replace veh=. if 6<veh
}
lab def veh	0 "0" ///
		1 "1" ///
		2 "2" ///
		3 "3" ///
		4 "4" ///
		5 "5" ///
		6 "6+"
lab var veh "Vehicles"
lab val veh veh
notes veh: Vehicles (1 ton or less) available
notes veh: ACS: VEH

/* Internet access */

if 2005<=`year' & `year'<=2012 {
gen byte access=.
}
if 2013<=`year' & `year'<=2018 {
replace access=. if access<1 | access>3
replace access=1 if access==1 | access==2 /* with and without a subscription */
replace access=0 if access==3 /* no internet at house */
}
lab var access "Internet access"
lab val access noyes
notes access: ACS: ACCESS
notes access: Available 2013-on only
notes access: Yes includes with a subscription and without a subscription to service

/* Mobile broadband plan */

if 2005<=`year' & `year'<=2012 {
gen byte broadbnd=.
}
if 2013<=`year' & `year'<=2018 {
replace broadbnd=. if broadbnd<1 | broadbnd>2
replace broadbnd=0 if broadbnd==2
}
lab var broadbnd "Mobile broadband plan"
lab val broadbnd noyes
notes broadbnd: ACS: BROADBND
notes broadbnd: Available 2013-on only

/* Other computer equipment */

if 2005<=`year' & `year'<=2012 {
gen byte compothx=.
}
if 2013<=`year' & `year'<=2018 {
replace compothx=. if compothx<1 | compothx>2
replace compothx=0 if compothx==2
}
lab var compothx "Other computer equipment"
lab val compothx noyes
notes compothx: ACS: COMPOTHX
notes compothx: Available 2013-on only

/* Dial-up service */

if 2005<=`year' & `year'<=2012 {
gen byte dialup=.
}
if 2013<=`year' & `year'<=2018 {
replace dialup=. if dialup<1 | dialup>2
replace dialup=0 if dialup==2
}
lab var dialup "Dial-up service"
lab val dialup noyes
notes dialup: ACS: DIALUP
notes dialup: Available 2013-on only

/* DSL service */

if (2005<=`year' & `year'<=2012) | (2016<=`year' & `year'<=2018) {
gen byte dsl=. 
}
if 2013<=`year' & `year'<=2015 {
replace dsl=. if dsl<1 | dsl>2
replace dsl=0 if dsl==2
}
lab var dsl "DSL service"
lab val dsl noyes
notes dsl: ACS: DSL
notes dsl: Available 2013-2015 only

/* Fiber optic Internet service */

if (2005<=`year' & `year'<=2012) | (2016<=`year' & `year'<=2018) {
gen byte fiberop=.
}
if 2013<=`year' & `year'<=2015 {
replace fiberop=. if fiberop<1 | fiberop>2
replace fiberop=0 if fiberop==2
}
lab var fiberop "Fiber optic Internet service"
lab val fiberop noyes
notes fiberop: ACS: FIBEROP
notes fiberop: Available 2013-2015 only

/* High-speed Internet access (question starting in 2016) */

if 2005<=`year' & `year'<=2015 {
gen hispeed=.
}
if 2016<=`year' & `year'<=2018  {
replace hispeed=. if hispeed<1 | hispeed>2
replace hispeed=0 if hispeed==2
}
lab var hispeed "Broadband Internet service such as cable, fiber optic, or DSL"
lab val hispeed noyes
notes hispeed: ACS: HISPEED
notes hispeed: Available 2016-on only


/* Handheld computer */
* Note: Variable removed from 2016 PUMS 1-year data.

if (2005<=`year' &  `year'<=2012) | (2016<=`year' & `year'<=2018) {
gen byte handheld=.
}
if 2013<=`year' & `year'<=2015 {
replace handheld=. if handheld<1 | handheld>2
replace handheld=0 if handheld==2
}
lab var handheld "Handheld computer"
lab val handheld noyes

notes handheld: ACS: HANDHELD
notes handheld: Available 2013-2015 only

/* Laptop, desktop, notebook computer */

if 2005<=`year' & `year'<=2012 {
gen byte laptop=.
}
if 2013<=`year' & `year'<=2018 {
replace laptop=. if laptop<1 | laptop>2
replace laptop=0 if laptop==2
}
lab var laptop "Laptop, desktop, notebook computer"
lab val laptop noyes

notes laptop: ACS: LAPTOP
notes laptop: Available 2013-on only

/* Cable Internet service */

if (2005<=`year' & `year'<=2012) | (2016<=`year' & `year'<=2018) {
gen byte modem=.
}
if 2013<=`year' & `year'<=2015 {
replace modem=. if modem<1 | modem>2
replace modem=0 if modem==2
}
lab var modem "Cable Internet service"
lab val modem noyes
notes modem: ACS: MODEM
notes modem: Available 2013-2015 only

/* Other Internet service */

if 2005<=`year' & `year'<=2012 {
gen byte othsvcex=.
}
if 2013<=`year' & `year'<=2018 {
replace othsvcex=. if othsvcex<1 | othsvcex>2
replace othsvcex=0 if othsvcex==2
}
lab var othsvcex "Other Internet service"
lab val othsvcex noyes
notes othsvcex: ACS: OTHSVCEX
notes othsvcex: Available 2013-on only

/* Satellite Internet service */

if 2005<=`year' & `year'<=2012 {
gen byte satellite=.
}
if 2013<=`year' & `year'<=2018 {
replace satellite=. if satellite<1 | satellite>2
replace satellite=0 if satellite==2
}
lab var satellite "Satellite Internet service"
lab val satellite noyes
notes satellite: ACS: SATELLITE
notes satellite: Available 2013-on only

/* Smartphone */

if `year'<=2015 {
gen smartphone=.
}
if 2016<=`year' & `year'<=2018 {
replace smartphone=. if smartphone<1 | smartphone>2
replace smartphone=0 if smartphone==2
}
lab var smartphone "Smartphone"
lab val smartphone noyes
notes smartphone: ACS: SMARTPHONE
notes smartphone: Available 2016-on only

/* Tablet */

if `year'<=2015 {
gen tablet=.
}
if 2016<=`year' & `year'<=2018 {
replace tablet=. if tablet<1 | tablet>2
replace tablet=0 if tablet==2
}
lab var tablet "Tablet or other portable wireless computer"
lab val tablet noyes
notes tablet: ACS: TABLET
notes tablet: Available 2016-on only



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

