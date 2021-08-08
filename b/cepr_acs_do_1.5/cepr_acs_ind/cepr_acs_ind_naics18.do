set more 1

/*
File:	cepr_acs_ind_naics18.do
Date:	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent NAICS industry code variable for 2018
Note:	See copyright notice at end of program.

	Part of cepr_acs_ind.do */

/* Determine survey year */

local year=year in 1

/* NAICS Industry Code */

/* Industry codes are string with mixture of numbers and letters
(M, S, Z, P). The following recodes M=9, Z=8, P=7, S=6 and destrings
variables so that value labels can be attached. */

if 2005<=`year' & `year'<=2017 {
gen ind_naics18="."
}

if `year'==2018 {

gen ind_naics18=naicsp 

replace ind_naics18="1139" if ind_naics18=="113M"
replace ind_naics18="22117" if ind_naics18=="2211P"
replace ind_naics18="22127" if ind_naics18=="2212P"
replace ind_naics18="22139" if ind_naics18=="2213M"
replace ind_naics18="22197" if ind_naics18=="221MP"
replace ind_naics18="226" if ind_naics18=="22S"
replace ind_naics18="31188" if ind_naics18=="3118Z"
replace ind_naics18="31191" if ind_naics18=="311M1"
replace ind_naics18="31192" if ind_naics18=="311M2"
replace ind_naics18="3116" if ind_naics18=="311S"
replace ind_naics18="31328" if ind_naics18=="3132Z"
replace ind_naics18="3148" if ind_naics18=="314Z"
replace ind_naics18="3159" if ind_naics18=="315M"
replace ind_naics18="3169" if ind_naics18=="316M"
replace ind_naics18="319" if ind_naics18=="31M"
replace ind_naics18="321999" if ind_naics18=="32199M"
replace ind_naics18="321989" if ind_naics18=="3219ZM"
replace ind_naics18="32229" if ind_naics18=="3222M"
replace ind_naics18="32419" if ind_naics18=="3241M"
replace ind_naics18="3259" if ind_naics18=="325M"
replace ind_naics18="32629" if ind_naics18=="3262M"
replace ind_naics18="3280" if ind_naics18=="327M" /* Can't be 3279 (already exists), so coded to 3280 */
replace ind_naics18="3319" if ind_naics18=="331M"
replace ind_naics18="332999" if ind_naics18=="33299M"
replace ind_naics18="3329" if ind_naics18=="332M"
replace ind_naics18="33298" if ind_naics18=="332MZ"
replace ind_naics18="33319" if ind_naics18=="3331M"
replace ind_naics18="33396" if ind_naics18=="333MS"
replace ind_naics18="33491" if ind_naics18=="334M1"
replace ind_naics18="33492" if ind_naics18=="334M2"
replace ind_naics18="3359" if ind_naics18=="335M"
replace ind_naics18="3364191" if ind_naics18=="33641M1"
replace ind_naics18="3364192" if ind_naics18=="33641M2"
replace ind_naics18="3368" if ind_naics18=="336M" /* Can't be 3369 (already exists), so coded to 3368*/
replace ind_naics18="33999" if ind_naics18=="3399M"
replace ind_naics18="339989" if ind_naics18=="3399ZM"
replace ind_naics18="3396" if ind_naics18=="33MS"
replace ind_naics18="396" if ind_naics18=="3MS"
replace ind_naics18="42398" if ind_naics18=="4239Z"
replace ind_naics18="42498" if ind_naics18=="4249Z"
replace ind_naics18="4249" if ind_naics18=="424M"
replace ind_naics18="426" if ind_naics18=="42S"
replace ind_naics18="44418" if ind_naics18=="4441Z"
replace ind_naics18="4468" if ind_naics18=="446Z"
replace ind_naics18="45119" if ind_naics18=="4511M"
replace ind_naics18="4859" if ind_naics18=="485M"
replace ind_naics18="496" if ind_naics18=="4MS"
replace ind_naics18="51118" if ind_naics18=="5111Z"
replace ind_naics18="5178" if ind_naics18=="517Z"
replace ind_naics18="519189" if ind_naics18=="5191ZM"
replace ind_naics18="52219" if ind_naics18=="5221M"
replace ind_naics18="5229" if ind_naics18=="522M"
replace ind_naics18="5291" if ind_naics18=="52M1"
replace ind_naics18="5292" if ind_naics18=="52M2"
replace ind_naics18="5319" if ind_naics18=="531M"
replace ind_naics18="53292" if ind_naics18=="532M2"
replace ind_naics18="539" if ind_naics18=="53M"
replace ind_naics18="54198" if ind_naics18=="5419Z"
replace ind_naics18="56178" if ind_naics18=="5617Z"
replace ind_naics18="5619" if ind_naics18=="561M"
replace ind_naics18="61191" if ind_naics18=="611M1"
replace ind_naics18="61192" if ind_naics18=="611M2"
replace ind_naics18="61193" if ind_naics18=="611M3"
replace ind_naics18="621389" if ind_naics18=="6213ZM"
replace ind_naics18="6219" if ind_naics18=="621M"
replace ind_naics18="6229" if ind_naics18=="622M"
replace ind_naics18="6239" if ind_naics18=="623M"
replace ind_naics18="7119" if ind_naics18=="711M"
replace ind_naics18="7138" if ind_naics18=="713Z"
replace ind_naics18="7219" if ind_naics18=="721M"
replace ind_naics18="7228" if ind_naics18=="722Z"
replace ind_naics18="81118" if ind_naics18=="8111Z"
replace ind_naics18="81219" if ind_naics18=="8121M"
replace ind_naics18="81398" if ind_naics18=="8139Z"
replace ind_naics18="8139" if ind_naics18=="813M"
replace ind_naics18="921197" if ind_naics18=="9211MP"
replace ind_naics18="92811071" if ind_naics18=="928110P1"
replace ind_naics18="92811072" if ind_naics18=="928110P2"
replace ind_naics18="92811073" if ind_naics18=="928110P3"
replace ind_naics18="92811074" if ind_naics18=="928110P4"
replace ind_naics18="92811075" if ind_naics18=="928110P5"
replace ind_naics18="92811076" if ind_naics18=="928110P6"
replace ind_naics18="92811077" if ind_naics18=="928110P7"
replace ind_naics18="9287" if ind_naics18=="928P"
replace ind_naics18="9291" if ind_naics18=="92M1"
replace ind_naics18="9292" if ind_naics18=="92M2"
replace ind_naics18="9297" if ind_naics18=="92MP"


destring ind_naics18, replace /* so that we can attach value labels */

#delimit ;
lab def ind_naics18
111 "AGR-CROP PRODUCTION"
112 "AGR-ANIMAL PRODUCTION AND AQUACULTURE"
1133 "AGR-LOGGING"
1139 "113M:AGR-FORESTRY EXCEPT LOGGING"
114 "AGR-FISHING, HUNTING, AND TRAPPING"
115 "AGR-SUPPORT ACTIVITIES FOR AGRICULTURE AND FORESTRY"
211 "EXT-OIL AND GAS EXTRACTION"
2121 "EXT-COAL MINING"
2122 "EXT-METAL ORE MINING"
2123 "EXT-NONMETALLIC MINERAL MINING AND QUARRYING"
213 "EXT-SUPPORT ACTIVITIES FOR MINING"
22117 "2211P:UTL-ELECTRIC POWER GENERATION, TRANSMISSION AND DISTRIBUTION"
22127 "2212P:UTL-NATURAL GAS DISTRIBUTION"
22132 "UTL-SEWAGE TREATMENT FACILITIES"
22139 "2213M:UTL-WATER, STEAM, AIR CONDITIONING, AND IRRIGATION SYSTEMS"
22197 "221MP:UTL-ELECTRIC AND GAS, AND OTHER COMBINATIONS"
226 "22S:UTL-NOT SPECIFIED UTILITIES"
23 "CON-CONSTRUCTION, INCL CLEANING DURING AND IMM AFTER"
3113 "MFG-SUGAR AND CONFECTIONERY PRODUCTS"
3114 "MFG-FRUIT AND VEGETABLE PRESERVING AND SPECIALITY FOODS"
3115 "MFG-DAIRY PRODUCTS"
3116 "MFG-ANIMAL SLAUGHTERING AND PROCESSING"
311811 "MFG-RETAIL BAKERIES"
31188 "3118Z:MFG-BAKERIES AND TORTILLA, EXCEPT RETAIL BAKERIES"
31191 "311M1:MFG-ANIMAL FOOD, GRAIN AND OILSEED MILLING"
31192 "311M2:MFG-SEAFOOD AND OTHER MISCELLANEOUS FOODS, N.E.C."
3116 "311S:MFG-NOT SPECIFIED FOOD INDUSTRIES"
3121 "MFG-BEVERAGE"
3122 "MFG-TOBACCO"
3131 "MFG-FIBER, YARN, AND THREAD MILLS"
31328 "3132Z:MFG-FABRIC MILLS, EXCEPT KNITTING"
3133 "MFG-TEXTILE AND FABRIC FINISHING AND FABRIC COATING MILLS"
31411 "MFG-CARPET AND RUG MILLS"
3148 "314Z:MFG-TEXTILE PRODUCT MILLS, EXCEPT CARPET AND RUG"
3159 "315M:MFG-CUT AND SEW, AND APPAREL ACCESSORIES AND OTHER APPAREL"
3162 "MFG-FOOTWEAR"
3169 "316M:MFG-LEATHER TANNING AND FINISHING AND OTHER ALLIED PRODUCTS MANUFACTURING"
319 "31M:MFG-KNITTING FABIRC MILLS, AND APPAREL KNITTING MILLS"
3211 "MFG-SAWMILLS AND WOOD PRESERVATION"
3212 "MFG-VENEER, PLYWOOD, AND ENGINEERED WOOD PRODUCTS"
321999 "32199M:MFG-PREFABRICATED WOOD BUILDINGS AND MOBILE HOMES"
321989 "3219ZM:MFG-MISC WOOD PRODUCTS"
3221 "MFG-PULP, PAPER, AND PAPERBOARD MILLS"
32221 "MFG-PAPERBOARD CONTAINER"
32229 "3222M:MFG-MISC PAPER AND PULP PRODUCTS"
3231 "MFG-PRINTING AND RELATED SUPPORT ACTIVITIES"
32411 "MFG-PETROLEUM REFINING"
32419 "3241M:MFG-MISC PETROLEUM AND COAL PRODUCTS"
3252 "MFG-RESIN, SYNTHETIC RUBBER AND FIBERS, AND FILAMENTS"
3253 "MFG-AGRICULTURAL CHEMICALS"
3254 "MFG-PHARMACEUTICALS AND MEDICINES"
3255 "MFG-PAINT, COATING, AND ADHESIVES"
3256 "MFG-SOAP, CLEANING COMPOUND, AND COSMETICS"
3259 "325M:MFG-INDUSTRIAL AND MISC CHEMICALS"
3261 "MFG-PLASTICS PRODUCTS"
32621 "MFG-TIRES"
32629 "3262M:MFG-RUBBER PRODUCTS, EXCEPT TIRES"
32711 "MFG-POTTERY, CERAMICS, AND PLUMBING FIXTURE MANUFACTURING"
327120 "MFG: CLAY BUILDING MATERIAL AND PREFACTORIES"
3272 "MFG-GLASS AND GLASS PRODUCTS"
3279 "MFG-MISC NONMETALLIC MINERAL PRODUCTS"
3280 "327M:MFG-CEMENT, CONCRETE, LIME, AND GYPSUM PRODUCTS" /* Can't be 3279 (already exists), so coded to 3280 */
3313 "MFG-ALUMINUM PRODUCTION AND PROCESSING"
3314 "MFG-NONFERROUS METAL, EXCEPT ALUMINUM, PRODUCTION AND PROCESSING"
3315 "MFG-FOUNDRIES"
3319 "331M:MFG-IRON AND STEEL MILLS AND STEEL PRODUCTS"
3321 "MFG-METAL FORGINGS AND STAMPINGS"
3322 "MFG-CUTLERY AND HAND TOOLS"
3327 "MFG-MACHINE SHOPS; TURNED PRODUCTS; SCREWS, NUTS AND BOLTS"
3328 "MFG-COATING, ENGRAVING, HEAT TREATING AND ALLIED ACTIVITIES"
332999 "33299M:MFG-ORDNANCE"
3329 "332M:MFG-STRUCTURAL METALS, AND TANK AND SHIPPING CONTAINERS"
33298 "332MZ:MFG-MISC FABRICATED METAL PRODUCTS"
33311 "MFG-AGRICULTURAL IMPLEMENTS"
33319 "3331M:MFG-CONSTRUCTION, AND MINING AND OIL AND GAS FIELD MACHINERY"
3333 "MFG-COMMERCIAL AND SERVICE INDUSTRY MACHINERY"
3335 "MFG-METALWORKING MACHINERY"
3336 "MFG-ENGINE, TURBINE, AND POWER TRANSMISSION EQUIPMENT"
33396 "333MS:MFG-MACHINERY MANUFACTURING, N.E.C. OR NOT SPECIFIED"
3341 "MFG-COMPUTER AND PERIPHERAL EQUIPMENT"
3345 "MFG-NAVIGATIONAL, MEASURING, ELECTROMEDICAL, AND CONTROL INSTRUMENTS"
33491 "334M1:MFG-COMMUNICATIONS, AUDIO, AND VIDEO EQUIPMENT"
33492 "334M2:MFG-ELECTRONIC COMPONENTS AND PRODUCTS, N.E.C."
3352 "MFG-HOUSEHOLD APPLIANCES"
3359 "335M:MFG-ELECTRICAL LIGHTING, AND ELECTRICAL EQUIPMENT MANUF, AND OTHER ELECTRICAL EQUIP MANUF, N.E.C."
3364191 "33641M1:MFG-AIRCRAFT AND PARTS"
3364192 "33641M2:MFG-AEROSPACE PRODUCTS AND PARTS"
3365 "MFG-RAILROAD ROLLING STOCK"
3366 "MFG-SHIP AND BOAT BUILDING"
3369 "MFG-OTHER TRANSPORTATION EQUIPMENT"
3368 "336M:MFG-MOTOR VEHICLES AND MOTOR VEHICLE EQUIPMENT" /* Can't be 3369 (already exists), so coded to 3368*/
337 "MFG-FURNITURE AND RELATED PRODUCTS"
3391 "MFG-MEDICAL EQUIPMENT AND SUPPLIES"
33999 "3399M:MFG-SPORTING AND ATHLETIC GOODS, AND DOLL, TOY, AND GAME MANUFACTURING"
339989 "3399ZM:MFG-MISC MANUFACTURING, N.E.C."
3396 "33MS:MFG-NOT SPECIFIED METAL INDUSTRIES"
396 "3MS:MFG-NOT SPECIFIED INDUSTRIES"
4231 "WHL-MOTOR VEHICLES AND MOTOR VEHICLE PARTS AND SUPPLIES MERCHANT WHOLESALERS"
4232 "WHL-FURNITURE AND HOME FURNISHING MERCHANT WHOLESALERS"
4233 "WHL-LUMBER AND OTHER CONSTRUCTION MATERIALS MERCHANT WHOLESALERS"
4234 "WHL-PROFESSIONAL AND COMMERCIAL EQUIPMENT AND SUPPLIES MERCHANT WHOLESALERS"
4235 "WHL-METALS AND MINERALS, EXCEPT PETROLEUM, MERCHANT WHOLESALERS"
4236 "WHL-HOUSEHOLD APPLIANCES AND ELECTRICAL AND ELECTRONIC GOODS MERCHANT WHOLESALERS"
4237 "WHL-HARDWARE, AND PLUMBING AND HEATING EQUIPMENT, AND SUPPLIES MERCHANT WHOLESALERS"
4238 "WHL-MACHINERY, EQUIPMENT, AND SUPPLIES MERCHANT WHOLESALERS"
42393 "WHL-RECYCLABLE MATERIAL MERCHANT WHOLESALERS"
42398 "4239Z:WHL-MISC DURABLE GOODS MERCHANT WHOLESALERS"
4241 "WHL-PAPER AND PAPER PRODUCTS MERCHANT WHOLESALERS"
4243 "WHL-APPAREL, PIECE GOODS, AND NOTIONS MERCHANT WHOLESALERS"
4244 "WHL-GROCERY AND RELATED PRODUCT MERCHANT WHOLESALERS"
4245 "WHL-FARM PRODUCT RAW MATERIAL MERCHANT WHOLESALERS"
4247 "WHL-PETROLEUM AND PETROLEUM PRODUCTS MERCHANT WHOLESALERS"
4248 "WHL-ALCOHOLIC BEVERAGES MERCHANT WHOLESALERS"
42491 "WHL-FARM SUPPLIES MERCHANT WHOLESALERS"
42498 "4249Z:WHL-MISC NONDURABLE GOODS MERCHANT WHOLESALERS"
4249 "424M:WHL-DRUGS, SUNDRIES, AND CHEMICAL AND ALLIED PRODUCTS MERCHANT WHOLESALERS"
4251 "WHL-WHOLESALE ELECTRONIC MARKETS AND AGENTS AND BROKERS"
426 "42S:WHL-NOT SPECIFIED WHOLESALE TRADE"
4411 "RET-AUTOMOBILE DEALERS"
4412 "RET-OTHER MOTOR VEHICLE DEALERS"
4413 "RET-AUTOMOTIVE PARTS, ACCESSORIES, AND TIRE STORES"
442 "RET-FURNITURE AND HOME FURNISHINGS STORES"
443141 "RET-HOUSEHOLD APPLIANCE STORES"
443142 "RET-ELECTRONICS STORES"
44413 "RET-HARDWARE STORES"
44418 "4441Z:RET-BUILDING MATERIAL AND SUPPLIES DEALERS"
4442 "RET-LAWN AND GARDEN EQUIPMENT AND SUPPLIES STORES"
44511 "RET-SUPERMARKETS AND GROCERY (EXCEPT CONVENIENCE) STORES"
44511 "RET-CONVENIENCE STORES"
4452 "RET-SPECIALTY FOOD STORES"
4453 "RET-BEER, WINE, AND LIQUOR STORES"
44611 "RET-PHARMACIES AND DRUG STORES"
4468 "446Z:RET-HEALTH AND PERSONAL CARE, EXCEPT DRUG, STORES"
447 "RET-GASOLINE STATIONS"
44821 "RET-SHOE STORES"
4483 "RET-JEWELRY, LUGGAGE, AND LEATHER GOODS STORES"
4481 "RET-CLOTHING STORES"
45113 "RET-SEWING, NEEDLEWORK AND PIECE GOODS STORES"
45114 "RET-MUSICAL INSTRUMENT AND SUPPLIES STORES"
45119 "4511M:RET-SPORTING GOODS, AND HOBBY AND TOY STORES"
45121 "RET-BOOK STORES AND NEWS DEALERS"
45221 "RET-DEPARTMENT STORES"
4523 "RET-GENERAL MERCHANDISE STORES, INCLUDING WAREHOUSE CLUBS AND SUPERCENTERS"
4531 "RET-FLORISTS"
45321 "RET-OFFICE SUPPLIES AND STATIONARY STORES"
45322 "RET-GIFT, NOVELTY, AND SOUVENIR SHOPS"
4533 "RET-USED MERCHANDISE STORES"
4539 "RET-MISC RETAIL STORES"
454110 "RET-ELECTRONIC SHOPPING AND MAIL-ORDER HOUSES"
4542 "RET-VENDING MACHINE OPERATORS"
454310 "RET-FUEL DEALERS"
45439 "RET-OTHER DIRECT SELLING ESTABLISHMENTS"
496 "4MS:RET-NOT SPECIFIED RETAIL TRADE"
481 "TRN-AIR TRANSPORTATION"
482 "TRN-RAIL TRANSPORTATION"
483 "TRN-WATER TRANSPORTATION"
484 "TRN-TRUCK TRANSPORTATION"
4853 "TRN-TAXI AND LIMOUSINE SERVICE"
4859 "485M:TRN-BUS SERVICE AND URBAN TRANSIT"
486 "TRN-PIPELINE TRANSPORTATION"
487 "TRN-SCENIC AND SIGHTSEEING TRANSPORTATION"
488 "TRN-SERVICES INCIDENTAL TO TRANSPORTATION"
491 "TRN-POSTAL SERVICE"
492 "TRN-COURIERS AND MESSENGERS"
493 "TRN-WAREHOUSING AND STORAGE"
51111 "INF-NEWSPAPER PUBLISHERS"
51118 "5111Z:INF-PERIODICAL, BOOK AND DIRECTORY PUBLISHERS"
5112 "INF-SOFTWARE PUBLISHERS"
5121 "INF-MOTION PICTURE AND VIDEO INDUSTRIES"
5122 "INF-SOUND RECORDING INDUSTRIES"
515 "INF-BROADCASTING, EXCEPT INTERNET"
517311 "INF-WIRED TELECOMMUNICATIONS CARRIERS"
5178 "517Z:TELECOMMUNICATIONS, EXCEPT WIRED TELECOMMUNICATIONS CARRIERS"
5182 "INF-DATA PROCESSING, HOSTING, AND RELATED SERVICES"
51912 "INF-LIBRARIES AND ARCHIVES"
51913 "INF-INTERNET PUBLISHING AND BROADCASTING AND WEB SEARCH PORTALS"
519189 "5191ZM:INF-OTHER INFORMATION SERVICES, EXCEPT LIBRARIES AND ARCHIVES, AND INTERNET PUBLISHING AND BROADCASTING AND WEB SEARCH PORTALS"
52219 "5221M:FIN-SAVINGS INSTITUTIONS, INCLUDING CREDIT UNIONS"
5229 "522M:FIN-NON-DEPOSITORY CREDIT AND RELATED ACTIVITIES"
5241 "FIN-INSURANCE CARRIERS"
5242 "FIN-AGENCIES, BROKERAGES, AND OTHER INSURANCE RELATED ACTIVITIES"
5291 "52M1:FIN-BANKING AND RELATED ACTIVITIES"
5292 "52M2:FIN-SECURITIES, COMMODITIES, FUNDS, TRUSTS, AND OTHER FINANCIAL INVESTMENTS"
5319 "531M:FIN-LESSORS OF REAL ESTATE, AND OFFICES OF REAL ESTATE AGENTS AND BROKERS"
5313 "FIN-REAL ESTATE PROPERTY MANAGERS, OFFICERS OF REAL ESTATE APPRAISERS, AND OTHER ACTIVITIES RELATED TO REAL ESTATE"
5321 "FIN-AUTOMOTIVE EQUIPMENT RENTAL AND LEASING"
53292 "532M2:FIN-OTHER CONSUMER GOODS RENTAL"
539 "53M:FIN-COMMERCIAL, INDUSTRIAL, AND OTHER INTANGIBLE ASSETS RENTAL AND LEASING"
5411 "PRF-LEGAL SERVICES"
5412 "PRF-ACCOUNTING, TAX PREPARATION, BOOKKEEPING AND PAYROLL SERVICES"
5413 "PRF-ARCHITECTURAL, ENGINEERING, AND RELATED SERVICES"
5414 "PRF-SPECIALIZED DESIGN SERVICES"
5415 "PRF-COMPUTER SYSTEMS DESIGN AND RELATED SERVICES"
5416 "PRF-MANAGEMENT, SCIENTIFIC AND TECHNICAL CONSULTING SERVICES"
5417 "PRF-SCIENTIFIC RESEARCH AND DEVELOPMENT SERVICES"
5418 "PRF-ADVERTISING, PUBLIC RELATIONS, AND RELATED SERVICES"
54194 "PRF-VETERINARY SERVICES"
54198 "5419Z:PRF-OTHER PROFESSIONAL, SCIENTIFIC AND TECHNICAL SERVICES"
55 "PRF-MANAGEMENT OF COMPANIES AND ENTERPRISES"
5613 "PRF-EMPLOYMENT SERVICES"
5614 "PRF-BUSINESS SUPPORT SERVICES"
5615 "PRF-TRAVEL ARRANGEMENTS AND RESERVATION SERVICES"
5616 "PRF-INVESTIGATION AND SECURITY SERVICES"
56173 "PRF-LANDSCAPING SERVICES"
56178 "5617Z:PRF-SERVICES TO BUILDINGS AND DWELLINGS, EX CONSTR CLN"
5619 "561M:PRF-OTHER ADMINISTRATIVE, AND OTHER SUPPORT SERVICES"
562 "PRF-WASTE MANAGEMENT AND REMEDIATION SERVICES"
6111 "EDU-ELEMENTARY AND SECONDARY SCHOOLS"
61191 "611M1:EDU-COLLEGES AND UNIVERSITIES, AND PROFESSIONAL SCHOOLS, INCL JUNIOR COLLEGES"
61192 "611M2:EDU-BUSINESS, TECHNICAL, AND TRADE SCHOOLS AND TRAINING"
61193 "611M3:EDU-OTHER SCHOOLS AND INSTRUCTION, AND EDUCATIONAL SUPPORT SERVICES"
6211 "MED-OFFICES OF PHYSICIANS"
6212 "MED-OFFICES OF DENTISTS"
62131 "MED-OFFICE OF CHIROPRACTORS"
62132 "MED-OFFICES OF OPTOMETRISTS"
621389 "6213ZM:MED-OFFICES OF OTHER HEALTH PRACTITIONERS"
6214 "MED-OUTPATIENT CARE CENTERS"
6216 "MED-HOME HEALTH CARE SERVICES"
6219 "621M:MED-OTHER HEALTH CARE SERVICES"
6229 "622M:MED-GENERAL MEDICAL AND SURGICAL HOSPITALS, AND SPECIALTY (EXCEPT PSYCHIATRIC AND SUBSTANCE ABUSE) HOSPITALS"
6222 "MED-PSYCHIATRIC AND SUBSTANCE ABUSE HOSPITALS"
6231 "MED-NURSING CARE FACILITIES (SKILLED NURSING FACILITIES"
6239 "623M:MED-RESIDENTIAL CARE FACILITIES, EXCEPT SKILLED NURSING FACILITES"
6241 "SCA-INDIVIDUAL AND FAMILY SERVICES"
6242 "SCA-COMMUNITY FOOD AND HOUSING, AND EMERGENCY SERVICES"
6243 "SCA-VOCATIONAL REHABILITATION SERVICES"
6244 "SCA-CHILD DAY CARE SERVICES"
7111 "ENT-PERFORMING ARTS COMPANIES"
7112 "ENT-SPECTATOR SPORTS"
7119 "711M:ENT-PROMOTERS OF PERFORMING ARTS, SPORTS, AND SIMILAR EVENTS, AGENTS AND MANAGERS FOR ARTISTS, ATHLETES, ENTERTAINERS, AND OTHER PUBLIC FIGURES"
7115 "INDEPENDENT ARTISTS, WRITERS, AND PERFORMERS"
712 "ENT-MUSEUMS, ART GALLERIES, HISTORICAL SITES, AND SIMILAR INSTITUTIONS"
71395 "ENT-BOWLING CENTERS"
7138 "713Z:ENT-OTHER AMUSEMENT, GAMBLING, AND RECREATION INDUSTRIES"
7211 "ENT-TRAVELER ACCOMMODATION"
7219 "721M:ENT-RECREATIONAL VEHICLE PARKS AND CAMPS, AND ROOMING AND BOARDING HOUSES"
7224 "ENT-DRINKING PLACES, ALCOHOLIC BEVERAGES"
7228 "722Z:ENT-RESTAURANTS AND OTHER FOOD SERVICES"
811192 "SRV-CAR WASHES"
81118 "8111Z:SRV-AUTOMOTIVE REPAIR AND MAINTENANCE"
8112 "SRV-ELECTRONIC AND PRECISION EQUIPMENT REPAIR AND MAINTENANCE"
8113 "SRV-COMMERCIAL AND INDUSTRIAL MACHINERY AND EQUIPMENT REPAIR AND MAINTENANCE"
8114 "SRV-PERSONAL AND HOUSEHOLD GOODS REPAIR AND MAINTENANCE"
812111 "SRV-BARBER SHOPS"
812112 "SRV-BEAUTY SALONS"
81219 "8121M:SRV-NAIL SALONS AND OTHER PERSONAL CARE SERVICES"
8122 "SRV-FUNERAL HOMES, CEMETERIES AND CREMATORIES"
8123 "SRV-DRYCLEANING AND LAUNDRY SERVICES"
8129 "SRV-OTHER PERSONAL SERVICES"
8131 "SRV-RELIGIOUS ORGANIZATIONS"
81393 "SRV-LABOR UNIONS"
81398 "8139Z:SRV-BUSINESS, PROFESSIONAL, POLITICAL AND SIMILAR ORGANIZATIONS"
8139 "813M:SRV-CIVIC, SOCIAL, ADVOCACY ORGANIZATIONS, AND GRANTMAKING AND GIVING SERVICES"
814 "SRV-PRIVATE HOUSEHOLDS"
92113 "ADM-PUBLIC FINANCE ACTIVITIES"
92119 "ADM-OTHER GENERAL GOVERNMENT AND SUPPORT"
921197 "9211MP:ADM-EXECUTIVE OFFICES AND LEGISLATIVE BODIES"
923 "ADM-ADMINISTRATION OF HUMAN RESOURCE PROGRAMS"
92811071 "928110P1:MIL-U.S. ARMY"
92811072 "928110P2:MIL-U.S. AIR FORCE"
92811073 "928110P3:MIL-U.S. NAVY"
92811074 "928110P4:MIL-U.S. MARINES"
92811075 "928110P5:MIL-U.S. COAST GUARD"
92811076 "928110P6:MIL-U.S. ARMED FORCES, BRANCH n.s."
92811077 "928110P7:MIL-MILITARY RESERVES OR NATIONAL GUARD"
9287 "928P:ADM-NATIONAL SECURITY AND INTERNATIONAL AFFAIRS"
9291 "92M1:ADM-ADMINISTRATION OF ENVIRONMENTAL QUALITY AND HOUSING PROGRAMS"
9292 "92M2:ADM-ADMINISTRATION OF ECONOMIC PROGRAMS AND SPACE RESEARCH"
9297 "92MP:ADM-JUSTICE, PUBLIC ORDER, AND SAFETY ACTIVITIES"
999920 "UNEMPLOYED, AND LAST WORKED 5 YEARS AGO OR EARLIER OR NEVER WORKED"
;
#delimit cr
lab val ind_naics18 ind_naics18
lab var ind_naics18 "NAICS Industry Code"

notes ind_naics18: ACS: NAICSP
notes ind_naics18: North American Industry Classification System (NAICS) 
notes ind_naics18: Recode for 2018 and later based on 2017 NAICS codes

}

/*
Copyright 2020 CEPR, John Schmitt, Cherrie Bucknor, Brian Dew, Hye Jin Rho, Hayley Brown

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
