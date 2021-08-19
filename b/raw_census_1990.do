* NOTE: You need to set the Stata working directory to the path
* where the data file is located.
/* extracts census data from raw IPUMS .dat
*/

set more off

clear
quietly infix              ///
    int     year      1-4    ///
    byte    datanum   5-6    ///
    double  serial    7-14   ///
    double  hhwt      15-24  ///
    byte    region    25-26  ///
    byte    stateicp  27-28  ///
    int     county    29-32  ///
    byte    gq        33-33  ///
    int     pernum    34-37  ///
    double  perwt     38-47  ///
    double  slwt      48-57  ///
    byte    sex       58-58  ///
    int     age       59-61  ///
    byte    race      62-62  ///
    int     raced     63-65  ///
    byte    hispan    66-66  ///
    int     hispand   67-69  ///
    byte    educ      70-71  ///
    int     educd     72-74  ///
    byte    empstat   75-75  ///
    byte    empstatd  76-77  ///
    byte    labforce  78-78  ///
    long    inctot    79-85  ///
    using `"$mdata/raw/acs/census_1990.dat"'

replace hhwt     = hhwt     / 100
replace perwt    = perwt    / 100
replace slwt     = slwt     / 100

format serial   %8.0f
format hhwt     %10.2f
format perwt    %10.2f
format slwt     %10.2f

label var year     `"Census year"'
label var datanum  `"Data set number"'
label var serial   `"Household serial number"'
label var hhwt     `"Household weight"'
label var region   `"Census region and division"'
label var stateicp `"State (ICPSR code)"'
label var county   `"County"'
label var gq       `"Group quarters status"'
label var pernum   `"Person number in sample unit"'
label var perwt    `"Person weight"'
label var slwt     `"Sample-line weight"'
label var sex      `"Sex"'
label var age      `"Age"'
label var race     `"Race [general version]"'
label var raced    `"Race [detailed version]"'
label var hispan   `"Hispanic origin [general version]"'
label var hispand  `"Hispanic origin [detailed version]"'
label var educ     `"Educational attainment [general version]"'
label var educd    `"Educational attainment [detailed version]"'
label var empstat  `"Employment status [general version]"'
label var empstatd `"Employment status [detailed version]"'
label var labforce `"Labor force status"'
label var inctot   `"Total personal income"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label values year year_lbl

label define region_lbl 11 `"New England Division"'
label define region_lbl 12 `"Middle Atlantic Division"', add
label define region_lbl 13 `"Mixed Northeast Divisions (1970 Metro)"', add
label define region_lbl 21 `"East North Central Div."', add
label define region_lbl 22 `"West North Central Div."', add
label define region_lbl 23 `"Mixed Midwest Divisions (1970 Metro)"', add
label define region_lbl 31 `"South Atlantic Division"', add
label define region_lbl 32 `"East South Central Div."', add
label define region_lbl 33 `"West South Central Div."', add
label define region_lbl 34 `"Mixed Southern Divisions (1970 Metro)"', add
label define region_lbl 41 `"Mountain Division"', add
label define region_lbl 42 `"Pacific Division"', add
label define region_lbl 43 `"Mixed Western Divisions (1970 Metro)"', add
label define region_lbl 91 `"Military/Military reservations"', add
label define hispan_lbl 1 `"Mexican"', add
label define hispan_lbl 2 `"Puerto Rican"', add
label define hispan_lbl 3 `"Cuban"', add
label define hispan_lbl 4 `"Other"', add
label define hispand_lbl 402 `"Canal Zone"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label values empstatd empstatd_lbl

save $mdata/raw/acs/1990.dta, replace


