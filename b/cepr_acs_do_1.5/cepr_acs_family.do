set more 1

/*
File:	cepr_acs_family.do
Date:	Aug 18, 2011
	Oct 26, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent family-relationship variables for CEPR extract
        of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Marital status */

if 2005<=`year' & `year'<=2018 {
replace mar=. if mar<1
replace mar=. if 5<mar
}
lab def mar	1 "Married" ///
		2 "Widowed" ///
		3 "Divorced" ///
		4 "Separated" ///
		5 "Never Married"
lab var mar "Marital status"
lab val mar mar
notes mar: ACS: MAR

if 2005<=`year' & `year'<=2018 {
gen byte married=0 if mar~=.
replace married=1 if mar==1
}
lab var married "Married"
lab val married noyes
notes married: ACS: Derived: MAR


/* Relationship */

	/* Consistent 2005-present */
if 2005<=`year' & `year'<=2007 {
gen byte rel05=rel
replace rel05=. if 12<rel
}
if 2008<=`year' & `year'<=2009 {
gen rel05=.
replace rel05=0 if rel==0
replace rel05=1 if rel==1
replace rel05=2 if rel==2 | rel==3 | rel==4
replace rel05=3 if rel==5
replace rel05=4 if rel==6
replace rel05=5 if rel==7
replace rel05=6 if rel==8 | rel==9
replace rel05=7 if rel==10
replace rel05=8 if rel==11
replace rel05=9 if rel==12
replace rel05=10 if rel==13
replace rel05=11 if rel==14
replace rel05=12 if rel==15
}
if 2010<=`year' & `year'<=2018 {
gen rel05=.
replace rel05=0 if relp==0
replace rel05=1 if relp==1
replace rel05=2 if relp==2 | relp==3 | relp==4
replace rel05=3 if relp==5
replace rel05=4 if relp==6
replace rel05=5 if relp==7
replace rel05=6 if relp==8 | relp==9
replace rel05=7 if relp==10
replace rel05=8 if relp==11
replace rel05=9 if relp==12
replace rel05=10 if relp==13
replace rel05=11 if relp==14
replace rel05=12 if relp==15
}
lab def rel05	0 "Reference person" ///
		1 "Husband/wife" ///
		2 "Son/daughter" /// Includes adopted and step
		3 "Brother/sister" ///
		4 "Father/mother" ///
		5 "Grandchild" ///
		6 "In-law" /// Includes parent, son, and daughter in-law
		7 "Other relative" ///
		8 "Roomer/boarder" ///
		9 "Housemate/roommate" ///
		10 "Unmarried partner" ///
		11 "Foster child" ///
		12 "Other nonrelative"
lab var rel05 "Relationship"
lab val rel05 rel05
notes rel05: ACS: REL, RELP in 2010-on
	
	/* Consistent for 2008-present */
if 2005<=`year' & `year'<=2007 {
gen byte rel08=.
}
if 2008<=`year' & `year'<=2009 {
gen byte rel08=rel
replace rel08=. if 15<rel
}
if 2010<=`year' & `year'<=2018 {
gen byte rel08=relp
replace rel08=. if 15<relp
}
lab def rel08	0 "Reference person" ///
		1 "Husband/wife" ///
		2 "Biological son/daughter" ///
		3 "Adopted son/daughter" ///
		4 "Stepson/daughter" ///
		5 "Brother/sister" ///
		6 "Father/mother" ///
		7 "Grandchild" ///
		8 "Parent-in-law" ///
		9 "Son-in-law or daughter-in-law" ///
		10 "Other relative" ///
		11 "Roomer or boarder" ///
		12 "Housemate or roommate" ///
		13 "Unmarried partner" ///
		14 "Foster child" ///
		15 "Other nonrelative"
lab var rel08 "Relationship"
lab val rel08 rel08
notes rel08: ACS: REL, RELP in 2010-on


/* Subfamily relationship */

