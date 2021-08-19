set more 1

/*
File:	cepr_acs_demog.do
Date:	Aug 16, 2011
	Oct 26, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent demographic variables for CEPR extract
        of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Age */

if 2005<=`year' & `year'<=2018 {
replace agep=. if agep<0
replace agep=. if 99<agep
gen byte age=agep if agep~=.
}
lab var age "Age"
notes age: Topcoded: 99
notes age: ACS: AGEP

/* Gender */

if 2005<=`year' & `year'<=2018 {
gen byte female=0 if sex==1 | sex==2
replace female=1 if sex==2
}
lab var female "Female"
lab val female noyes
notes female: ACS: derived: SEX

/* Race and ethnicity */

if 2005<=`year' & `year'<=2018 {
replace rac1p=. if rac1p<1
replace rac1p=. if 9<rac1p
}
lab var rac1p "Race/Ethnicity"
#delimit ;
lab def rac1p	
1 "White alone"
2 "Black alone"
3 "American Indian alone"
4 "Alaskan Native alone"
5 "Am Indian and Alaskan Native tribes specified"
6 "Asian alone"
7 "Native Hawaiian and other PI alone"
8 "Some other race alone"
9 "2+ major race groups"
;
#delimit cr
lab val rac1p rac1p
notes rac1p: ACS: RAC1P

if 2005<=`year' & `year'<=2011 {
gen rac2p2005=rac2p
replace rac2p2005=. if rac2p<1
replace rac2p2005=. if 67<rac2p
}
if 2012<=`year' & `year'<=2018 {
gen byte rac2p2005=.
}
lab var rac2p2005 "Race/Ethnicity 2"
#delimit ;
lab def rac2p2005
1 "White alone"
2 "Black or African Americana alone"
3 "Apache alone"
4 "Blackfeet alone"
5 "Cherokee alone"
6 "Cheyenne alone"
7 "Chickasaw alone"
8 "Chippewa alone"
9 "Choctaw alone"
10 "Colville alone"
11 "Comanche alone"
12 "Creek alone"
13 "Crow alone"
14 "Delaware alone"
15 "Houma alone"
16 "Iroquois alone"
17 "Lumbee alone"
18 "Menominee alone"
19 "Navajo alone"
20 "Paiute alone"
21 "Pima alone"
22 "Potawatomi alone"
23 "Pueblo alone"
24 "Puget Sound Salish alone"
25 "Seminole alone"
26 "Sioux alone"
27 "Tohono O'Odham alone"
28 "Yakima alone"
29 "Yaqui alone"
30 "Yuman alone"
31 "Other specified American Indian tribes alone"
32 "Combination of American Indian tribes only"
33 "American Indian or Alaska Native, tribe n.s., or both"
34 "Alaskan Athabascan alone"
35 "Aleut alone"
36 "Eskimo (05-09) or Inupiat (10-11) alone"
37 "Tlingit-Haida alone"
38 "Alaska Native tribes alone or in combination with other N.A. tribes"
39 "American Indian or Alaska Native, n.s."
40 "Asian Indian alone"
41 "Bangladeshi alone"
42 "Cambodian alone"
43 "Chinese alone"
44 "Filipino alone"
45 "Hmong alone"
46 "Indonesian alone"
47 "Japanese alone"
48 "Korean alone"
49 "Laotian alone"
50 "Malaysian alone"
51 "Pakistani alone"
52 "Sri Lankan alone"
53 "Thai alone"
54 "Vietnamese alone"
55 "Other specified Asian alone"
56 "Asian, n.s."
57 "Combination of Asian groups only"
58 "Native Hawaiian alone"
59 "Samoan alone"
60 "Tongan alone"
61 "Other Polynesian alone or in combination"
62 "Guamanian or Chamorro alone"
63 "Other Micronesian alone or in combination"
64 "Melanesian alone or in combination"
65 "Other Native Hawaiian and Other Pacific Islander alone or in combination"
66 "Some other race alone"
67 "Two or more races"
;
#delimit cr
lab val rac2p2005 rac2p2005
notes rac2p2005: ACS: RAC2P
notes rac2p2005: Available 2005-2011
notes rac2p2005: Value 36 is "Eskimo Alone" in 2005-2009, "Inupiat alone" in 2010-2011


if 2005<=`year' & `year'<=2011 {
gen byte rac2p2012=.
}
if 2012<=`year' & `year'<=2018 {
rename rac2p rac2p2012
replace rac2p2012=. if rac2p2012<1
replace rac2p2012=. if 68<rac2p2012
}
lab var rac2p2012 "Race/Ethnicity 2"
#delimit ;
lab def rac2p2012
1 "White alone"
2 "Black or African American alone"
3 "Apache alone"
4 "Blackfeet alone"
5 "Cherokee alone"
6 "Cheyenne alone"
7 "Chickasaw alone"
8 "Chippewa alone"
9 "Choctaw alone"
10 "Comanche alone"
11 "Creek alone"
12 "Crow alone"
13 "Hopi alone"
14 "Iroquois alone"
15 "Lumbee alone"
16 "Mexican Amerian Indian alone"
17 "Navajo alone"
18 "Pima alone"
19 "Potawatomi alone"
20 "Pueblo alone"
21 "Puget Sound Salish alone"
22 "Seminole alone"
23 "Sioux alone"
24 "South American Indian alone"
25 "Tohono O'Odham alone"
26 "Yaqui alone"
27 "Other specified American Indian tribes alone"
28 "All other specified American Indian tribe combinations"
29 "American Indian tribe n.s."
30 "Alaskan Athabascan alone"
31 "Tlingit-Haida alone"
32 "Inupiat alone"
33 "Yup'ik alone"
34 "Aleut alone"
35 "Other Alaska Native"
36 "Other American Indian and Alaska Native specified"
37 "American Indian and Alaska Native, n.s."
38 "Asian Indian alone"
39 "Bangladeshi alone"
40 "Bhutanese alone"
41 "Burmese alone"
42 "Cambodian alone"
43 "Chinese, except Taiwanese, alone"
44 "Taiwanese alone"
45 "Filipino alone"
46 "Hmong alone"
47 "Indonesian alone"
48 "Japanese alone"
49 "Korean alone"
50 "Laotian alone"
51 "Malaysian alone"
52 "Mongolian alone"
53 "Nepalese alone"
54 "Pakistani alone"
55 "Sri Lankan alone"
56 "Thai alone"
57 "Vietnamese alone"
58 "Other Asian alone"
59 "All combinations of Asian races only"
60 "Native Hawaiian alone"
61 "Samoan alone"
62 "Tongan alone"
63 "Guamanian or Chamorro alone"
64 "Marshallese alone"
65 "Fijian alone"
66 "Other Native Hawaiian and Other Pacific Islander"
67 "Some other race alone"
68 "Two or more races"
;
#delimit cr
lab val rac2p2012 rac2p2012
notes rac2p2012: ACS: RAC2P
notes rac2p2012: Available 2012-on only

