********************************************************************************
* September 2018

**PUBLIC-USE LINKED MORTALITY FOLLOW-UP THROUGH DECEMBER 31, 2015 **

* The following Stata code can be used to read the fixed-width format ASCII
*public-use Linked Mortality Files (LMFs) from a stored location into a
*Stata dataset.  Basic frequencies are also produced.

/*
NOTE:The format definitions given below will result in procedure output
showing values that have been grouped as they are shown in the file layout
documentation.


To download and save the public-use LMFs to your hard drive, follow these steps:

*Step 1: Designate a folder on your hard drive to download the public-use LMF.
 In this example, the data will be saved to: 'C:\PUBLIC USE DATA'

*Step 2: To dowload the public-use LMF, go to the web site:
     ftp:/ftp.cdc.gov/pub/health_statistics/nchs/datalinkage/linked_mortality/.

         Right click on the desired survey link and select "Save target as...".
 A "Save As" screen will appear where you will need to select and input
 a location where to save the data file on your hard drive.

         Also note that the "Save as type:" box should read "DAT File (*.dat)".
 This will ensure that the data file is saved to your hard drive in the
 correct format.

         In this example, the data file is saved in the folder, "C:\PUBLIC USE DATA",
 and the data file is saved as "<SURVEYNAME>_MORT_2015_PUBLIC.DAT".
*/



clear 
# delimit cr // SET COMMAND DELIMITER TO ; INSTEAD OF CARRIAGE RETURN

**************
*NHIS VERSION*
**************

// DEFINE VALUE LABELS FOR REPORTS
label define eligfmt 1 "Eligible" 2 "Under age 18, not available for public release" 3 "Ineligible"
label define mortfmt 0 "Assumed alive" 1 "Determined deceased" .z "Ineligible or under age 18"
label define flagfmt 0 "No - Condition not listed as a multiple cause of death" 1 "Yes - Condition listed as a multiple cause of death".z "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available"
label define qtrfmt 1 "January-March" 2 "April-June" 3 "July-September" 4 "October-December" .z "Ineligible, under age 18, or assumed alive"
label define dodyfmt .z "Ineligible, under age 18, or assumed alive"
label define ucodfmt 1 "Diseases of heart (I00-I09, I11, I13, I20-I51)" 2 "Malignant neoplasms (C00-C97)" 3 "Chronic lower respiratory diseases (J40-J47)" 4 "Accidents (unintentional injuries) (V01-X59, Y85-Y86)" 5 "Cerebrovascular diseases (I60-I69)" 6 "Alzheimer's disease (G30)" 7 "Diabetes mellitus (E10-E14)" 8 "Influenza and pneumonia (J09-J18)" 9 "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)" 10 "All other causes (residual)" .z "Ineligible, under age 18, assumed alive, or no cause of death data"


// READ IN THE FIXED-WIDTH FORMAT ASCII PUBLIC-USE LMF
infix str publicid 1-14 eligstat 15 mortstat 16 ucod_leading 17-19 diabetes 20 hyperten 21 dodqtr 22 dodyear 23-26 wgt_new 27-34 sa_wgt_new 35-42 using $mdata/raw/nhis//NHIS_2006_MORT_2015_PUBLIC.dat // Substitute relevant survey name, e.g. NHIS_1986


// REPLACE MISSING VALUES TO .z FOR LABELING
replace mortstat = .z if mortstat >=.
replace ucod_leading = .z if ucod_leading >=.
replace diabetes = .z if diabetes >=.
replace hyperten = .z if hyperten >=.
replace dodqtr = .z if dodqtr >=.
replace dodyear = .z if dodyear >=.


// DEFINE VARIABLE LABELS
label var publicid "NHIS Public-ID Number"
label var eligstat "Eligibility Status for Mortality Follow-up"
label var mortstat "Final Mortality Status"
label var ucod_leading "Underlying Cause of Death: Recode"
label var diabetes "Diabetes flag from Multiple Cause of Death"
label var hyperten "Hypertension flag from Multiple Cause of Death"
label var dodqtr  "Quarter of Death"
label var dodyear "Year of Death"
label var wgt_new  "Weight Adjusted for Ineligible Respondents: Person-level Sample Weight"
label var sa_wgt_new  "Weight Adjusted for Ineligible Respondents: Sample Adult Sample Weight"


// ASSOCIATE VARIABLES WITH FORMAT VALUES
label values eligstat eligfmt
label values mortstat mortfmt
label values ucod_leading ucodfmt
label values dodqtr qtrfmt
label values diabetes flagfmt
label values hyperten flagfmt
label values dodyear dodyfmt


// DISPLAY OVERALL DESCRIPTION OF FILE
describe


// ONE-WAY FREQUENCIES (UNWEIGHTED)
tab1 eligstat mortstat ucod_leading diabetes hyperten dodqtr dodyear, missing


// IF REPLACING AN EXISTING .DTA FILE, USE:
save $mdata/int/nhis/clean/nhis2006_pmort, replace

#delimit cr