if 2005<=`year' & `year'<=2018 {
replace sfr=. if sfr<1
replace sfr=. if 6<sfr
}
lab def sfr	1 "Husband/wife no children" ///
		2 "Husband/wife with children" ///
		3 "Parent in a parent/child subfamily" ///
		4 "Child in a married-couple subfamily" ///
		5 "Child in a mother-child subfamily" ///
		6 "Child in a father-child subfamily"
lab var sfr "Subfamily relationship"
lab val sfr sfr
notes sfr: ACS: SFR


/* Presence of subfamilies in household */

if 2005<=`year' & `year'<=2018 {
replace psf=. if 1<psf
}
lab var psf "Presence of subfamilies in HH"
lab val psf noyes
notes psf: ACS: PSF


/* Household/ family type */

if 2005<=`year' & `year'<=2018 {
replace hht=. if hht<1
replace hht=. if 7<hht
}
lab def hht	1 "Married-couple household" ///
		2 "Male householder, no wife present" ///
		3 "Female householder, no husband present" ///
		4 "Male householder, Living alone" ///
		5 "Male householder, Not living alone" ///
		6 "Female householder, Living alone" ///
		7 "Female householder, Not living alone"
lab var hht "Household/family type"
lab val hht hht
notes hht: ACS: HHT


/* Unmarried partner household */

if 2005<=`year' & `year'<=2006 {
replace partner=. if partner<0 | partner>4
}
if 2007<=`year' & `year'<=2018 {
gen byte partner07=.
replace partner07=partner if partner~=.
replace partner07=. if partner<0 | partner>4
replace partner07=3 if partner==4
replace partner07=4 if partner==3

drop partner
rename partner07 partner
}
lab def partner	0 "No unmarried partner" ///
		1 "Male householder, male partner" ///
		2 "Male householder, female partner" ///
		3 "Female householder, male partner" ///
		4 "Female householder, female partner" 		
lab var partner "Unmarried partner household"
lab val partner partner
notes partner: ACS: PARTNER


/* Persons in household */

if 2005<=`year' & `year'<=2018 {
gen byte perhh=np if np~=.
replace perhh=. if 20<perhh
}
lab var perhh "Number of persons in household"
notes perhh: ACS: NP

/* Presence of household members age 60+ */

if 2005<=`year' & `year'<=2018 {
gen byte hh60=r60 if r60~=.
replace hh60=. if 2<r60
}
lab def hh60	0 "0" ///
		1 "1" ///
		2 "2+"
lab var hh60 "Presence of HH members age 60+"
lab val hh60 hh60
notes hh60: ACS: R60

/* Presence of household members age 65+ */

if 2005<=`year' & `year'<=2018 {
gen byte hhsenior=r65 if r65~=.
replace hhsenior=. if 2<r65
}
lab def hhsenior	0 "0" ///
			1 "1" ///
			2 "2+"
lab var hhsenior "Presence of HH members age 65+"
lab val hhsenior hhsenior
notes hhsenior: ACS: R65

/* Number of workers in family */

if 2005<=`year' & `year'<=2018 {
replace wif=. if 3<wif
}
lab def wif	0 "0" ///
		1 "1" ///
		2 "2" ///
		3 "3+"
lab var wif "Number of workers in family"
lab val wif wif
notes wif: ACS: WIF

/* Family type and employment status */

if 2005<=`year' & `year'<=2018 {
replace fes=. if fes<1
replace fes=. if 8<fes
}
lab def fes	1 "Married-couple fam: Husband and wife in LF" ///
		2 "Married-couple fam: Husband only in LF" ///
		3 "Married-couple fam: Wife only in LF" ///
		4 "Married-couple fam: Neither husband nor wife in LF" ///
		5 "Other family: Male householder, no wife present, in LF" ///
		6 "Other family: Male householder, no wife present, not in LF" ///
		7 "Other family: Female householder, no husband present, in LF" ///
		8 "Other family: Female householder, no husband present, not in LF"
