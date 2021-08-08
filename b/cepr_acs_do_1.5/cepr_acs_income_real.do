set more 1

/*
File:	cepr_acs_income_real.do
Date:	Aug 24, 2011
	Oct 30, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	Mar 25, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Converts nominal to realw wages using the CPI-U-RS by running 
      cepr_acs_real.do program for CEPR's American Community Survey extract
*/


cd "$do"
do cepr_acs_real.do

			/******** Individuals ********/

realw incp_all_adj
lab var rincp_all_adj "Total Person's income adj"
notes rincp_all_adj: incp_all_adj, converted to realw wage using CPI-U-RS

realw incp_ern_adj
lab var rincp_ern_adj "Total Person's income, excluding unearned adj"
notes rincp_ern_adj: incp_ern_adj, converted to realw wage using CPI-U-RS

realw incp_wag_adj
lab var rincp_wag_adj "Income from wage and salary adj"
notes rincp_wag_adj: incp_wag_adj, converted to realw wage using CPI-U-RS

realw hrearn05_adj
lab var rhrearn05_adj "Hourly earnings adj"
notes rhrearn05_adj: hrearn05_adj, converted to realw wage using CPI-U-RS  

realw hrwage05_adj
lab var rhrwage05_adj "Hourly wage adj"
notes rhrwage05_adj: hrwage05_adj, converted to realw wage using CPI-U-RS

realw incp_se_adj
lab var rincp_se_adj "Income from self-employment adj"
notes rincp_se_adj: incp_se_adj, converted to realw wage using CPI-U-RS

realw incp_paw_adj
lab var rincp_paw_adj "Income from public assistance adj"
notes rincp_paw_adj: incp_paw_adj, converted to realw wage using CPI-U-RS

realw incp_ss_adj
lab var rincp_ss_adj "Income from social security adj"
notes rincp_ss_adj: incp_ss_adj, converted to realw wage using CPI-U-RS

realw incp_ssi_adj
lab var rincp_ssi_adj "Income from supplm. security adj"
notes rincp_ssi_adj: incp_ssi_adj, converted to realw wage using CPI-U-RS

realw incp_ret_adj
lab var rincp_ret_adj "Income from retirement funds adj"
notes rincp_ret_adj: incp_ret_adj, converted to realw wage using CPI-U-RS

realw incp_int_adj
lab var rincp_int_adj "Income from int, div, net rentals adj"
notes rincp_int_adj: incp_int_adj, converted to realw wage using CPI-U-RS

realw incp_oth_adj
lab var rincp_oth_adj "Income from other sources adj"
notes rincp_oth_adj: incp_oth_adj, converted to realw wage using CPI-U-RS

realw incp_uer_adj
lab var rincp_uer_adj "Income from all unearned sources adj"
notes rincp_uer_adj: incp_uer_adj, converted to realw wage using CPI-U-RS

			/******** Family ********/

realw incf_all_adj
lab var rincf_all_adj "Total family income adj"
notes rincf_all_adj: incf_all_adj, converted to realw wage using CPI-U-RS

			/******** Household ********/

realw inch_all_adj
lab var rinch_all_adj "Total household income adj"
notes rinch_all_adj: inch_all_adj, converted to realw wage using CPI-U-RS

realw inch_fs_adj
lab var rinch_fs_adj "HH income from food stamps adj"
notes rinch_fs_adj: inch_fs_adj, converted to realw wage using CPI-U-RS


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

