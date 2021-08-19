set more 1

/*
File:	cepr_acs_ind.do
Date:	Aug 17, 2011, CEPR ACS 0.9
	Oct 30, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent industry variables for CEPR extract of American Community Survey
Note:	See copyright notice at end of program.
*/

/* Determine survey year */

local year=year in 1

/* Industry 3 digit recode */

if 2005<=`year' & `year'<=2018 {
gen ind3d_05=.
gen ind3d_08=.
gen ind3d_09=.
gen ind3d_12=.
gen ind3d_13=.
gen ind3d_18=.
}
cd "$do"
cd cepr_acs_ind
do "cepr_acs_ind3d_05.do" /* Consistent for 2005-2007 */
do "cepr_acs_ind3d_08.do" /* Consistent for 2008 */
do "cepr_acs_ind3d_09.do" /* Consistent for 2009-2011 */
do "cepr_acs_ind3d_12.do" /* Consistent for 2012 */
do "cepr_acs_ind3d_13.do" /* Consistent for 2013-2017 */
do "cepr_acs_ind3d_18.do" /* Consistent for 2018 */

/* NAICS Industry Code */

cd "$do"
cd cepr_acs_ind
do "cepr_acs_ind_naics05.do" /* Consistent for 2005-2007*/
do "cepr_acs_ind_naics08.do" /* Consistent for 2008 */
do "cepr_acs_ind_naics09.do" /* Consistent for 2009-2011 */
do "cepr_acs_ind_naics12.do" /* Consistent for 2012 */
do "cepr_acs_ind_naics13.do" /* Consistent for 2013-2017 */
do "cepr_acs_ind_naics18.do" /* Consistent for 2018 */


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