lab var fes "Family and Employment Status"
lab val fes fes
notes fes: ACS: FES

/* Work experience of householder and spouse */

if 2005<=`year' & `year'<=2018 {
replace wkexrel=. if wkexrel<1
replace wkexrel=. if 15<wkexrel
}
lab def wkexrel	1 "Householder and spouse worked FT" ///
		2 "Householder worked FT; spouse worked < FT" ///
		3 "Householder worked FT; spouse did not work" ///
		4 "Householder worked < FT; spouse worked FT" ///
		5 "Householder worked < FT; spouse worked < FT" ///
		6 "Householder worked < FT; spouse did not work" ///
		7 "Householder did not work; spouse worked FT" ///
		8 "Householder did not work; spouse worked < FT" ///
		9 "Householder did not work; spouse did not work" ///
		10 "Male householder worked FT; no spouse present" ///
		11 "Male householder worked < FT; no spouse present" ///
		12 "Male householder did not work; no spouse present" ///
		13 "Female householder worked FT; no spouse present" ///
		14 "Female householder worked < FT; no spouse present" ///
		15 "Female householder did not work; no spouse present"
lab var wkexrel "Work experience of householder, spouse"
lab val wkexrel wkexrel
notes wkexrel: ACS: WKEXREL

/* Employment status of parents */

if 2005<=`year' & `year'<=2018 {
replace esp=. if esp<1
replace esp=. if 8<esp
}
lab def esp	1 "Both parents in LF" ///
		2 "Father only in LF" ///
		3 "Mother only in LF" ///
		4 "Neither parent in LF" ///
		5 "Living w/ father only: Father in LF" ///
		6 "Living w/ father only: Father not in LF" ///
		7 "Living w/ mother only: Mother in LF" ///
		8 "Living w/ mother only: Mother not in LF"
lab var esp "Employment status of parents"
lab val esp esp
notes esp: ACS: ESP

/* Number of persons in family */

if `year'==2014 {
/* npf is str2 in 2014 */
destring npf, replace
}
if 2005<=`year' & `year'<=2018 {
gen byte perfam=npf if npf~=.
replace perfam=. if 20<npf
}
lab var perfam "Number of persons in family"
notes perfam: ACS: NPF

/* Number of own children in household */

if `year'==2014 {
/* noc is str2 in 2014 */
destring noc, replace
}
if 2005<=`year' & `year'<=2018 {
replace noc=. if 19<noc
}
lab var noc "Number of own children"
notes noc: ACS: NOC

/* Household presence and age of own children */

if 2005<=`year' & `year'<=2018 {
gen byte hhoc=hupaoc if hupaoc~=.
replace hhoc=. if hhoc<1
replace hhoc=. if 4<hhoc
}
lab def hhoc	1 "Presence of own children <6" ///
		2 "Presence of own children 6-17 only" ///
		3 "Presence of own children <6 and 6-17" ///
		4 "No own children present"
lab var hhoc "Presence and age of own children"
lab val hhoc hhoc
notes hhoc: ACS: HUPAOC 

/* Number of related children in household */

if `year'==2014 {
/* nrc is str2 in 2014 */
destring nrc, replace
}
if 2005<=`year' & `year'<=2018 {
replace nrc=. if 19<nrc
gen byte nfchild=nrc if nrc~=.
}
lab var nfchild "Number of related children"
notes nfchild: ACS: NRC

/* Presence of household members under 18 */

if 2005<=`year' & `year'<=2018 {
gen byte hhchild=.
replace hhchild=0 if r18==0
replace hhchild=1 if r18==1
}
lab var hhchild "HH members under 18"
lab val hhchild noyes
notes hhchild: ACS: R18

/* Number of household members under 18 */

if 2005<=`year' & `year'<=2018 {
egen nhhchild=total(age<=17), by(serialno)
}
lab var nhhchild "Number of HH members under 18"
notes nhhchild: ACS: derived: NOC NRC