if 2005<=`year' & `year'<=2011 {
gen rac3p2005=rac3p
replace rac3p2005=. if rac3p<1
replace rac3p2005=. if 72<rac3p
}
if 2012<=`year' & `year'<=2018 {
gen byte rac3p2005=.
}
lab var rac3p2005 "Race/Ethnicity 3"
#delimit ;
lab def rac3p2005
1 "Some other race alone"
2 "Other Pacific Islander alone"
3 "Samoan alone"
4 "Guamanian or Chamorro alone"
5 "Native Hawaiian alone"
6 "Native Hawaiian and Other Pacific Islander groups only"
7 "Other Asian; Some other race"
8 "Other Asian alone"
9 "Vietnamese alone"
10 "Korean alone"
11 "Japanese; Some other race"
12 "Japanese; Native Hawaiian"
13 "Japanese; Korean"
14 "Japanese alone"
15 "Filipino; Some other race"
16 "Filipino; Native Hawaiian"
17 "Filipino; Japanese"
18 "Filipino alone"
19 "Chinese; Some other race"
20 "Chinese; Native Hawaiian"
21 "Chinese; Other Asian"
22 "Chinese; Vietnamese"
23 "Chinese; Japanese"
24 "Chinese; Filipino; Native Hawaiian"
25 "Chinese; Filipino"
26 "Chinese alone"
27 "Asian Indian; Some other race"
28 "Asian Indian; Other Asian"
29 "Asian Indian alone"
30 "Asian and/or Native Hawaiian and Other Pacific Islander; Some other race"
31 "Asian; Native Hawaiian and Other Pacific Islander groups"
32 "Asian groups only"
33 "American Indian and Alaska Native; Some other race"
34 "American Indian and Alaska Native alone"
35 "American Indian and Alaska Native; Asian and/or Native Hawaiian and Other Paciic Islander and/or Some other race"
36 "Black or African American; Some other race"
37 "Black or African American; Other Asian"
38 "Black or African American; Korean"
39 "Black or African American; Japanese"
40 "Black or African American; Filipino"
41 "Black or African American; Chinese"
42 "Black or African American; Asian Indian"
43 "Black or African American; American Indian and Alaska Native"
44 "Black or African American alone"
45 "Black or African American; Native Hawaiian and Other Pacific Islander"
46 "Black or African American; Asian and/or Native Hawaiian and Other Pacific Islander and/or Some other race"
47 "Black or African American; American Indian and Alaska Native; Asian and/ot Native Hawaiian and Other Pacific Islander and/or Some other race"
48 "White; Some other race"
49 "White; Other Pacific Islander"
50 "White; Samoan"
51 "White; Guamanian or Chamorro"
52 "White; Native Hawaiian"
53 "White; Other Asian"
54 "White; Vietnamese"
55 "White; Korean"
56 "White; Japanese; Native Hawaiian"
57 "White; Japanese"
58 "White; Filipino; Native Hawaiian"
59 "White; Filipino"
60 "White; Chinese; Native Hawaiian"
61 "White; Chinese; Filipino; Native Hawaiian"
62 "White; Chinese"
63 "White; Asian Indian"
64 "White; American Indian and Alaska Native; Some other race"
65 "White; American Indian and Alaska Native"
66 "White; Black or African American; Some other race"
67 "White; Black or African American; American Indian and Alaska Native"
68 "White; Black or African American"
69 "White alone"
70 "White; two or more Asian groups"
71 "White; Black or African American and/or American Indian and Alaska Native and/or Asian and/or Native Hawaiian and Other Pacific Islander groups"
72 "White; Some other race; Black or African American and/or American Indian and Alaska Native and/or Asian and/or Native Hawaiian and Other Pacific Islander groups"
;
#delimit cr
lab val rac3p2005 rac3p2005
notes rac3p2005: ACS: RAC3P


if 2005<=`year' & `year'<=2011 {
gen byte rac3p2012=.
}
if 2012<=`year' & `year'<=2018 {
rename rac3p rac3p2012
}
lab var rac3p2012 "Race/Ethnicity 3"
#delimit ;
lab def rac3p2012
001 "White alone"
002 "Black or African American alone"
003 "American Indian and Alaska Native alone"
004 "Asian Indian alone"
005 "Chinese alone"
006 "Filipino alone"
007 "Japanese alone"
008 "Korean alone"
009 "Vietnamese alone"
010 "Other Asian alone"
011 "Native Hawaiian alone"
012 "Guamanian or Chamorro alone"
013 "Samoan alone"
014 "Other Pacific Islander alone"
015 "Some Other Race alone"
016 "White; Black or African American"
017 "White; American Indian and Alaska Native"
018 "White; Asian Indian"
019 "White; Chinese"
020 "White; Filipino"
021 "White; Japanese"
022 "White; Korean"
023 "White; Vietnamese"
024 "White; Other Asian"
025 "White; Native Hawaiian"
026 "White; Guamanian or Chamorro"
027 "White; Samoan"
028 "White; Other Pacific Islander"
029 "White; Some Other Race"
030 "Black or African American; American Indian and Alaska Native"
031 "Black or African American; Asian Indian"
032 "Black or African American; Chinese"
033 "Black or African American; Filipino"
034 "Black or African American; Japanese"
035 "Black or African American; Korean"
036 "Black or African American; Other Asian"
037 "Black or African American; Other Pacific Islander"
038 "Black or African American; Some Other Race"
039 "American Indian and Alaska Native; Asian Indian"
040 "American Indian and Alaska Native; Filipino"
041 "American Indian and Alaska Native; Some Other Race"
042 "Asian Indian; Other Asian"
043 "Asian Indian; Some Other Race"
044 "Chinese; Filipino"
045 "Chinese; Japanese"
046 "Chinese; Korean"
047 "Chinese; Vietnamese"
048 "Chinese; Other Asian"
049 "Chinese; Native Hawaiian"
050 "Filipino; Japanese"
051 "Filipino; Native Hawaiian"
052 "Filipino; Other Pacific Islander"
053 "Filipino; Some Other Race"
054 "Japanese; Korean"
055 "Japanese; Native Hawaiian"
056 "Vietnamese; Other Asian"
057 "Other Asian; Other Pacific Islander"
058 "Other Asian; Some Other Race"
059 "Other Pacific Islander; Some Other Race"
060 "White; Black or African American; American Indian & Alaska Native"
061 "White; Black or African American; Filipino"
062 "White; Black or African American; Some Other Race"
063 "White; American Indian and Alaska Native; Filipino"
064 "White; American Indian and Alaska Native; Some Other Race"
065 "White; Chinese; Filipino"
066 "White; Chinese; Japanese"
067 "White; Chinese; Native Hawaiian"
068 "White; Filipino; Native Hawaiian"
069 "White; Japanese; Native Hawaiian"
070 "White; Other Asian; Some Other Race"
071 "Chinese; Filipino; Native Hawaiian"
072 "White; Chinese; Filipino; Native Hawaiian"
073 "White; Chinese; Japanese; Native Hawaiian"
074 "Black or African American; Asian groups"
075 "Black or African American; Native Hawaiian & Other Pacific Islander groups"
076 "Asian Indian; Asian groups"
077 "Filipino; Asian groups"
078 "White; Black or African American; Asian groups"
079 "White; American Indian and Alaska Native; Asian groups"
080 "White; Native Hawaiian & Other Pacific Islander groups;and/or Some Other Race"
081 "White; Black or African American; American Indian & Alaska Native; Asian groups"
082 "White; Black or African American; American Indian and Alaska Native; and/or Native Hawaiian & Other Pacific Islander groups; and/or Some Other Race"
083 "White; Black or African American; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
084 "White; American Indian and Alaska Native; and/or Asian groups;and/or Native Hawaiian and Other Pacific Islander groups"
085 "White; Chinese; Filipino; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
086 "White; Chinese; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
087 "White; Filipino; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
088 "White; Japanese; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
089 "White; Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
090 "Black or African American; American Indian and Alaska Native;and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
091 "Black or African American; Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
092 "American Indian and Alaska Native; Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
093 "Asian Indian; and/or White; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
094 "Chinese; Japanese; Native Hawaiian; and/or other Asian and/or Pacific Islander groups"
095 "Chinese; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
096 "Filipino; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
097 "Japanese; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
098 "Korean; and/or Vietnamese; and/or Other Asian; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
099 "Native Hawaiian; and/or Pacific Islander groups; and/or Some Other Race"
100 "White; and/or Black or African American; and/or American Indian and Alaska Native; and/or Asian groups; and/or Native Hawaiian and Other Pacific Islander groups; and/or Some Other Race"
;
#delimit cr
lab val rac3p2012 rac3p2012
notes rac3p2012: ACS: rac3p
notes rac3p2012: Availale 2012-on only


		/* Race and ethnicity, CEPR categories */

/* White, Black, Hispanic, Other (WBHO) */

