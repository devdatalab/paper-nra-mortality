/*------------------------------------------------
  This program reads the 2004 National Health Interview Survey 2004 personsx  Data File
  by Jean Roth Mon Jul  2 15:51:18 EDT 2007
  Please report errors to jroth@nber.org 
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http:/www.gnu.org/licenses/ for details.
  Run with do nhis2004_personsx
----------------------------------------------- */

/* The following line should contain
   the complete path and name of the raw data file.
   On a PC, use backslashes in paths as in C:\  */

local dat_name "$mdata/nhis_data/2004/personsx.dat"

/* The following line should contain the path to your output '.dta' file */

local dta_name "$mdata/nhis_data/nhis2004_personsx"

/* The following line should contain the path to the data dictionary file */

local dct_name "$mdata/nhis_data/nhis2004_personsx.dct"

infile using "`dct_name'", using("`dat_name'") clear

save $mdata/nhis_data/clean/nhis2004_personsx.dta, replace 

/*
Copyright 2007 shared by the National Bureau of Economic Research and Jean Roth

National Bureau of Economic Research.
1050 Massachusetts Avenue
Cambridge, MA 02138
jroth@nber.org

This program and all programs referenced in it are free software. You
can redistribute the program or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA.
*/
