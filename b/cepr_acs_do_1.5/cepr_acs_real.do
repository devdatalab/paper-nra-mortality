set more 1

/*
File:	cepr_acs_real.do
Date:	Aug 24, 2011
	Oct 31, 2012
	Jan 23, 2013
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Converts nominal to real wages using the CPI-U-RS for CEPR extract 
       of American Community Survey
Note:	See copyright notice at end of program.
*/

capture program drop realw
program define realw
version 9.0
* create real wage variable for analysis
* convert to $2018 using CPI-U-RS
* (see BLS CPI-U-RS table at:
* https://www.bls.gov/cpi/research-series/allitems.pdf)
local year=year in 1
local basecpi=369.8 /* 2018 CPI-U-RS (All items)*/
local wage "`1'"


gen r`wage'=`wage'/(286.9/`basecpi') if `year'==2005
replace r`wage'=`wage'/(296.2/`basecpi') if `year'==2006
replace r`wage'=`wage'/(304.6/`basecpi') if `year'==2007
replace r`wage'=`wage'/(316.3/`basecpi') if `year'==2008
replace r`wage'=`wage'/(315.2/`basecpi') if `year'==2009
replace r`wage'=`wage'/(320.4/`basecpi') if `year'==2010
replace r`wage'=`wage'/(330.5/`basecpi') if `year'==2011
replace r`wage'=`wage'/(337.4/`basecpi') if `year'==2012
replace r`wage'=`wage'/(342.5/`basecpi') if `year'==2013
replace r`wage'=`wage'/(348.2/`basecpi') if `year'==2014
replace r`wage'=`wage'/(348.9/`basecpi') if `year'==2015
replace r`wage'=`wage'/(353.4/`basecpi') if `year'==2016
replace r`wage'=`wage'/(361.0/`basecpi') if `year'==2017
replace r`wage'=`wage'/(369.8/`basecpi') if `year'==2018

end


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