if 2005<=`year' & `year'<=2011 {
gen byte wbho=.
replace wbho=1 if rac3p2005==69
replace wbho=2 if (36<=rac3p2005 & rac3p2005<=47) | (66<=rac3p2005 & rac3p2005<=68) |/*
*/ (71<=rac3p2005 & rac3p2005<=72)
replace wbho=4 if (1<=rac3p2005 & rac3p2005<=35) | (48<=rac3p2005 & rac3p2005<=65) |/*
*/ rac3p2005==70
replace wbho=3 if 2<=hisp & hisp<=24
}
if 2012<=`year' & `year'<=2018 {
gen byte wbho=.
replace wbho=1 if rac3p2012==1
replace wbho=2 if rac3p2012==2 | rac3p2012==16 |/*
*/ (30<=rac3p2012 & rac3p2012<=38) | (60<=rac3p2012 & rac3p2012<=62) |/*
*/ rac3p2012==74 | rac3p2012==75 | rac3p2012==78 |/*
*/ (81<=rac3p2012 & rac3p2012<=83) | rac3p2012==90 | rac3p2012==91 |/*
*/ rac3p2012==100
replace wbho=4 if (003<=rac3p2012 & rac3p2012<=015) |/*
*/ (17<=rac3p2012 & rac3p2012<=29) | (39<=rac3p2012 & rac3p2012<=59) |/*
*/ (63<=rac3p2012 & rac3p2012<=73) | rac3p2012==76 | rac3p2012==77 |/*
*/ rac3p2012==79 | rac3p2012==80 | (84<=rac3p2012 & rac3p2012<=89) |/*
*/ (92<=rac3p2012 & rac3p2012<=99)
replace wbho=3 if 2<=hisp & hisp<=24
}
lab var wbho "Race"
#delimit ;
lab def wbho
1 "White"
2 "Black"
3 "Hispanic"
4 "Other"
;
#delimit cr
lab val wbho wbho
notes wbho: Racial and ethnic categories are mutually exclusive
notes wbho: ACS: RAC3P

/* White, Black, Hispanic, Asian, Other (WBHAO) */

if 2005<=`year' & `year'<=2011 {
gen byte wbhao=.
replace wbhao=1 if rac3p2005==69 /* white alone */
replace wbhao=2 if (36<=rac3p2005 & rac3p2005<=47) /* B and other mix */ /*
*/ | (66<=rac3p2005 & rac3p2005<=68) /* W-B-O, W-B-AI, W-B */ /*
*/ | (71<=rac3p2005 & rac3p2005<=72) /* B and other mix inc W */
replace wbhao=4 if (2<=rac3p2005 & rac3p2005<=32) | (rac3p2005==35) /*
*/ /* A and other mix */ | (49<=rac3p2005 & rac3p2005<=63) /* W-A mix */ /*
*/ | (rac3p2005==70) /* W-two or more A */
replace wbhao=4 if rac1p==6 | rac1p==7 /* aa + pi alone */
replace wbhao=5 if rac3p2005==1 /* some other race alone */ /*
*/ | (33<=rac3p2005 & rac3p2005<=34) /* AI, AI-O */ | rac3p2005==48 /*
*/ /* W-O */ | (64<=rac3p2005 & rac3p2005<=65) /* W-AI, W-AI-O */
replace wbhao=5 if (3<=rac1p & rac1p<=5) /* native american only */
replace wbhao=3 if 2<=hisp & hisp<=24 /* hispanic */
}
if 2012<=`year' & `year'<=2018 {
gen byte wbhao=.
replace wbhao=1 if rac3p2012==1 /* white alone */
replace wbhao=2 if rac3p2012==2 /* black alone */
replace wbhao=2 if rac3p2012==16 /* W-B */ | (30<=rac3p2012 & rac3p2012<=38) /*
*/ /* B-O */ | (60<=rac3p2012 & rac3p2012<=62) /* 3 races incl B-W */ /*
*/ | rac3p2012==74 /* B-A */ | rac3p2012==75 /* B-PI */ | rac3p2012==78 /*
*/ /* W-B-A */ | (81<=rac3p2012 & rac3p2012<=83) /* 4/5 races incl B-W */ /*
*/ | rac3p2012==90 /* 5 races incl B */ | rac3p2012==91 /* 4 races incl B */ /*
*/ | rac3p2012==100 /* 6 races incl B */ 	 	
replace wbhao=4 if (4<=rac3p2012 & rac3p2012<=14) /* aapi alone */
replace wbhao=4 if (18<=rac3p2012 & rac3p2012<=28) /* W-A */ | rac3p2012==39 /*
*/ | rac3p2012==40 /* AI-A */ | (42<=rac3p2012 & rac3p2012<=59) /* A-A or A-O */ /*
*/ | rac3p2012==63 /* W-AI-A */ | (65<=rac3p2012 & rac3p2012<=73) /*
*/ /* W-A-A or W-A-O */ | rac3p2012==76 | rac3p2012==77 /* A-A */ /*
*/ | rac3p2012==79 /* W-AI-A */ | rac3p2012==80 /* W-PI-O */ /*
*/ | (84<=rac3p2012 & rac3p2012<=89) /* 4/5 races incl A-W */ /*	
*/ | (92<=rac3p2012 & rac3p2012<=99) /* 4/5 races incl A */
replace wbhao=4 if rac1p==6 | rac1p==7 /* aa + pi alone */
replace wbhao=5 if rac3p2012==3 /* AI alone */ | rac3p2012==15 /*
*/ /* some other race alone */ | rac3p2012==17 /* W-AI */ | rac3p2012==29 /*
*/ /* W-O */ | rac3p2012==41 /* AI-O */ | rac3p2012==64 /* W-AI-O */
replace wbhao=5 if (3<=rac1p & rac1p<=5) /* native american only */
replace wbhao=3 if 2<=hisp & hisp<=24 /* hispanic */
}
lab var wbhao "Race/Ethnicity, incl. Asian"
#delimit ;
lab def wbhao
1 "White"
2 "Black"
3 "Hispanic"
4 "AAPI"
5 "Other"
;
#delimit cr
lab val wbhao wbhao
notes wbhao: Black includes all respondents listing black; asian includes /*
*/ all respondents listing asian excluding those also listing black; /*
*/ other includes all respondents listing non-white, non-black or /*
*/ non-asian races, excluding those also listing black or asian
notes wbhao: asians include hawaiian/pacific islanders
notes wbhao: Racial and ethnic categories are mutually exclusive
notes wbhao: ACS: RAC3P


/* White, Black, Hispanic, Asian, PI, Native American, Other */

