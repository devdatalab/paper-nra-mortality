/*********************************************************************
April, 2015  
 
 THIS IS AN EXAMPLE OF A PROGRAM THAT CAN BE USED TO READ IN THE
 PUBLIC-USE LINKED MORTALITY ASCII FILE AND RUN BASIC FREQUENCIES.
 
 NOTE: THE FORMAT DEFINITIONS GIVEN BELOW WILL RESULT IN
       PROCEDURE OUTPUT SHOWING VALUES THAT HAVE BEEN
       GROUPED AS THEY ARE SHOWN IN THE FILE LAYOUT
       DOCUMENTATION.
 
Public-use Linked Mortality-Follow-up through December 31, 2011

***********************************************************************

TO DOWNLOAD AND SAVE THE PUBLIC-USE LINKED MORTALITY FILES TO YOUR 
HARD DRIVE, FOLLOW THESE STEPS:

*STEP 1: DESIGNATE A FOLDER ON YOUR HARD DRIVE TO DOWNLOAD THE PUBLIC-USE LINKED 
		 MORTALITY FILE. IN THIS EXAMPLE, THE DATA WILL
         BE SAVED TO: 'C:\PUBLIC USE DATA'

*STEP 2: TO DOWNLOAD THE PUBLIC-USE LINKED MORTALITY FILE, GO TO THE WEB SITE: 
	     ftp:/ftp.cdc.gov/pub/Health_Statistics/NCHS/datalinkage/linked_mortality/.

		 RIGHT CLICK ON THE DESIRED SURVEY LINK AND SELECT "Save Target as...". A "Save as" 
		 SCREEN WILL APPEAR AND YOU WILL NEED TO SELECT AND INPUT A LOCATION WHERE TO SAVE 
	     	THE DATA FILE ON YOUR HARD DRIVE.

		 IT IS ALSO IMPORTANT THAT THE BOX "Save Type as" reads ".dat Document".
		 THIS WILL ENSURE THAT THE DATA FILE IS SAVED TO YOUR HARD DRIVE IN THE 
	     	CORRECT FORMAT. 

	  	 IN THIS EXAMPLE, WE SAVE THE DATA FILE IN THE FOLDER 'C:\PUBLIC USE DATA\' 
	    	 AND SAVE THE DATA FILE AS "SURVEYNAME_mort_public_use_2011.dat".


***********************************************************************/

# delimit ;
clear;
* set mem 200m NO LONGER NEEDED IN NEWER VERSIONS OF STATA;
* cd "C:\Public Use Data\" * SUBSTITUTE YOUR OWN LOCAL DIRECTORY IF NEEDED;
cd "" ;

/*READ IN THE PUBLIC-USE LINKED MORTALITY ASCII FILE */
/* INPUT ALL VARIABLES */
infix 
	str publicid 		1-14 	/* PUBLIC-USE ID FOR NHIS AND LSOA II */
	seqn			1-5	/* PUBLIC-USE ID FOR NHANES */
	eligstat 		15
	mortstat 		16
	causeavl		17
	str ucod_leading 	18-20 
	diabetes 		21 
	hyperten 		22 
	dodqtr			23	/*nhis and lsoa ii only*/
	dodyear			24-27	/*nhis and lsoa ii only*/
	wgt_new			28-35	/*nhis only*/
	sa_wgt_new		36-43 	/*nhis only*/
	permth_int		44-46	/*nhanes only*/
	permth_exm		47-49	/*nhanes only*/
	mortsrce_ndi		50
	mortsrce_cms		51
	mortsrce_ssa		52
	mortsrce_dc		53
	mortsrce_dcl		54

using ***SURVEY***_mort_2011_public.dat;

/* DEFINE VARIABLE LABELS */
label variable publicid "public-use id";
label variable eligstat "eligibility status for mortality follow-up";
label variable mortstat "final mortality status"; 
label variable mortsrce_ndi "mortality source: NDI match";
label variable mortsrce_ssa "mortality source: SSA information";
label variable mortsrce_cms	"mortality source: CMS information";
label variable mortsrce_dc	"mortality source: death certificate match";
label variable mortsrce_dcl	"mortality source: data collection";
label variable dodqtr  "quarter of death";
label variable dodyear "year of death";
label variable causeavl "cause of death data available";
label variable ucod_leading "underlying cause of death recode from UCOD_113 leading causes";
label variable diabetes "diabetes flag from multiple cause of death (mcod)";
label variable hyperten "hypertension flag from multiple cause of death (mcod)";
label variable wgt_new  "weight adjusted for ineligible respondents-person level sample weight";
label variable sa_wgt_new  "weight adjusted for ineligible respondents-sample adult sample weight";

/* DEFINE VALUE LABELS FOR REPORTS */

label define eligfmt
1	"Eligible"
2	"Under age 18, not available for public release "
3	"Ineligible"
;

label define mortfmt
0	"Assumed alive"
1	"Assumed Deceased"
/*.	"Ineligible for mortality follow-up or under age 18" */
;
label define msrcendifmt
1	"Yes"	
;

label define msrcessafmt
1	"Yes"	
;

label define msrcecmsfmt
1	"Yes"	
;

label define qtrfmt
1	"January-March"
2	"April-June"	
3	"July-September"
4	"October-December"
/* .	" Ineligible for mortality follow-up, under age 18, or assumed alive "*/
;

label define causefmt
0	"No"
1	"Yes"	
/* .	"Ineligible for mortality follow-up, under age 18, or assumed alive" */
;

label define flagfmt
0	"No"
1	"Yes- listed as a multiple cause of death"	
/* .	"Ineligible for mortality follow-up, under age 18, assumed alive, or cause of death code not available" */
;

/* ASSOCIATE VARIABLES WITH FORMAT VALUES */
label values eligstat	eligfmt;
label values mortstat	mortfmt;	
label values mortsrce_ndi msrcendifmt;
label values mortsrce_ssa msrcessafmt;
label values mortsrce_cms msrcecmsfmt;
label values mortsrce_dc  msrcecmsfmt;
label values mortsrce_dcl msrcecmsfmt;
label values dodqtr	qtrfmt;
label values causeavl	causefmt;
label values diabetes	flagfmt;
label values hyperten	flagfmt;
 
/* DISPLAY OVERALL DESCRIPTION OF FILE */
describe;

/*RUN FREQUENCIES- UNWEIGHTED */
tabulate eligstat, missing;
tabulate mortstat, missing;
tabulate mortsrce_ndi, missing; 
tabulate mortsrce_ssa, missing; 
tabulate mortsrce_cms, missing; 
tabulate mortsrce_dc, missing; 
tabulate mortsrce_dcl, missing; 
tabulate dodqtr, missing; 
tabulate dodyear, missing;
tabulate causeavl, missing; 
tabulate ucod_leading, missing; 
tabulate diabetes, missing;
tabulate hyperten, missing;  

/* DATA FILE IS STORED IN ***SURVEY***PMORT.DTA */
save ***SURVEY***_pmort, replace;

#delimit cr