/* Household presence and age of related children */

if 2005<=`year' & `year'<=2018 {
gen byte hhrc=huparc if huparc~=.
replace hhrc=. if hhrc<1
replace hhrc=. if 4<hhrc
}
lab def hhrc	1 "Presence of related children <6" ///
		2 "Presence of related children 6-17 only" ///
		3 "Presence of related children <6 and 6-17" ///
		4 "No related children present"
lab var hhrc "Presence and age of related children"
lab val hhrc hhrc
notes hhrc: ACS: HUPARC

/* Grandchild living in household */

if 2005<=`year' & `year'<=2018 {
gen byte hhgc=.
replace hhgc=0 if gcl==2
replace hhgc=1 if gcl==1
}
lab var hhgc "Grandchild living in HH"
lab val hhgc noyes
notes hhgc: ACS: GCL

/* Child indicator */

if 2005<=`year' & `year'<=2018 {
gen byte child=0 if hupac~=.
replace child=1 if 1<=hupac & hupac<=3
}
lab var child "Child indicator"
lab val child noyes
notes child: ACS: HUPAC

/* Presence of nonrelative in household */

if 2005<=`year' & `year'<=2018 {
replace nr=. if 1<nr
}
lab var nr "Presence of nonrelative"
lab val nr noyes
notes nr: ACS: NR

/* Gave birth within past year */

if 2005<=`year' & `year'<=2018 {
replace fer=0 if fer==2
}
lab var fer "Gave birth within past year"
lab val fer noyes
notes fer: ACS: FER
notes fer: Only asked if female, aged 15-50

/* Multigenerational household */

if 2005<=`year' & `year'<=2007 {
gen byte multgen=.
}
if 2008<=`year' & `year'<=2018 {
gen byte multgen=.
replace multgen=1 if multg==2
replace multgen=0 if multg==1
}
lab var multgen "Multigenerational household"
lab val multgen noyes
notes multgen: ACS: MULTG
notes multgen: Not available 2005-2007

/* Grandparent headed household with no parent present */

if 2005<=`year' & `year'<=2018 {
replace npp=. if 1<npp
}
lab var npp "Grandparent headed household, no parent present"
lab val npp noyes
notes npp: ACS: NPP

/* Responsible for grandchildren */

if 2005<=`year' & `year'<=2018 {
replace gcr=. if 2<gcr
replace gcr=0 if gcr==2
}
lab var gcr "Responsible for grandchildren"
lab val gcr noyes
notes gcr: ACS: GCR

/* Same-sex married couple */

if 2005<=`year' & `year'<=2012 {
gen byte ssmc=.
}
if 2013<=`year' & `year'<=2018 {
replace ssmc=. if 2<ssmc
replace ssmc=1 if ssmc==1 | ssmc==2
}
lab var ssmc "Same-sex married couple"
lab val ssmc noyes
notes ssmc: ACS: SSMC
notes ssmc: Yes includes couples where not all relevant data shown as reported /*
*/ and all other same-sex married couple households
notes ssmc: Available 2013-on only

/*
Same-Sex Married Couples Edit Change in 2013 ACS PUMS Files

"The recode for same-sex spouse, SSPA, in the 2012 ACS PUMS data file included those
same-sex spouses with valid reported data for both partners' relationship and sex.
(The two categories for SSPA were "Spouse not changed" and "Spouse changed to 
unmarried partner.")

Beginning in 2013, the edit was changed to output same-sex married couples rather
than changing their relationship to "unmarried partner." Starting with the
2013 ACS PUMS, the same-sex married couple household recode, SSMC, will include
those couples in SSPA (SSMC=2 "All other same-sex married-couple households"), as
well as those logically allocated as same-sex married couples
(SSMC=1 "Same-sex married-couple household where not all relevant data shown as reported"),
who were missing valid responses for either sex or relationship."

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