if 2005<=`year' & `year'<=2011 {
gen byte wbhapo=.
replace wbhapo=1 if rac3p2005==69 /* white alone */
replace wbhapo=2 if (36<=rac3p2005 & rac3p2005<=47) /* B and other mix */ /*
*/ | (66<=rac3p2005 & rac3p2005<=68) /* W-B-O, W-B-AI, W-B */ /*
*/ | (71<=rac3p2005 & rac3p2005<=72) /* B and other mix inc W */
replace wbhapo=4 if (7<=rac3p2005 & rac3p2005<=29) /* AA and other mix */ /*
*/ | rac3p2005==32 /* asian groups only */ | (53<=rac3p2005 & rac3p2005<=63) /*
*/ /* W-AA */ | rac3p2005==70 /* W-two or more A */
replace wbhapo=4 if rac1p==6 /* aa alone */
replace wbhapo=5 if (2<=rac3p2005 & rac3p2005<=6) | rac3p2005==12 | rac3p2005==16 /*
*/ | rac3p2005==20 | rac3p2005==24 | (30<=rac3p2005 & rac3p2005<=31) /*
*/ /* PI and other AA */ | (49<=rac3p2005 & rac3p2005<=52) /* W-PI*/ /*
*/ | rac3p2005==56 | rac3p2005==58 | rac3p2005==60 | rac3p2005==61 /* W-AA-PI */
replace wbhapo=5 if rac1p==7 /* pi alone */
replace wbhapo=6 if (33<=rac3p2005 & rac3p2005<=35) /* AI-O */ /*
*/ | (64<=rac3p2005 & rac3p2005<=65) /* W-AI */
replace wbhapo=6 if (3<=rac1p & rac1p<=5) /* native american only */
replace wbhapo=7 if rac3p2005==1 /* some other race alone */ /*
*/ | rac3p2005==48 /* W-O */
replace wbhapo=4 if (2<=hisp & hisp<=24) /* hispanic */
}
if 2012<=`year' & `year'<=2018 {
gen byte wbhapo=.
replace wbhapo=1 if rac3p2012==1 /* white alone */
replace wbhapo=2 if rac3p2012==2 /* black alone */
replace wbhapo=2 if rac3p2012==16 /* W-B */ | (30<=rac3p2012 & rac3p2012<=38) /*
*/ /* B-O */ | (60<=rac3p2012 & rac3p2012<=62) /* 3 races incl B-W */ /*
*/ | rac3p2012==74 /* B-A */ | rac3p2012==75 /* B-PI */ | rac3p2012==78 /*
*/ /* W-B-A */ | (81<=rac3p2012 & rac3p2012<=83) /* 4/5 races incl B-W */ /*
*/ | rac3p2012==90 /* 5 races incl B */ | rac3p2012==91 /* 4 races incl B */ /*
*/ | rac3p2012==100 /* 6 races incl B */ 	 	
replace wbhapo=4 if (4<=rac3p2012 & rac3p2012<=10) /* aa alone */
replace wbhapo=4 if (18<=rac3p2012 & rac3p2012<=24) /* W-AA */ /*
*/ | (42<=rac3p2012 & rac3p2012<=48) | rac3p2012==50 /*
*/ | (53<=rac3p2012 & rac3p2012<=54) | rac3p2012==56 | rac3p2012==58 /*
*/ /* AA-AA or AA-O */ | (65<=rac3p2012 & rac3p2012<=66) /* W-AA-AA */ /*
*/ | rac3p2012==70 /* W-AA-O */| (76<=rac3p2012 & rac3p2012<=77) /* AA-AA */
replace wbhapo=4 if rac1p==6 /* aa alone */
replace wbhapo=5 if (11<=rac3p2012 & rac3p2012<=14) /* pi alone */
replace wbhapo=5 if (25<=rac3p2012 & rac3p2012<=28) /* W-PI */ /*
*/ | rac3p2012==49 | rac3p2012==51 | rac3p2012==52 | rac3p2012==55 /*
*/ | rac3p2012==57 /* AA-PI*/ | rac3p2012==59 /* PI-O */ /*
*/ | (67<=rac3p2012 & rac3p2012<=69) | (71<=rac3p2012 & rac3p2012<=73) /*
*/ /* W-AA-PI or W-AA-AA-PI */ | rac3p2012==80 /* W-PI-O */ /*
*/ | (84<=rac3p2012 & rac3p2012<=89) /* 4/5 races incl PI */ /*
*/ | (92<=rac3p2012 & rac3p2012<=99) /* 5/6 races incl PI */
replace wbhapo=5 if rac1p==7 /* pi alone */
replace wbhapo=6 if rac3p2012==3 /* AI alone */ 
replace wbhapo=6 if rac3p2012==17 /* W-AI */ | (39<=rac3p2012 & rac3p2012<=41) /*
*/ /* AI-AA or AI-Other */ | rac3p2012==63 /* W-AI-A */ | rac3p2012==64 /*
*/ /* W-AI-O*/ | rac3p2012==79 /* W-AI-AA */
replace wbhapo=6 if (3<=rac1p & rac1p<=5) /* native american only */
replace wbhapo=7 if rac3p2012==15 /* some other race alone */ /*
*/ | rac3p2012==29 /* W-O */
replace wbhapo=3 if 2<=hisp & hisp<=24 /* hispanic */
}
lab var wbhapo "Race/Ethnicity, incl. AAPI"
#delimit ;
lab def wbhapo	
1 "White"
2 "Black"
3 "Hispanic"
4 "Asian"
5 "PI"
6 "Native American"
7 "Other"
;
#delimit cr
lab val wbhapo wbhapo
notes wbhapo: Black includes all respondents listing black; asian includes /*
*/ all respondents listing asian excluding those also listing black, pi, and na /*
*/ ; pacific islander includes all respondents listing pi excluding those also /*
*/ listing black and na; native american includes all respondents listing na /*
*/ excluding those also listing black /*
*/ other includes all respondents listing non-white, non-black or /*
*/ non-asian races, excluding those also listing black, asian, pi, or na
notes wbhapo: Racial and ethnic categories are mutually exclusive
notes wbhapo: ACS: RAC3P


/* White, Black, Hispanic, Asian, PI, Native American, Mixed */

if 2005<=`year' & `year'<=2018 {
gen byte wbhapom=.
replace wbhapom=1 if rac1p==1 /* white alone */
replace wbhapom=2 if rac1p==2 /* black alone */
replace wbhapom=4 if rac1p==6 /* asian alone */
replace wbhapom=5 if rac1p==7 /* NH and PI alone */
replace wbhapom=6 if 3<=rac1p & rac1p<=5 /* AI alone */
replace wbhapom=7 if (rac1p==8 | rac1p==9) /*
*/ /* some other race alone; 2+ major race groups */
replace wbhapom=3 if 2<=hisp & hisp<=24 /* hispanic */
}
lab var wbhapom "Race, incl. AAPI and Mixed"
#delimit ;
lab def wbhapom	
1 "White alone"
2 "Black alone"
3 "Hispanic"
4 "Asian alone"
5 "PI alone"
6 "Native American alone"
7 "Other (incl mixed)"
;
#delimit cr
lab val wbhapom wbhapom
notes wbhapom: black, white, asian, pi, and na exclude all repondents /*
*/ listing more than one race
notes wbhapom: Racial and ethnic categories are mutually exclusive
notes wbhapom: ACS: RAC3P


			/* Race and Ethnicity, AAPI, CEPR categories */

/* AAPI */

if 2005<=`year' & `year'<=2018 {
gen byte aapi=0
replace aapi=1 if wbhapom==4 | wbhapom==5
}
lab var aapi "AAPI alone"
lab def aapi 1 "AAPI" 0 "Not AAPI"
notes aapi: ACS: Derived: RAC3P

/* Asian */

if 2005<=`year' & `year'<=2018 {
gen byte asian=0
replace asian=1 if wbhapom==4
}
lab var asian "Asian alone"
lab val asian noyes
notes asian: ACS: Derived: RAC3P

/* Asian detailed */

if 2005<=`year' & `year'<=2011 {
gen byte asian_d2005=.
replace asian_d2005=1 if rac2p2005==40
replace asian_d2005=2 if rac2p2005==41
replace asian_d2005=3 if rac2p2005==42
replace asian_d2005=4 if rac2p2005==43
replace asian_d2005=5 if rac2p2005==44
replace asian_d2005=6 if rac2p2005==45
replace asian_d2005=7 if rac2p2005==46
replace asian_d2005=8 if rac2p2005==47
replace asian_d2005=9 if rac2p2005==48
replace asian_d2005=10 if rac2p2005==49
replace asian_d2005=11 if rac2p2005==50
replace asian_d2005=12 if rac2p2005==51
replace asian_d2005=13 if rac2p2005==52
replace asian_d2005=14 if rac2p2005==53
replace asian_d2005=15 if rac2p2005==54
replace asian_d2005=16 if rac2p2005==55
replace asian_d2005=17 if rac2p2005==56
replace asian_d2005=18 if rac2p2005==57
replace asian_d2005=. if wbhapom~=4
}
if 2012<=`year' & `year'<=2018 {
gen byte asian_d2005=.
}
#delimit;
lab def asian_d2005
1 "Asian Indian"
2 "Bangladeshi"
3 "Cambodian"
4 "Chinese"
5 "Filipino"
6 "Hmong"
7 "Indonesian"
8 "Japanese"
9 "Korean"
10 "Laotian"
11 "Malaysian"
12 "Pakistani"
13 "Sri Lankan"
14 "Thai"
15 "Vietnamese"
16 "Other specified Asian"
17 "Asian, not specified"
18 "Combination of Asian groups"
;
#delimit cr
lab var asian_d2005 "Asian-detailed"
lab val asian_d2005 asian_d2005
notes asian_d2005: Not included: any mix with Blacks, Hispanics, or PIs
notes asian_d2005: ACS: RAC2P
notes asian_d2005: Available 2005-2011

if 2005<=`year' & `year'<=2011 {
gen byte asian_d2012=.
}
if 2012<=`year' & `year'<=2018 {
gen byte asian_d2012=.
replace asian_d2012=1 if rac2p2012==38
replace asian_d2012=2 if rac2p2012==39
replace asian_d2012=3 if rac2p2012==40
replace asian_d2012=4 if rac2p2012==41
replace asian_d2012=5 if rac2p2012==42
replace asian_d2012=6 if rac2p2012==43
replace asian_d2012=7 if rac2p2012==44
replace asian_d2012=8 if rac2p2012==45
replace asian_d2012=9 if rac2p2012==46
replace asian_d2012=10 if rac2p2012==47
replace asian_d2012=11 if rac2p2012==48
replace asian_d2012=12 if rac2p2012==49
replace asian_d2012=13 if rac2p2012==50
replace asian_d2012=14 if rac2p2012==51
replace asian_d2012=15 if rac2p2012==52
replace asian_d2012=16 if rac2p2012==53
replace asian_d2012=17 if rac2p2012==54
replace asian_d2012=18 if rac2p2012==55
replace asian_d2012=19 if rac2p2012==56
replace asian_d2012=20 if rac2p2012==57
replace asian_d2012=21 if rac2p2012==58
replace asian_d2012=22 if rac2p2012==59
replace asian_d2012=. if wbhapom~=4
}
#delimit;
lab def asian_d2012
1 "Asian Indian"
2 "Bangladeshi"
3 "Bhutanese"
4 "Burmese"
5 "Cambodian"
6 "Chinese, except Taiwanese"
7 "Taiwanese"
8 "Filipino"
9 "Hmong"
10 "Indonesian"
11 "Japanese"
12 "Korean"
13 "Laotian"
14 "Malaysian"
15 "Mongolian"
16 "Nepalese"
17 "Pakistani"
18 "Sri Lankan"
19 "Thai"
20 "Vietnamese"
21 "Other Asian"
22 "All combinations of Asian races"
;
#delimit cr
lab var asian_d2012 "Asian-detailed"
lab val asian_d2012 asian_d2012
notes asian_d2012: ACS: RAC2P
notes asian_d2012: Available 2012-on only

/* Pacific Islander */

if 2005<=`year' & `year'<=2018 {
gen byte pi=0
replace pi=1 if wbhapom==5
}
lab var pi "Pacific Islander only"
lab val pi noyes
notes pi: ACS: Derived RAC3P

/* Pacific Islander detailed */

if 2005<=`year' & `year'<=2011 {
gen byte pi_d2005=.
replace pi_d2005=1 if rac2p2005==58
replace pi_d2005=2 if rac2p2005==59
replace pi_d2005=3 if rac2p2005==60
replace pi_d2005=4 if rac2p2005==61
replace pi_d2005=5 if rac2p2005==62
replace pi_d2005=6 if rac2p2005==63
replace pi_d2005=7 if rac2p2005==64
replace pi_d2005=8 if rac2p2005==65
replace pi_d2005=. if wbhapom~=5
}
if 2012<=`year'& `year'<=2018 {
gen byte pi_d2005=.
}
#delimit;
lab def pi_d2005
1 "Native Hawaiian"
2 "Samoan"
3 "Tongan"
4 "Other Polynesian alone or mixed"
5 "Guamanian or Chamorro"
6 "Other Micronesian alone or mixed"
7 "Melanesian alone or mixed"
8 "Other NH and PI groups alone or mixed"
;
#delimit cr
lab var pi_d2005 "Pacific Islander-detailed (2005-2011)"
lab val pi_d2005 pi_d2005
notes pi_d2005: Not included: any mix with Blacks, Hispanics
notes pi_d2005: ACS: Derived: RAC2P RAC3P
notes pi_d2005: Available 2005-2011

if 2005<=`year' & `year'<=2011 {
gen byte pi_d2012=.
}
if 2012<=`year' & `year'<=2018 {
gen byte pi_d2012=.
replace pi_d2012=1 if rac2p2012==60
replace pi_d2012=2 if rac2p2012==61
replace pi_d2012=3 if rac2p2012==62
replace pi_d2012=4 if rac2p2012==63
replace pi_d2012=5 if rac2p2012==64
replace pi_d2012=6 if rac2p2012==65
replace pi_d2012=7 if rac2p2012==66
replace pi_d2012=. if wbhapom~=5
}
#delimit;
lab def pi_d2012
1 "Native Hawaiian"
2 "Samoan"
3 "Tongan"
4 "Guamanian or Chamorro"
5 "Marshallese"
6 "Fijian"
7 "Other NH and PI groups alone or mixed"
;
#delimit cr
lab var pi_d2012 "Pacific Islander-detailed (2012-present)"
lab val pi_d2012 pi_d2012

notes pi_d2012: Not included: any mix with Blacks, Hispanics
notes pi_d2012: ACS: Derived: RAC2P RAC3P
notes pi_d2012: Available 2012-on only

/* AAPI subgroup */

if 2005<=`year' & `year'<=2018 {
gen byte aapisub=1 if asian==1
replace aapisub=2 if pi==1
}
lab def aapisub 1 "AA" 2 "PI"
lab var aapisub "AAPI subgroup"
lab val aapisub aapisub
notes aapisub: ACS: Derived: RAC3P

/* AAPI subgroup detailed */

if 2005<=`year' & `year'<=2011 {
gen byte aapisub2_2005=1 if asian_d2005==1
replace aapisub2_2005=2 if asian_d2005==2
replace aapisub2_2005=3 if asian_d2005==3
replace aapisub2_2005=4 if asian_d2005==4
replace aapisub2_2005=5 if asian_d2005==5
replace aapisub2_2005=6 if asian_d2005==6
replace aapisub2_2005=7 if asian_d2005==7
replace aapisub2_2005=8 if asian_d2005==8
replace aapisub2_2005=9 if asian_d2005==9
replace aapisub2_2005=10 if asian_d2005==10
replace aapisub2_2005=11 if asian_d2005==11
replace aapisub2_2005=12 if asian_d2005==12
replace aapisub2_2005=13 if asian_d2005==13
replace aapisub2_2005=14 if asian_d2005==14
replace aapisub2_2005=15 if asian_d2005==15
replace aapisub2_2005=16 if asian_d2005==16
replace aapisub2_2005=17 if asian_d2005==17
replace aapisub2_2005=18 if asian_d2005==18
replace aapisub2_2005=19 if pi_d2005==1
replace aapisub2_2005=20 if pi_d2005==2
replace aapisub2_2005=21 if pi_d2005==3
replace aapisub2_2005=22 if pi_d2005==4
replace aapisub2_2005=23 if pi_d2005==5
replace aapisub2_2005=24 if pi_d2005==6
replace aapisub2_2005=25 if pi_d2005==7
replace aapisub2_2005=26 if pi_d2005==8
}
if 2012<=`year' & `year'<=2018 {
gen byte aapisub2_2005=.
}
#delimit;
lab def aapisub2_2005
1 "Asian Indian"
2 "Bangladeshi"
3 "Cambodian"
4 "Chinese"
5 "Filipino"
6 "Hmong"
7 "Indonesian"
8 "Japanese"
9 "Korean"
10 "Laotian"
11 "Malaysian"
12 "Pakistani"
13 "Sri Lankan"
14 "Thai"
15 "Vietnamese"
16 "Other specified Asian"
17 "Asian, n.s."
18 "Combination of Asian groups"
19 "Native Hawaiian"
20 "Samoan"
21 "Tongan"
22 "Other Polynesian alone or mixed"
23 "Guamanian or Chamorro"
24 "Other Micronesian alone or mixed"
25 "Melanesian alone or mixed"
26 "Other NH and PI groups alone or mixed"
;
#delimit cr
lab var aapisub2_2005 "AAPI subgroup detailed"
lab val aapisub2_2005 aapisub2_2005
notes aapisub2_2005: ACS: Derived: RAC3P
notes aapisub2_2005: ACS: Available 2005-2011


if 2005<=`year' & `year'<=2011 {
gen byte aapisub2_2012=.
}
if 2012<=`year'& `year'<=2018 {
gen byte aapisub2_2012=1 if asian_d2012==1
replace aapisub2_2012=2 if asian_d2012==2
replace aapisub2_2012=3 if asian_d2012==3
replace aapisub2_2012=4 if asian_d2012==4
replace aapisub2_2012=5 if asian_d2012==5
replace aapisub2_2012=6 if asian_d2012==6
replace aapisub2_2012=7 if asian_d2012==7
replace aapisub2_2012=8 if asian_d2012==8
replace aapisub2_2012=9 if asian_d2012==9
replace aapisub2_2012=10 if asian_d2012==10
replace aapisub2_2012=11 if asian_d2012==11
replace aapisub2_2012=12 if asian_d2012==12
replace aapisub2_2012=13 if asian_d2012==13
replace aapisub2_2012=14 if asian_d2012==14
replace aapisub2_2012=15 if asian_d2012==15
replace aapisub2_2012=16 if asian_d2012==16
replace aapisub2_2012=17 if asian_d2012==17
replace aapisub2_2012=18 if asian_d2012==18
replace aapisub2_2012=19 if asian_d2012==19
replace aapisub2_2012=20 if asian_d2012==20
replace aapisub2_2012=21 if asian_d2012==21
replace aapisub2_2012=22 if asian_d2012==22
replace aapisub2_2012=23 if pi_d2012==1
replace aapisub2_2012=24 if pi_d2012==2
replace aapisub2_2012=25 if pi_d2012==3
replace aapisub2_2012=26 if pi_d2012==4
replace aapisub2_2012=27 if pi_d2012==5
replace aapisub2_2012=28 if pi_d2012==6
replace aapisub2_2012=29 if pi_d2012==7
}
#delimit;
lab def aapisub2_2012
1 "Asian Indian"
2 "Bangladeshi"
3 "Bhutanese"
4 "Burmese"
5 "Cambodian"
6 "Chinese, except Taiwanese"
7 "Taiwanese"
8 "Filipino"
9 "Hmong"
10 "Indonesian"
11 "Japanese"
12 "Korean"
13 "Laotian"
14 "Malaysian"
15 "Mongolian"
16 "Nepalese"
17 "Pakistani"
18 "Sri Lankan"
19 "Thai"
20 "Vietnamese"
21 "Other Asian"
22 "All combinations of Asian races"
23 "Native Hawaiian"
24 "Samoan"
25 "Tongan"
26 "Guamanian or Chamorro"
27 "Marshallese"
28 "Fijian"
29 "Other NH and PI groups alone or mixed"
;
#delimit cr
lab var aapisub2_2012 "AAPI subgroup detailed"
lab val aapisub2_2012 aapisub2_2012
notes aapisub2_2012: ACS: Derived: RAC3P
notes aapisub2_2012: ACS: Available 2012-on


		/* Race and Ethincity, Hispanic Detailed */

if 2005<=`year' & `year'<=2018 {
replace hisp=. if hisp<1
replace hisp=. if 24<hisp
}
#delimit;
lab def hisp
1 "Not Spanish/Hispanic/Latino"
2 "Mexican"
3 "Puerto Rican"
4 "Cuban"
5 "Dominican"
6 "Costa Rican"
7 "Guatemalan"
8 "Honduran"
9 "Nicaraguan"
10 "Panamanian"
11 "Salvadoran"
12 "Other Central American"
13 "Argentinean"
14 "Bolivian"
15 "Chilean"
16 "Colombian"
17 "Ecuadorian"
18 "Paraguayan"
19 "Peruvian"
20 "Uruguayan"
21 "Venezuelan"
22 "Other South American"
23 "Spaniard"
24 "All Other Spanish/Hispanic/Latino"
;
#delimit cr
lab var hisp "Hispanic, Detailed"
lab val hisp hisp
notes hisp: ACS: HISP

/* American Indian and Alaskan Native recode */

if 2005<=`year' & `year'<=2018 {
replace racaian=. if 1<racaian
}
lab var racaian "American Indian"
lab val racaian noyes
notes racaian: ACS: RACAIAN

/* Asian recode */

if 2005<=`year' & `year'<=2018 {
replace racasn=. if 1<racasn
}
lab var racasn "Asian"
lab val racasn noyes
notes racasn: ACS: RACASN

/* Black recode */

if 2005<=`year' & `year'<=2018 {
replace racblk=. if 1<racblk
}
lab var racblk "Black"
lab val racblk noyes
notes racblk: ACS: RACBLK

/* Native Hawaiian, Pacific Islander recode */

if 2005<=`year' & `year'<=2011 {
replace racnhpi=. if 1<racnhpi
}
if 2012<=`year' & `year'<=2018 {
gen byte racnhpi=0 if racnh==0 | racpi==0
replace racnhpi=1 if racnh==1 | racpi==1
}
lab var racnhpi "Native Hawaiian, Pacific Islander"
lab val racnhpi noyes
notes racnhpi: ACS: RACNHPI

/* White recode */

if 2005<=`year' & `year'<=2018 {
replace racwht=. if 1<racwht
}
lab var racwht "White"
lab val racwht noyes
notes racwht: ACS: RACWHT

/* Number of races recode */

if 2005<=`year' & `year'<=2018 {
replace racnum=. if racnum<1 | 6<racnum
}
lab var racnum "Number of races"
notes racnum: ACS: racnum

/* Ancestry recode */

if 2005<=`year' & `year'<=2018 {
replace anc=. if anc<1
replace anc=. if 3<anc
}
lab def anc	1 "Single" ///
		2 "Multiple" ///
		3 "Unclassified"
lab var anc "Ancestry recode"
lab val anc anc
notes anc: ACS: ANC
notes anc: Suppressed for select PUMAs in some years

/* Ancestry detailed */

if 2005<=`year' & `year'<=2018 {
gen anc1p05=.
gen anc2p05=.
gen anc1p08=.
gen anc2p08=.
gen anc1p12=.
gen anc2p12=.
gen anc1p17=.
gen anc2p17=.
gen anc1p18=.
gen anc2p18=.
}
cd "$do"
cd cepr_acs_demog
do "cepr_acs_demog_anc05.do" /*consistent for 2005-2007*/
do "cepr_acs_demog_anc08.do" /*consistent for 2008-2011*/
do "cepr_acs_demog_anc12.do" /*consistent for 2012-2016*/
do "cepr_acs_demog_anc17.do" /*consistent for 2017*/
do "cepr_acs_demog_anc18.do" /*consistent for 2018*/

/* Foreign-born status */

if 2005<=`year' & `year'<=2018 {
gen byte forborn=.
replace forborn=1 if nativity==2
replace forborn=0 if nativity==1
}
lab var forborn "Foreign-born"
lab val forborn noyes
notes forborn: ACS: NATIVITY

/* US citizen */

if 2005<=`year' & `year'<=2018 {
gen byte citizen=.
replace citizen=1 if 1<=cit & cit<=4
replace citizen=0 if cit==5
}
lab var citizen "US citizen"
lab val citizen noyes
notes citizen: ACS: CIT

/* US citizenship status, detailed */

if 2005<=`year' & `year'<=2018 {
gen byte citstat=cit if cit~=.
}
lab def citstat		1 "Born in US" ///
			2 "Born in PR / OA" ///
			3 "For. born, US parents" ///
			4 "For. born, naturalized" ///
			5 "Non-citizen"
lab var citstat "US citizenship status"
lab val citstat citstat
notes citstat: ACS: CIT

/* Year of Entry */

if `year'==2014 {
/* yoep is str4 in 2014 */
destring yoep, replace
}
if 2005<=`year' & `year'<=2018 {
replace yoep=. if yoep<1919
replace yoep=. if 2018<yoep
}
lab var yoep "Year of Entry"
notes yoep: ACS: YOEP
notes yoep: Bottom-coded at 1919 (2005-2011), 1921 (2012-2016), 1925 (2017), 1929 (2018)
notes yoep: Rounding rules/ categories vary with bottom-coding

if 2005<=`year' & `year'<=2011 {
gen yoep05=yoep if yoep~=.
replace yoep05=. if yoep<1919
replace yoep05=. if 2011<yoep
}
if 2012<=`year' & `year'<=2018 {
gen yoep05=.
}
lab def yoep05	///
1919 "1919 or earlier" ///
1920 "1920" ///
1921 "1921" ///
1922 "1922" ///
1923 "1923" ///
1924 "1924" ///
1925 "1925" ///
1926 "1926" ///
1927 "1927" ///
1928 "1928" ///
1929 "1920" ///
1930 "1930" ///
1931 "1931-1932" ///
1933 "1933-1934" ///
1935 "1935" ///
1936 "1936" ///
1937 "1937" ///
1938 "1938" ///
1939 "1939" ///
1940 "1940" ///
1941 "1941" ///
1942 "1942" ///
1943 "1943" ///
1944 "1944" ///
1945 "1945" ///
1946 "1946" ///
1947 "1947" ///
1948 "1948" ///
1949 "1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011"
lab var yoep05 "Year of Entry (2005-2011 categories)"
lab val yoep05 yoep05
notes yoep05: Bottom-coded at 1919
notes yoep05: ACS: YOEP

if 2005<=`year' & `year'<=2011 {
gen yoep12=.
}
if 2012<=`year' & `year'<=2016 {
gen yoep12=yoep if yoep~=.
replace yoep12=. if yoep<1921
replace yoep12=. if 2016<yoep
}
if 2017<=`year' & `year'<=2018 {
gen yoep12=.
}
lab def yoep12	 ///
1921 "1921 or earlier" ///
1922 "1922-1923" ///
1924 "1924-1925" ///
1926 "1926-1927" ///
1928 "1928-1929" ///
1930 "1930-1931" ///
1932 "1932-1934" ///
1935 "1935-1936" ///
1937 "1937-1938" ///
1939 "1939" ///
1940 "1940" ///
1941 "1941" ///
1942 "1942" ///
1943 "1943-1944" ///
1945 "1945" ///
1946 "1946" ///
1947 "1947" ///
1948 "1948" ///
1949 "1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011" ///
2012 "2012" ///
2013 "2013" ///
2014 "2014" ///
2015 "2015" ///
2016 "2016"
lab var yoep12 "Year of Entry (2012-2016 categories)"
lab val yoep12 yoep12
notes yoep12: Bottom-coded at 1921
notes yoep12: ACS: YOEP

if 2005<=`year' & `year'<=2016 {
gen yoep17=.
}
if `year'==2017 {
gen yoep17=yoep if yoep~=.
replace yoep17=. if yoep<1925
replace yoep17=. if 2017<yoep
}
if `year'==2018 {
gen yoep17=.
}
lab def yoep17	 ///
1925 "1925 or earlier" ///
1926 "1926-1929" ///
1930 "1930-1934" ///
1935 "1935-1938" ///
1939 "1939" ///
1940 "1940" ///
1941 "1941-1942" ///
1943 "1943-1944" ///
1945 "1945" ///
1946 "1946" ///
1947 "1947" ///
1948 "1948" ///
1949 "1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011" ///
2012 "2012" ///
2013 "2013" ///
2014 "2014" ///
2015 "2015" ///
2016 "2016" ///
2017 "2017"
lab var yoep17 "Year of Entry (2017 categories)"
lab val yoep17 yoep17
notes yoep17: Bottom-coded at 1925
notes yoep17: ACS: YOEP

if 2005<=`year' & `year'<=2017 {
gen yoep18=.
}
if `year'==2018 {
gen yoep18=yoep if yoep~=.
replace yoep18=. if yoep<1929
replace yoep18=. if 2018<yoep
}
lab def yoep18	 ///
1929 "1929 or earlier" ///
1930 "1930-1934" ///
1935 "1935-1938" ///
1939 "1939-1940" ///
1941 "1941-1942" ///
1943 "1943-1944" ///
1945 "1945" ///
1946 "1946" ///
1947 "1947" ///
1948 "1948" ///
1949 "1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011" ///
2012 "2012" ///
2013 "2013" ///
2014 "2014" ///
2015 "2015" ///
2016 "2016" ///
2017 "2017" ///
2018 "2018"
lab var yoep18 "Year of Entry (2018 categories)"
lab val yoep18 yoep18
notes yoep18: Bottom-coded at 1929
notes yoep18: ACS: YOEP

/* Year of naturalization */

if `year'==2014 {
/* citwp is str4 in 2014 */
destring citwp, replace
}
if 2005<=`year' & `year'<=2007 {
gen byte citwp=.
}
if 2008<=`year' & `year'<=2018 {
replace citwp=. if citwp<1925
replace citwp=. if 2018<citwp
}
lab var citwp "Year of naturalization"
notes citwp: ACS: CITWP
notes citwp: Bottom-coded at 1925 (2008-2011), 1928 (2012-2016), 1939 (2017-2018)
notes citwp: Rounding rules/ categories vary with bottom-coding

if 2005<=`year' & `year'<=2007 {
gen citwp08=.
}
if 2008<=`year' & `year'<=2011 {
gen citwp08=.
replace citwp08=. if citwp<1925
replace citwp08=. if 2011<citwp
}
if 2012<=`year' & `year'<=2018 {
gen citwp08=.
}
lab def citwp08 	 ///
1925 "1925 or earlier" ///
1926 "1926-1930" ///
1931 "1931-1935" ///
1936 "1936-1940" ///
1941 "1941-1942" ///
1943 "1943" ///
1944 "1944" ///
1945 "1945" ///
1946 "1946" ///
1947 "1947" ///
1948 "1948" ///
1949 "1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011" 
lab var citwp08 "Year of naturalization (2008-2011 categories)"
lab val citwp08 citwp08
notes citwp08: ACS: CITWP
notes citwp08: Bottom-coded at 1925

if 2005<=`year' & `year'<=2011 {
gen citwp12=.
}
if 2012<=`year' & `year'<=2016 {
gen citwp12=.
replace citwp12=. if citwp<1928
replace citwp12=. if 2016<citwp
}
if 2017<=`year' & `year'<=2018 {
gen citwp12=.
}
lab def citwp12 	 ///
1928 "1928 or earlier" ///
1929 "1929-1933" ///
1934 "1934-1939" ///
1940 "1940-1942" ///
1943 "1943-1944" ///
1945 "1945" ///
1946 "1946-1947" ///
1948 "1948" ///
1949 "1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011" ///
2012 "2012" ///
2013 "2013" ///
2014 "2014" ///
2015 "2015" ///
2016 "2016"
lab var citwp12 "Year of naturalization (2012-2016 categories)"
lab val citwp12 citwp12
notes citwp12: ACS: CITWP
notes citwp12: Bottom-coded at 1928

if 2005<=`year' & `year'<=2016 {
gen citwp17=.
}
if 2017<=`year' & `year'<=2018 {
gen citwp17=.
replace citwp17=. if citwp<1939
replace citwp17=. if 2018<citwp
}
lab def citwp17 	 ///
1939 "1939 or earlier" ///
1940 "1940-1944" ///
1945 "1945-1947" ///
1948 "1948-1949" ///
1950 "1950" ///
1951 "1951" ///
1952 "1952" ///
1953 "1953" ///
1954 "1954" ///
1955 "1955" ///
1956 "1956" ///
1957 "1957" ///
1958 "1958" ///
1959 "1959" ///
1960 "1960" ///
1961 "1961" ///
1962 "1962" ///
1963 "1963" ///
1964 "1964" ///
1965 "1965" ///
1966 "1966" ///
1967 "1967" ///
1968 "1968" ///
1969 "1969" ///
1970 "1970" ///
1971 "1971" ///
1972 "1972" ///
1973 "1973" ///
1974 "1974" ///
1975 "1975" ///
1976 "1976" ///
1977 "1977" ///
1978 "1978" ///
1979 "1979" ///
1980 "1980" ///
1981 "1981" ///
1982 "1982" ///
1983 "1983" ///
1984 "1984" ///
1985 "1985" ///
1986 "1986" ///
1987 "1987" ///
1988 "1988" ///
1989 "1989" ///
1990 "1990" ///
1991 "1991" ///
1992 "1992" ///
1993 "1993" ///
1994 "1994" ///
1995 "1995" ///
1996 "1996" ///
1997 "1997" ///
1998 "1998" ///
1999 "1999" ///
2000 "2000" ///
2001 "2001" ///
2002 "2002" ///
2003 "2003" ///
2004 "2004" ///
2005 "2005" ///
2006 "2006" ///
2007 "2007" ///
2008 "2008" ///
2009 "2009" ///
2010 "2010" ///
2011 "2011" ///
2012 "2012" ///
2013 "2013" ///
2014 "2014" ///
2015 "2015" ///
2016 "2016" ///
2017 "2017" ///
2018 "2018"
lab var citwp17 "Year of naturalization (2017-2018 categories)"
lab val citwp17 citwp17
notes citwp17: ACS: CITWP
notes citwp17: Bottom-coded at 1939

/* World area of birth */

if 2005<=`year' & `year'<=2017 {
replace waob=. if waob<1
replace waob=. if 8<waob
}
if `year'==2018 {
replace waob=. if waob<1
replace waob=. if 8<waob
replace waob=2 if pobp==60
}
lab def waob	1 "US" ///
		2 "PR and US Island Areas" ///
		3 "Latin America" ///
		4 "Asia" ///
		5 "Europe" ///
		6 "Africa" ///
		7 "Northern America" ///
		8 "Oceania and at Sea"
lab var waob "World area of birth (2005-2017 categories)"
lab val waob waob
notes waob: ACS: WAOB
notes waob: ACS categorizes American Samoa as PR and US Island Areas from /* 
 */ 2005-2017, this classifies it that way for all years.

gen waob18=.
if 2005<=`year' & `year'<=2017 {
replace waob18=1 if waob==1
replace waob18=2 if waob==2
replace waob18=3 if waob==3
replace waob18=4 if waob==4
replace waob18=5 if waob==5
replace waob18=6 if waob==6
replace waob18=7 if waob==7
replace waob18=8 if waob==8  | pobp==60
}
if `year'==2018 {
replace waob18=1 if waob==1
replace waob18=2 if waob==2
replace waob18=3 if waob==3
replace waob18=4 if waob==4
replace waob18=5 if waob==5
replace waob18=6 if waob==6
replace waob18=7 if waob==7
replace waob18=8 if waob==8
}
lab def waob18	1 "US" ///
		2 "PR and US Island Areas" ///
		3 "Latin America" ///
		4 "Asia" ///
		5 "Europe" ///
		6 "Africa" ///
		7 "Northern America" ///
		8 "Oceania and at Sea"
lab var waob18 "World area of birth (2018 categories)"
lab val waob18 waob18
notes waob18: ACS: WAOB
notes waob18: ACS categorizes American Samoa as Oceania and at Sea in 2018, /* 
 */ this classifies it that way for all years.

/* Place of birth */

if 2005<=`year' & `year'<=2018 {
gen pobp05=.
gen pobp09=.
gen pobp12=.
gen pobp17=.
}

cd "$do"
cd cepr_acs_demog
do "cepr_acs_demog_POB05.do" /* Consistent for 2005-2008 */
do "cepr_acs_demog_POB09.do" /* Consistent for 2009-2011 */
do "cepr_acs_demog_POB12.do" /* Consistent for 2012-2016 */
do "cepr_acs_demog_POB17.do" /* Consistent for 2017-2018 */

/* Nativity of parent */

if 2005==`year' {
gen byte nop=.
}
if 2006<=`year' & `year'<=2018 {
replace nop=. if nop<1
replace nop=. if 8<nop
}
lab def nop	1 "Living w/ 2 parents: Both Native" ///
		2 "Living w/ 2 parents: Father Foreign Born" ///
		3 "Living w/ 2 parents: Mother Foreign Born" ///
		4 "Living w/ 2 parents: BOTH Foreign Born" ///
		5 "Living w/ father only: Father Native" ///
		6 "Living w/ father only: Father Foreign Born" ///
		7 "Living w/ mother only: Mother Native" ///
		8 "Living w/ mother only: Mother Foreign Born"
lab var nop "Nativity of parent"
lab val nop nop
notes nop: ACS: NOP

/* Foreign-born mother */

if 2005==`year' {
gen byte forbornm=.
}
if 2006<=`year' & `year'<=2018 {
gen byte forbornm=.
replace forbornm=1 if nop==3 | nop==4 | nop==8
replace forbornm=0 if nop==1 | nop==2 | nop==7
}
lab var forbornm "Foreign-born mother"
lab val forbornm forbornm
notes forbornm: For children <18 yrs old
notes forbornm: ACS: Derived: NOP

/* Foreign-born father */

if 2005==`year' {
gen byte forbornf=.
}
if 2006<=`year' & `year'<=2018 {
gen byte forbornf=.
replace forbornf=1 if nop==2 | nop==4 | nop==6
replace forbornf=0 if nop==1 | nop==3 | nop==5
}
lab var forbornf "Foreign-born father"
lab val forbornf forbornf
notes forbornf: for children <18 yrs old
notes forbornf: ACS: Derived: NOP

/* Veteran period of service */

if 2005<=`year' & `year'<=2006 {
gen byte vps05=vps if vps~=.
drop vps
rename vps05 vps
}
if 2007<=`year' & `year'<=2018 {
gen byte vps05=.
replace vps05=1 if vps==1 | vps==2 | vps==4
replace vps05=2 if vps==3 | vps==5
replace vps05=3 if vps==6
replace vps05=4 if vps==7
replace vps05=5 if vps==8
replace vps05=6 if vps==9
replace vps05=7 if vps==10
replace vps05=8 if vps==11
replace vps05=9 if vps==12
replace vps05=10 if vps==13
replace vps05=11 if vps==14
replace vps05=12 if vps==15
drop vps
rename vps05 vps
}
lab def vps	1 "Gulf War or later only" ///
		2 "Gulf War & Vietnam era" ///
		3 "Vietnam era only" ///
		4 "Vietnam era & Korean War" ///
		5 "Vietnam era, Korean War, & WWII" ///
		6 "Korean War" ///
		7 "Korean War & WWII" ///
		8 "WWII" ///
		9 "Post-Vietnam era only" ///
		10 "Between Vietnam & Korean War only" ///
		11 "Between Korean War & WWII only" ///
		12 "Pre-WWII only"
lab var vps "Veteran Period of Service"
lab val vps vps
notes vps: ACS: VPS

/* Veteran status (binary) */

if 2005<=`year' & `year'<=2018 {
gen byte veteran=0
replace veteran=1 if 1<=vps & vps<=12
}
lab var veteran "Veteran"
lab val veteran noyes
notes veteran: ACS: Derived: VPS


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


