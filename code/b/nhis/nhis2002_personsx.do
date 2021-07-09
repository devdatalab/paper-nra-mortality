set mem 1000m

/*------------------------------------------------
  This program reads the 2002 National Health Interview Survey 2002 personsx  Data File
  by Jean Roth Mon Jul  2 15:44:35 EDT 2007
  Please report errors to jroth@nber.org 
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http:/www.gnu.org/licenses/ for details.
  Run with do nhis2002_personsx
----------------------------------------------- */

/* The following line should contain
   the complete path and name of the raw data file.
   On a PC, use backslashes in paths as in C:\  */

local dat_name "$mdata/nhis_data/2002/personsx.dat"

/* The following line should contain the path to your output '.dta' file */

local dta_name "$mdata/nhis_data/nhis2002_personsx"

/* The following line should contain the path to the data dictionary file */

local dct_name "$mdata/nhis_data/nhis2002_personsx.dct"

infile using "`dct_name'", using("`dat_name'") clear


*Everything below this point are value labels
/* 
#delimit ;

;
label values rectype  rectype;
label define rectype 
	20          "Person"                        
;
label values srvy_yr  srvy_yr;
label define srvy_yr 
	2002        "2002"                          
;
label values intv_qrt intv_qrt;
label define intv_qrt
	1           "Quarter 1"                     
	2           "Quarter 2"                     
	3           "Quarter 3"                     
	4           "Quarter 4"                     
;
label values sex      sex;    
label define sex     
	1           "Male"                          
	2           "Female"                        
;
label values age_p    age_p;  
label define age_p   
	00          "Under 1 year"                  
	85          "85+ years"                     
;
label values r_age1   r_age1l;
label define r_age1l 
	1           "Under 5 years"                 
	2           "5-17 years"                    
	3           "18-24 years"                   
	4           "25-44 years"                   
	5           "45-64 years"                   
	6           "65-69 years"                   
	7           "70-74 years"                   
	8           "75 years and over"             
;
label values r_age2   r_age2l;
label define r_age2l 
	1           "Under 6 years"                 
	2           "6-16 years"                    
	3           "17-24 years"                   
	4           "25-34 years"                   
	5           "35-44 years"                   
	6           "45-54 years"                   
	7           "55-64 years"                   
	8           "65-74 years"                   
	9           "75 years and over"             
	"02"        "February"                      
	"03"        "March"                         
	"04"        "April"                         
	"05"        "May"                           
	"06"        "June"                          
	"07"        "July"                          
	"08"        "August"                        
	"09"        "September"                     
	"10"        "October"                       
	"11"        "November"                      
	"12"        "December"                      
	"97"        "Refused"                       
	"98"        "Not ascertained"               
	"99"        "Don't know"                    
	"9997"      "Refused"                       
	"9998"      "Not ascertained"               
	"9999"      "Don't know"                    
;
label values origin_i origin_i;
label define origin_i
	1           "Yes"                           
	2           "No"                            
;
label values origimpt origimpt;
label define origimpt
	1           "Imputed 'refused' Hispanic Origin response"
	2           "Imputed 'not ascertained' Hispanic Origin"
	3           "Imputed 'does not know' Hispanic Origin"
	4           "Hispanic origin given by respondent/proxy"
;
label values hispan_i hispan_i;
label define hispan_i
	00          "Multiple Hispanic"             
	01          "Puerto Rican"                  
	02          "Mexican"                       
	03          "Mexican-American"              
	04          "Cuban/Cuban American"          
	05          "Dominican (Republic)"          
	06          "Central or South American"     
	07          "Other Latin American; type not specified"
	08          "Other Spanish"                 
	09          "Hispanic/Latino/Spanish; non-specific type"
	10          "Hispanic/Latino/Spanish; type refused"
	11          "Hispanic/Latino/Spanish; type not ascertained"
	12          "Not Hispanic/Spanish origin"   
;
label values hispimpt hispimpt;
label define hispimpt
	1           "Imputed 'refused' Hispanic Origin type"
	2           "Imputed 'not ascertained' Hispanic Origin type"
	3           "Imputed 'does not know' Hispanic Origin type"
	4           "Hispanic Origin type given by respondent/proxy"
;
label values rcdt1p_i rcdt1p_i;
label define rcdt1p_i
	01          "White only"                    
	02          "Black/African American only"   
	03          "AIAN only"                     
	09          "Asian Indian only"             
	10          "Chinese only"                  
	11          "Filipino only"                 
	15          "Other Asian only"              
	16          "Other race only"               
	17          "Multiple detailed race*"       
;
label values rc_smp_i rc_smp_i;
label define rc_smp_i
	01          "White only"                    
	02          "Black/African American only"   
	03          "AIAN only*"                    
	04          "Asian only"                    
	05          "Other race only"               
	06          "Multiple detailed race only"   
;
label values racerp_i racerp_i;
label define racerp_i
	01          "White only"                    
	02          "Black/African American only"   
	03          "AIAN* only"                    
	04          "Asian only"                    
	05          "Other race only"               
	06          "Multiple race"                 
;
label values raceimpt raceimpt;
label define raceimpt
	1           "Imputed 'refused' race response"
	2           "Imputed 'not ascertained' race response"
	3           "Imputed 'does not know' race response"
	4           "Race given by respondent/proxy"
;
label values mracrp_i mracrp_i;
label define mracrp_i
	01          "White"                         
	02          "Black/African American"        
	03          "Indian (American); Alaska Native"
	09          "Asian Indian"                  
	10          "Chinese"                       
	11          "Filipino"                      
	15          "Other Asian*"                  
	16          "Other Race*"                   
	17          "Multiple Race*"                
;
label values mracbp_i mracbp_i;
label define mracbp_i
	01          "White"                         
	02          "Black/African American"        
	03          "Indian (American) (includes Eskimo; Aleut)"
	06          "Chinese"                       
	07          "Filipino"                      
	12          "Asian Indian"                  
	16          "Other race"                    
	17          "Multiple race"                 
;
label values racrec_i racrec_i;
label define racrec_i
	1           "White"                         
	2           "Black"                         
	3           "Other"                         
;
label values hiscod_i hiscod_i;
label define hiscod_i
	1           "Hispanic"                      
	2           "Non-Hispanic White"            
	3           "Non-Hispanic Black"            
	4           "Non-Hispanic Other"            
;
label values erimpflg erimpflg;
label define erimpflg
	1           "Ethnicity/race imputed"        
	2           "Ethnicity/race given by respondent/proxy"
;
label values r_maritl r_maritl;
label define r_maritl
	0           "Under 14 years"                
	1           "Married - spouse in household" 
	2           "Married - spouse not in household"
	3           "Married - spouse in household unknown"
	4           "Widowed"                       
	5           "Divorced"                      
	6           "Separated"                     
	7           "Never married"                 
	8           "Living with partner"           
	9           "Unknown marital status"        
;
label values cohab1   cohab1l;
label define cohab1l 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values cohab2   cohab2l;
label define cohab2l 
	1           "Married"                       
	2           "Widowed"                       
	3           "Divorced"                      
	4           "Separated"                     
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lg_mstat lg_mstat;
label define lg_mstat
	1           "Married; spouse in household"  
	2           "Married; spouse not in household"
	3           "Married; spouse in household unknown"
	4           "Widowed"                       
	5           "Divorced"                      
	6           "Separated"                     
	7           "Never Married"                 
	9           "Unknown marital status"        
;
label values cdcmstat cdcmstat;
label define cdcmstat
	1           "Separated"                     
	2           "Divorced"                      
	3           "Married"                       
	4           "Single/never married"          
	5           "Widowed"                       
	9           "Unknown marital status"        
;
label values rrp      rrp;    
label define rrp     
	01          "Household reference person"    
	02          "Spouse (husband/wife)"         
	03          "Unmarried Partner"             
	04          "Child (biological/adoptive/in-law/step/foster)"
	05          "Child of partner"              
	06          "Grandchild"                    
	07          "Parent (bio./adoptive/in-law/step/foster)"
	08          "Brother/sister (bio./adop./in-law/step/foster)"
	09          "Grandparent (Grandmother/Grandfather)"
	10          "Aunt/Uncle"                    
	11          "Niece/Nephew"                  
	12          "Other relative"                
	13          "Housemate/roommate"            
	14          "Roomer/Boarder"                
	15          "Other nonrelative"             
	16          "Legal guardian"                
	17          "Ward"                          
	97          "Refused"                       
	99          "Don't know"                    
	"8"         "Not ascertained"               
	"           "      <Blank:  Not reference person>"
;
label values frrp     frrp;   
label define frrp    
	01          "Family reference person"       
	02          "Spouse (husband/wife)"         
	03          "Unmarried Partner"             
	04          "Child (biological/adoptive/in-law/step/foster)"
	05          "Child of partner"              
	06          "Grandchild"                    
	07          "Parent (bio./adoptive/in-law/step/foster)"
	08          "Brother/sister (bio./adop./in-law/step/foster)"
	09          "Grandparent (Grandmother/Grandfather)"
	10          "Aunt/Uncle"                    
	11          "Niece/Nephew"                  
	12          "Other relative"                
	16          "Legal guardian"                
	17          "Ward"                          
	97          "Refused"                       
	99          "Don't know"                    
	"8"         "Not ascertained"               
	"           "      <Blank:  Not reference person>"
;
label values fm_resp  fm_resp;
label define fm_resp 
	98          "Not ascertained"               
	"8"         "Not ascertained"               
	"           "      <Blank:  Not family respondent>"
;
label values sib_deg  sib_deg;
label define sib_deg 
	1           "Full  {brother/sister}"        
	2           "Half {brother/sister}"         
	3           "Adopted {brother/sister}"      
	4           "Step {brother/sister}"         
	5           "Foster {brother/sister}"       
	6           "{brother/sister}-in-law"       
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
	"96"        "Has legal guardian"            
	"97"        "Refused"                       
	"98"        "Not ascertained"               
	"99"        "Don't know"                    
;
label values mom_deg  mom_deg;
label define mom_deg 
	1           "Biological"                    
	2           "Step"                          
	3           "Adoptive"                      
	4           "Foster"                        
	5           "In-law"                        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
	"96"        "Has legal guardian"            
	"97"        "Refused"                       
	"98"        "Not ascertained"               
	"99"        "Don't know"                    
;
label values dad_deg  dad_deg;
label define dad_deg 
	1           "Biological"                    
	2           "Step"                          
	3           "Adoptive"                      
	4           "Foster"                        
	5           "In-law"                        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
	"97"        "Refused"                       
	"98"        "Not ascertained"               
	"99"        "Don't know"                    
	"           "      Not in Universe"         
;
label values parents  parents;
label define parents 
	1           "Mother; no father"             
	2           "Father; no mother"             
	3           "Mother and father"             
	4           "Neither mother nor father"     
	9           "Unknown"                       
;
label values mom_ed   mom_ed; 
label define mom_ed  
	01          "Less/equal to 8th grade"       
	02          "9-12th grade; no high school diploma"
	03          "High school graduate/GED recipient"
	04          "Some college; no degree"       
	05          "AA degree; technical or vocational"
	06          "AA degree; academic program"   
	07          "Bachelor's degree"             
	08          "Master's; professional; or doctoral degree"
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values dad_ed   dad_ed; 
label define dad_ed  
	01          "Less/equal to 8th grade"       
	02          "9-12th grade; no high school diploma"
	03          "High school graduate/GED recipient"
	04          "Some college; no degree"       
	05          "AA degree; technical or vocational"
	06          "AA degree; academic program"   
	07          "Bachelor's degree"             
	08          "Master's; professional; or doctoral degree"
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values fm_type  fm_type;
label define fm_type 
	1           "One adult; no child(ren) under 18"
	2           "Multiple adults; no child(ren) under 18"
	3           "One adult; 1+ child(ren) under 18"
	4           "Multiple adults; 1+ child(ren) under 18"
	9           "Unknown"                       
;
label values nowaf    nowaf;  
label define nowaf   
	1           "Armed Forces"                  
	2           "Not Armed Forces"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values astatflg astatflg;
label define astatflg
	0           "Sample Adult - no record"      
	1           "Sample Adult - has record"     
	2           "Not selected as Sample Adult"  
	3           "No one selected as Sample Adult"
	4           "Armed Force member"            
	5           "Armed Force member - selected as Sample Adult"
;
label values cstatflg cstatflg;
label define cstatflg
	0           "Sample Child - no record"      
	1           "Sample Child - has record"     
	2           "Not selected as Sample Child"  
	3           "No one selected as Sample Child"
	4           "Emancipated Minor"             
;
label values immunflg immunflg;
label define immunflg
	0           "Immunization Child - no record"
	1           "Immunization Child - has record"
	2           "Not eligible for immunization questions"
;
label values region   region; 
label define region  
	1           "Northeast"                     
	2           "Midwest"                       
	3           "South"                         
	4           "West"                          
;
label values plaplylm plaplylm;
label define plaplylm
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plaplyun plaplyun;
label define plaplyun
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pspedeis pspedeis;
label define pspedeis
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pspedem  pspedem;
label define pspedem 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plaadl   plaadl; 
label define plaadl  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values labath   labath; 
label define labath  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladress  ladress;
label define ladress 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values laeat    laeat;  
label define laeat   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values labed    labed;  
label define labed   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values latoilt  latoilt;
label define latoilt 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahome   lahome; 
label define lahome  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plaiadl  plaiadl;
label define plaiadl 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plawknow plawknow;
label define plawknow
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plawklim plawklim;
label define plawklim
	0           "Unable to work"                
	1           "Limited in work"               
	2           "Not limited in work"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plawalk  plawalk;
label define plawalk 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plaremem plaremem;
label define plaremem
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plimany  plimany;
label define plimany 
	0           "Limitation previously mentioned"
	1           "Yes; limited in some other way"
	2           "Not limited in any way"        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values la1ar    la1ar;  
label define la1ar   
	1           "Limited in any way"            
	2           "Not limited in any way"        
	3           "Unknown if limited"            
;
label values lahcc1   lahcc1l;
label define lahcc1l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc2   lahcc2l;
label define lahcc2l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc3   lahcc3l;
label define lahcc3l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc4   lahcc4l;
label define lahcc4l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc5   lahcc5l;
label define lahcc5l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc6   lahcc6l;
label define lahcc6l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc7   lahcc7l;
label define lahcc7l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc8   lahcc8l;
label define lahcc8l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc9   lahcc9l;
label define lahcc9l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc10  lahcc10l;
label define lahcc10l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc11  lahcc11l;
label define lahcc11l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc12  lahcc12l;
label define lahcc12l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc13  lahcc13l;
label define lahcc13l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc90  lahcc90l;
label define lahcc90l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahcc91  lahcc91l;
label define lahcc91l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lctime1  lctime1l;
label define lctime1l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit1  lcunit1l;
label define lcunit1l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura1  lcdura1l;
label define lcdura1l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb1  lcdurb1l;
label define lcdurb1l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc1  lcchrc1l;
label define lcchrc1l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime2  lctime2l;
label define lctime2l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit2  lcunit2l;
label define lcunit2l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura2  lcdura2l;
label define lcdura2l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb2  lcdurb2l;
label define lcdurb2l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc2  lcchrc2l;
label define lcchrc2l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime3  lctime3l;
label define lctime3l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit3  lcunit3l;
label define lcunit3l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura3  lcdura3l;
label define lcdura3l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb3  lcdurb3l;
label define lcdurb3l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc3  lcchrc3l;
label define lcchrc3l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime4  lctime4l;
label define lctime4l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit4  lcunit4l;
label define lcunit4l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura4  lcdura4l;
label define lcdura4l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb4  lcdurb4l;
label define lcdurb4l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc4  lcchrc4l;
label define lcchrc4l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime5  lctime5l;
label define lctime5l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit5  lcunit5l;
label define lcunit5l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura5  lcdura5l;
label define lcdura5l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb5  lcdurb5l;
label define lcdurb5l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc5  lcchrc5l;
label define lcchrc5l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime6  lctime6l;
label define lctime6l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit6  lcunit6l;
label define lcunit6l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura6  lcdura6l;
label define lcdura6l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb6  lcdurb6l;
label define lcdurb6l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc6  lcchrc6l;
label define lcchrc6l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime7  lctime7l;
label define lctime7l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit7  lcunit7l;
label define lcunit7l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura7  lcdura7l;
label define lcdura7l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb7  lcdurb7l;
label define lcdurb7l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc7  lcchrc7l;
label define lcchrc7l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime8  lctime8l;
label define lctime8l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit8  lcunit8l;
label define lcunit8l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura8  lcdura8l;
label define lcdura8l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb8  lcdurb8l;
label define lcdurb8l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc8  lcchrc8l;
label define lcchrc8l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime9  lctime9l;
label define lctime9l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit9  lcunit9l;
label define lcunit9l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura9  lcdura9l;
label define lcdura9l
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb9  lcdurb9l;
label define lcdurb9l
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc9  lcchrc9l;
label define lcchrc9l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime10 lctime1j;
label define lctime1j
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit10 lcunit1j;
label define lcunit1j
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura10 lcdura1j;
label define lcdura1j
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb10 lcdurb1j;
label define lcdurb1j
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc10 lcchrc1j;
label define lcchrc1j
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime11 lctime1a;
label define lctime1a
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit11 lcunit1a;
label define lcunit1a
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura11 lcdura1a;
label define lcdura1a
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb11 lcdurb1a;
label define lcdurb1a
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc11 lcchrc1a;
label define lcchrc1a
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime12 lctime1b;
label define lctime1b
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit12 lcunit1b;
label define lcunit1b
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura12 lcdura1b;
label define lcdura1b
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb12 lcdurb1b;
label define lcdurb1b
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc12 lcchrc1b;
label define lcchrc1b
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime13 lctime1c;
label define lctime1c
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit13 lcunit1c;
label define lcunit1c
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura13 lcdura1c;
label define lcdura1c
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb13 lcdurb1c;
label define lcdurb1c
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc13 lcchrc1c;
label define lcchrc1c
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime90 lctime9j;
label define lctime9j
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit90 lcunit9j;
label define lcunit9j
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura90 lcdura9j;
label define lcdura9j
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb90 lcdurb9j;
label define lcdurb9j
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc90 lcchrc9j;
label define lcchrc9j
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lctime91 lctime9a;
label define lctime9a
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcunit91 lcunit9a;
label define lcunit9a
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcdura91 lcdura9a;
label define lcdura9a
	00          "Less than 1 year"              
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values lcdurb91 lcdurb9a;
label define lcdurb9a
	0           "Since birth and child < 1 year of age"
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lcchrc91 lcchrc9a;
label define lcchrc9a
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lahca1   lahca1l;
label define lahca1l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca2   lahca2l;
label define lahca2l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca3   lahca3l;
label define lahca3l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca4   lahca4l;
label define lahca4l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca5   lahca5l;
label define lahca5l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca6   lahca6l;
label define lahca6l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca7   lahca7l;
label define lahca7l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca8   lahca8l;
label define lahca8l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca9   lahca9l;
label define lahca9l 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca10  lahca10l;
label define lahca10l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca11  lahca11l;
label define lahca11l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca12  lahca12l;
label define lahca12l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca13  lahca13l;
label define lahca13l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca14  lahca14l;
label define lahca14l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca15  lahca15l;
label define lahca15l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca16  lahca16l;
label define lahca16l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca17  lahca17l;
label define lahca17l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca18  lahca18l;
label define lahca18l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca19  lahca19l;
label define lahca19l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca20  lahca20l;
label define lahca20l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca21  lahca21l;
label define lahca21l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca22  lahca22l;
label define lahca22l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca23  lahca23l;
label define lahca23l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca24  lahca24l;
label define lahca24l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca25  lahca25l;
label define lahca25l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca26  lahca26l;
label define lahca26l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca27  lahca27l;
label define lahca27l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca28  lahca28l;
label define lahca28l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca29  lahca29l;
label define lahca29l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca30  lahca30l;
label define lahca30l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca31  lahca31l;
label define lahca31l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca32  lahca32l;
label define lahca32l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca33  lahca33l;
label define lahca33l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca34  lahca34l;
label define lahca34l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca90  lahca90l;
label define lahca90l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lahca91  lahca91l;
label define lahca91l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	6           "No condition at all"           
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values latime1  latime1l;
label define latime1l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit1  launit1l;
label define launit1l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura1  ladura1l;
label define ladura1l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb1  ladurb1l;
label define ladurb1l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc1  lachrc1l;
label define lachrc1l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime2  latime2l;
label define latime2l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit2  launit2l;
label define launit2l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura2  ladura2l;
label define ladura2l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb2  ladurb2l;
label define ladurb2l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc2  lachrc2l;
label define lachrc2l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime3  latime3l;
label define latime3l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit3  launit3l;
label define launit3l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura3  ladura3l;
label define ladura3l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb3  ladurb3l;
label define ladurb3l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc3  lachrc3l;
label define lachrc3l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime4  latime4l;
label define latime4l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit4  launit4l;
label define launit4l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura4  ladura4l;
label define ladura4l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb4  ladurb4l;
label define ladurb4l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc4  lachrc4l;
label define lachrc4l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime5  latime5l;
label define latime5l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit5  launit5l;
label define launit5l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura5  ladura5l;
label define ladura5l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb5  ladurb5l;
label define ladurb5l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc5  lachrc5l;
label define lachrc5l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime6  latime6l;
label define latime6l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit6  launit6l;
label define launit6l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura6  ladura6l;
label define ladura6l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb6  ladurb6l;
label define ladurb6l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc6  lachrc6l;
label define lachrc6l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime7  latime7l;
label define latime7l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit7  launit7l;
label define launit7l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura7  ladura7l;
label define ladura7l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb7  ladurb7l;
label define ladurb7l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc7  lachrc7l;
label define lachrc7l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime8  latime8l;
label define latime8l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit8  launit8l;
label define launit8l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura8  ladura8l;
label define ladura8l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb8  ladurb8l;
label define ladurb8l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc8  lachrc8l;
label define lachrc8l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime9  latime9l;
label define latime9l
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit9  launit9l;
label define launit9l
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura9  ladura9l;
label define ladura9l
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb9  ladurb9l;
label define ladurb9l
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc9  lachrc9l;
label define lachrc9l
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime10 latime1j;
label define latime1j
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit10 launit1j;
label define launit1j
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura10 ladura1j;
label define ladura1j
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb10 ladurb1j;
label define ladurb1j
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc10 lachrc1j;
label define lachrc1j
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime11 latime1a;
label define latime1a
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit11 launit1a;
label define launit1a
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura11 ladura1a;
label define ladura1a
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb11 ladurb1a;
label define ladurb1a
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc11 lachrc1a;
label define lachrc1a
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime12 latime1b;
label define latime1b
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit12 launit1b;
label define launit1b
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura12 ladura1b;
label define ladura1b
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb12 ladurb1b;
label define ladurb1b
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc12 lachrc1b;
label define lachrc1b
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime13 latime1c;
label define latime1c
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit13 launit1c;
label define launit1c
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura13 ladura1c;
label define ladura1c
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb13 ladurb1c;
label define ladurb1c
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc13 lachrc1c;
label define lachrc1c
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime14 latime1d;
label define latime1d
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit14 launit1d;
label define launit1d
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura14 ladura1d;
label define ladura1d
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb14 ladurb1d;
label define ladurb1d
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc14 lachrc1d;
label define lachrc1d
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime15 latime1e;
label define latime1e
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit15 launit1e;
label define launit1e
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura15 ladura1e;
label define ladura1e
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb15 ladurb1e;
label define ladurb1e
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc15 lachrc1e;
label define lachrc1e
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime16 latime1f;
label define latime1f
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit16 launit1f;
label define launit1f
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura16 ladura1f;
label define ladura1f
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb16 ladurb1f;
label define ladurb1f
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc16 lachrc1f;
label define lachrc1f
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime17 latime1g;
label define latime1g
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit17 launit1g;
label define launit1g
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura17 ladura1g;
label define ladura1g
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb17 ladurb1g;
label define ladurb1g
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc17 lachrc1g;
label define lachrc1g
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime18 latime1h;
label define latime1h
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit18 launit1h;
label define launit1h
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura18 ladura1h;
label define ladura1h
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb18 ladurb1h;
label define ladurb1h
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc18 lachrc1h;
label define lachrc1h
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime19 latime1i;
label define latime1i
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit19 launit1i;
label define launit1i
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura19 ladura1i;
label define ladura1i
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb19 ladurb1i;
label define ladurb1i
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc19 lachrc1i;
label define lachrc1i
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime20 latime2j;
label define latime2j
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit20 launit2j;
label define launit2j
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura20 ladura2j;
label define ladura2j
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb20 ladurb2j;
label define ladurb2j
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc20 lachrc2j;
label define lachrc2j
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime21 latime2a;
label define latime2a
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit21 launit2a;
label define launit2a
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura21 ladura2a;
label define ladura2a
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb21 ladurb2a;
label define ladurb2a
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc21 lachrc2a;
label define lachrc2a
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime22 latime2b;
label define latime2b
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit22 launit2b;
label define launit2b
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura22 ladura2b;
label define ladura2b
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb22 ladurb2b;
label define ladurb2b
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc22 lachrc2b;
label define lachrc2b
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime23 latime2c;
label define latime2c
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit23 launit2c;
label define launit2c
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura23 ladura2c;
label define ladura2c
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb23 ladurb2c;
label define ladurb2c
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc23 lachrc2c;
label define lachrc2c
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime24 latime2d;
label define latime2d
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit24 launit2d;
label define launit2d
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura24 ladura2d;
label define ladura2d
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb24 ladurb2d;
label define ladurb2d
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc24 lachrc2d;
label define lachrc2d
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime25 latime2e;
label define latime2e
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit25 launit2e;
label define launit2e
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura25 ladura2e;
label define ladura2e
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb25 ladurb2e;
label define ladurb2e
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc25 lachrc2e;
label define lachrc2e
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime26 latime2f;
label define latime2f
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit26 launit2f;
label define launit2f
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura26 ladura2f;
label define ladura2f
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb26 ladurb2f;
label define ladurb2f
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc26 lachrc2f;
label define lachrc2f
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime27 latime2g;
label define latime2g
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit27 launit2g;
label define launit2g
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura27 ladura2g;
label define ladura2g
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb27 ladurb2g;
label define ladurb2g
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc27 lachrc2g;
label define lachrc2g
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime28 latime2h;
label define latime2h
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit28 launit2h;
label define launit2h
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura28 ladura2h;
label define ladura2h
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb28 ladurb2h;
label define ladurb2h
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc28 lachrc2h;
label define lachrc2h
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime29 latime2i;
label define latime2i
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit29 launit2i;
label define launit2i
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura29 ladura2i;
label define ladura2i
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb29 ladurb2i;
label define ladurb2i
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc29 lachrc2i;
label define lachrc2i
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime30 latime3j;
label define latime3j
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit30 launit3j;
label define launit3j
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura30 ladura3j;
label define ladura3j
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb30 ladurb3j;
label define ladurb3j
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc30 lachrc3j;
label define lachrc3j
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime31 latime3a;
label define latime3a
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit31 launit3a;
label define launit3a
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura31 ladura3a;
label define ladura3a
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb31 ladurb3a;
label define ladurb3a
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc31 lachrc3a;
label define lachrc3a
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime32 latime3b;
label define latime3b
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit32 launit3b;
label define launit3b
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura32 ladura3b;
label define ladura3b
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb32 ladurb3b;
label define ladurb3b
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc32 lachrc3b;
label define lachrc3b
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime33 latime3c;
label define latime3c
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit33 launit3c;
label define launit3c
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura33 ladura3c;
label define ladura3c
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb33 ladurb3c;
label define ladurb3c
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc33 lachrc3c;
label define lachrc3c
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime34 latime3d;
label define latime3d
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit34 launit3d;
label define launit3d
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura34 ladura3d;
label define ladura3d
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb34 ladurb3d;
label define ladurb3d
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc34 lachrc3d;
label define lachrc3d
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime90 latime9j;
label define latime9j
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit90 launit9j;
label define launit9j
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura90 ladura9j;
label define ladura9j
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb90 ladurb9j;
label define ladurb9j
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc90 lachrc9j;
label define lachrc9j
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values latime91 latime9a;
label define latime9a
	95          "95+"                           
	96          "Since birth"                   
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values launit91 launit9a;
label define launit9a
	1           "Day(s)"                        
	2           "Week(s)"                       
	3           "Month(s)"                      
	4           "Year(s)"                       
	6           "Since birth"                   
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ladura91 ladura9a;
label define ladura9a
	00          "Less than 1 year"              
	85          "85+ years"                     
	96          "Unknown number of years"       
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ladurb91 ladurb9a;
label define ladurb9a
	1           "Less than 3 months"            
	2           "3 - 5 months"                  
	3           "6 - 12 months"                 
	4           "More than 1 year"              
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values lachrc91 lachrc9a;
label define lachrc9a
	1           "Chronic"                       
	2           "Not chronic"                   
	9           "Unknown if chronic"            
;
label values lcondrt  lcondrt;
label define lcondrt 
	1           "At least one condition causing LA is chronic"
	2           "No condition causing LA is chronic"
	9           "Unk if any condition causing LA is chronic"
;
label values lachronr lachronr;
label define lachronr
	0           "Not limited in any way (incl unk if limited)"
	1           "Limited; caused by at least one chronic cond"
	2           "Limited; not caused by chronic cond"
	3           "Limited; unk if cond causing LA is chronic"
;
label values phstat   phstat; 
label define phstat  
	1           "Excellent"                     
	2           "Very good"                     
	3           "Good"                          
	4           "Fair"                          
	5           "Poor"                          
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pdmed12m pdmed12m;
label define pdmed12m
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pnmed12m pnmed12m;
label define pnmed12m
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values phospyr  phospyr;
label define phospyr 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hospno   hospno; 
label define hospno  
	997         "Refused"                       
	998         "Not ascertained"               
	999         "Don't know"                    
;
label values hpnite   hpnite; 
label define hpnite  
	997         "Refused"                       
	998         "Not ascertained"               
	999         "Don't know"                    
;
label values phchm2w  phchm2w;
label define phchm2w 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values phchmn2w phchmn2w;
label define phchmn2w
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values phcph2wr phcph2wr;
label define phcph2wr
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values phcphn2w phcphn2w;
label define phcphn2w
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values phcdv2w  phcdv2w;
label define phcdv2w 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values phcdvn2w phcdvn2w;
label define phcdvn2w
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values p10dvyr  p10dvyr;
label define p10dvyr 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikinda  hikinda;
label define hikinda 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindb  hikindb;
label define hikindb 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindc  hikindc;
label define hikindc 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindd  hikindd;
label define hikindd 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikinde  hikinde;
label define hikinde 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindf  hikindf;
label define hikindf 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindg  hikindg;
label define hikindg 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindh  hikindh;
label define hikindh 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindi  hikindi;
label define hikindi 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindj  hikindj;
label define hikindj 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindk  hikindk;
label define hikindk 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindl  hikindl;
label define hikindl 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindm  hikindm;
label define hikindm 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hikindn  hikindn;
label define hikindn 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values medicare medicare;
label define medicare
	1           "Yes; information"              
	2           "Yes; but no information"       
	3           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mcpart   mcpart; 
label define mcpart  
	1           "Part A - Hospital Only"        
	2           "Part B - Medical Only"         
	3           "Both Part A and Part B"        
	4           "Card Not Available"            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mcchoice mcchoice;
label define mcchoice
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mchmo    mchmo;  
label define mchmo   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mcname   mcname; 
label define mcname  
	04          "Medigap plan"                  
	12          "Group"                         
	22          "Staff"                         
	32          "IPA"                           
	92          "Other"                         
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values mcref    mcref;  
label define mcref   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mcpaypre mcpaypre;
label define mcpaypre
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values medicaid medicaid;
label define medicaid
	1           "Yes; information"              
	2           "Yes; but no information"       
	3           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values machmd   machmd; 
label define machmd  
	1           "Any doctor"                    
	2           "Select from a book/list"       
	3           "Doctor is assigned"            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mapcmd   mapcmd; 
label define mapcmd  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values maref    maref;  
label define maref   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values single   single; 
label define single  
	1           "Yes with information"          
	2           "Yes with no information"       
	3           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypea  sstypea;
label define sstypea 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypeb  sstypeb;
label define sstypeb 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypec  sstypec;
label define sstypec 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstyped  sstyped;
label define sstyped 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypee  sstypee;
label define sstypee 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypef  sstypef;
label define sstypef 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypeg  sstypeg;
label define sstypeg 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypeh  sstypeh;
label define sstypeh 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypei  sstypei;
label define sstypei 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypej  sstypej;
label define sstypej 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypek  sstypek;
label define sstypek 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values sstypel  sstypel;
label define sstypel 
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values private  private;
label define private 
	1           "Yes; information"              
	2           "Yes; but no information"       
	3           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hitype1  hitype1l;
label define hitype1l
	98          "Not ascertained"               
	99          "Unknown"                       
;
label values whonam1  whonam1l;
label define whonam1l
	1           "In own name"                   
	2           "Someone else in family"        
	3           "Person not in household"       
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnwrk1  plnwrk1l;
label define plnwrk1l
	1           "Employer"                      
	2           "Union"                         
	3           "Through work; but DK if employer or union"
	4           "Through work; self-employ or prof assoc"
	5           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay11 plnpay1a;
label define plnpay1a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay21 plnpay2a;
label define plnpay2a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay31 plnpay3a;
label define plnpay3a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay41 plnpay4a;
label define plnpay4a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay51 plnpay5a;
label define plnpay5a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay61 plnpay6a;
label define plnpay6a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay71 plnpay7a;
label define plnpay7a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hicostr1 hicostra;
label define hicostra
	20000       "$20;000 or more"               
	99997       "Refused"                       
	99998       "Not ascertained"               
	99999       "Don't know"                    
;
label values plnmgd1  plnmgd1l;
label define plnmgd1l
	1           "HMO/IPA"                       
	2           "PPO"                           
	3           "POS"                           
	4           "Fee-for-service/indemnity"     
	5           "Other"                         
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgchmd1  mgchmd1l;
label define mgchmd1l
	1           "Any doctor"                    
	2           "Select from group/list"        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgprmd1  mgprmd1l;
label define mgprmd1l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpymd1  mgpymd1l;
label define mgpymd1l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpref1  mgpref1l;
label define mgpref1l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hitype2  hitype2l;
label define hitype2l
	98          "Not ascertained"               
	99          "Unknown"                       
;
label values whonam2  whonam2l;
label define whonam2l
	1           "In own name"                   
	2           "Someone else in family"        
	3           "Person not in household"       
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnwrk2  plnwrk2l;
label define plnwrk2l
	1           "Employer"                      
	2           "Union"                         
	3           "Through work; but DK if employer or union"
	4           "Through work; self-employ or prof assoc"
	5           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay12 plnpay1b;
label define plnpay1b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay22 plnpay2b;
label define plnpay2b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay32 plnpay3b;
label define plnpay3b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay42 plnpay4b;
label define plnpay4b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay52 plnpay5b;
label define plnpay5b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay62 plnpay6b;
label define plnpay6b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay72 plnpay7b;
label define plnpay7b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hicostr2 hicostrb;
label define hicostrb
	20000       "$20;000 or more"               
	99997       "Refused"                       
	99998       "Not ascertained"               
	99999       "Don't know"                    
;
label values plnmgd2  plnmgd2l;
label define plnmgd2l
	1           "HMO/IPA"                       
	2           "PPO"                           
	3           "POS"                           
	4           "Fee-for-service/indemnity"     
	5           "Other"                         
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgchmd2  mgchmd2l;
label define mgchmd2l
	1           "Any doctor"                    
	2           "Select from group/list"        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgprmd2  mgprmd2l;
label define mgprmd2l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpymd2  mgpymd2l;
label define mgpymd2l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpref2  mgpref2l;
label define mgpref2l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hitype3  hitype3l;
label define hitype3l
	98          "Not ascertained"               
	99          "Unknown"                       
;
label values whonam3  whonam3l;
label define whonam3l
	1           "In own name"                   
	2           "Someone else in family"        
	3           "Person not in household"       
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnwrk3  plnwrk3l;
label define plnwrk3l
	1           "Employer"                      
	2           "Union"                         
	3           "Through work; but DK if employer or union"
	4           "Through work; self-employ or prof assoc"
	5           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay13 plnpay1c;
label define plnpay1c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay23 plnpay2c;
label define plnpay2c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay33 plnpay3c;
label define plnpay3c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay43 plnpay4c;
label define plnpay4c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay53 plnpay5c;
label define plnpay5c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay63 plnpay6c;
label define plnpay6c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay73 plnpay7c;
label define plnpay7c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hicostr3 hicostrc;
label define hicostrc
	20000       "$20;000 or more"               
	99997       "Refused"                       
	99998       "Not ascertained"               
	99999       "Don't know"                    
;
label values plnmgd3  plnmgd3l;
label define plnmgd3l
	1           "HMO/IPA"                       
	2           "PPO"                           
	3           "POS"                           
	4           "Fee-for-service/indemnity"     
	5           "Other"                         
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgchmd3  mgchmd3l;
label define mgchmd3l
	1           "Any doctor"                    
	2           "Select from group/list"        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgprmd3  mgprmd3l;
label define mgprmd3l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpymd3  mgpymd3l;
label define mgpymd3l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpref3  mgpref3l;
label define mgpref3l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hitype4  hitype4l;
label define hitype4l
	98          "Not ascertained"               
	99          "Unknown"                       
;
label values whonam4  whonam4l;
label define whonam4l
	1           "In own name"                   
	2           "Someone else in family"        
	3           "Person not in household"       
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnwrk4  plnwrk4l;
label define plnwrk4l
	1           "Employer"                      
	2           "Union"                         
	3           "Through work; but DK if employer or union"
	4           "Through work; self-employ or prof assoc"
	5           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay14 plnpay1d;
label define plnpay1d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay24 plnpay2d;
label define plnpay2d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay34 plnpay3d;
label define plnpay3d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay44 plnpay4d;
label define plnpay4d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay54 plnpay5d;
label define plnpay5d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay64 plnpay6d;
label define plnpay6d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values plnpay74 plnpay7d;
label define plnpay7d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hicostr4 hicostrd;
label define hicostrd
	20000       "$20;000 or more"               
	99997       "Refused"                       
	99998       "Not ascertained"               
	99999       "Don't know"                    
;
label values plnmgd4  plnmgd4l;
label define plnmgd4l
	1           "HMO/IPA"                       
	2           "PPO"                           
	3           "POS"                           
	4           "Fee-for-service/indemnity"     
	5           "Other"                         
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgchmd4  mgchmd4l;
label define mgchmd4l
	1           "Any doctor"                    
	2           "Select from group/list"        
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgprmd4  mgprmd4l;
label define mgprmd4l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpymd4  mgpymd4l;
label define mgpymd4l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values mgpref4  mgpref4l;
label define mgpref4l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ihs      ihs;    
label define ihs     
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values military military;
label define military
	1           "Yes; Military/VA only"         
	2           "Yes; TRICARE/CHAMPUS/CHAMP-VA only"
	3           "Yes Both Military/VA + TRICARE/CHAMPUS/CHAMP-VA"
	4           "Yes unknown type"              
	5           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values chip     chip;   
label define chip    
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values otherpub otherpub;
label define otherpub
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values othergov othergov;
label define othergov
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values notcov   notcov; 
label define notcov  
	1           "Not covered"                   
	2           "Covered"                       
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hilast   hilast; 
label define hilast  
	1           "6 months or less"              
	2           "More than 6 months; but not more than 1 year ago"
	3           "More than 1 year; but not more than 3 years ago"
	4           "More than 3 years"             
	5           "Never"                         
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop1  histop1l;
label define histop1l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop2  histop2l;
label define histop2l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop3  histop3l;
label define histop3l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop4  histop4l;
label define histop4l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop5  histop5l;
label define histop5l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop6  histop6l;
label define histop6l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop7  histop7l;
label define histop7l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop8  histop8l;
label define histop8l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop9  histop9l;
label define histop9l
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop10 histop1j;
label define histop1j
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop11 histop1a;
label define histop1a
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop12 histop1b;
label define histop1b
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop13 histop1c;
label define histop1c
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop14 histop1d;
label define histop1d
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values histop15 histop1e;
label define histop1e
	1           "Mentioned"                     
	2           "Not mentioned"                 
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values hinotyr  hinotyr;
label define hinotyr 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't Know"                    
;
label values hinotmyr hinotmyr;
label define hinotmyr
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values hcspfyr  hcspfyr;
label define hcspfyr 
	0           "Zero"                          
	1           "Less than $500"                
	2           "$500-$1;999"                   
	3           "$2;000-$2;999"                 
	4           "$3;000-$4;999"                 
	5           "$5;000 or more"                
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't Know"                    
;
label values regionbr regionbr;
label define regionbr
	01          "United States"                 
	02          "Mexico; Central America; Caribbean Islands"
	03          "South America"                 
	04          "Europe"                        
	05          "Russia (and former USSR areas)"
	06          "Africa"                        
	07          "Middle East"                   
	08          "Indian Subcontinent"           
	09          "Asia"                          
	10          "SE Asia"                       
	11          "Elsewhere"                     
	99          "Unknown"                       
;
label values geobrth  geobrth;
label define geobrth 
	1           "USA: born in one of the 50 United States or D.C"
	2           "USA: born in a U.S. territory" 
	3           "Not born in the U.S. or a U.S. territory"
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values yrsinus  yrsinus;
label define yrsinus 
	1           "Less than 1 year"              
	2           "1 yr.; less than 5 yrs."       
	3           "5 yrs.; less than 10 yrs."     
	4           "10 yrs.; less than 15 yrs."    
	5           "15 years or more"              
	9           "Unknown"                       
;
label values citizenp citizenp;
label define citizenp
	1           "Yes; citizen of the United States"
	2           "No; not a citizen of the United States"
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values headst   headst; 
label define headst  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values headstv1 headstva;
label define headstva
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not Ascertained"               
	9           "Don't know"                    
;
label values educ     educ;   
label define educ    
	00          "Never attended/ kindergarten only"
	12          "12th grade; no diploma"        
	13          "HIGH SCHOOL GRADUATE"          
	14          "GED or equivalent"             
	15          "Some college; no degree"       
	16          "AA degree: technical or vocational"
	17          "AA degree: academic program"   
	18          "Bachelor's degree (BA; AB; BS; BBA)"
	19          "Master's degree (MA; MS; MEng; MEd; MBA)"
	20          "Professional degree (MD; DDS; DVM; JD)"
	21          "Doctoral degree (PhD; EdD)"    
	96          "Child under 5 years old"       
	97          "Refused"                       
	98          "Not Ascertained"               
	99          "Don't know"                    
;
label values educ_r1  educ_r1l;
label define educ_r1l
	01          "Less/equal to 8th grade"       
	02          "9-12th grade; no high school diploma"
	03          "High school graduate"          
	04          "GED recipient"                 
	05          "Some college; no degree"       
	06          "AA degree; technical or vocational"
	07          "AA degree; academic program"   
	08          "Bachelor's degree (BA; BS; AB; BBA)"
	09          "Master's; professional; or doctoral degree"
	96          "Child under 5 years of age"    
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values miltryds miltryds;
label define miltryds
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values doinglw1 doinglwa;
label define doinglwa
	1           "Working for pay at a job or business"
	2           "With a job or business but not at work"
	3           "Looking for work"              
	4           "Working; but not for pay; at a job or business"
	5           "Not working and not looking for work"
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values whynowk1 whynowka;
label define whynowka
	01          "Taking care of house or family"
	02          "Going to school"               
	03          "Retired"                       
	04          "On a planned vacation from work"
	05          "On family or maternity leave"  
	06          "Temporarily unable to work for health reasons"
	07          "On layoff"                     
	08          "Disabled"                      
	09          "Have job/contract; off-season" 
	10          "Other"                         
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values wrkhrs   wrkhrs; 
label define wrkhrs  
	95          "95+ hours"                     
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values wrkftall wrkftall;
label define wrkftall
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values wrklyr1  wrklyr1l;
label define wrklyr1l
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values wrkmyr   wrkmyr; 
label define wrkmyr  
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values majr_act majr_act;
label define majr_act
	1           "Working at a job or business"  
	2           "Keeping house"                 
	3           "Going to school"               
	4           "Something else"                
	5           "Unknown"                       
;
label values ernyr_p  ernyr_p;
label define ernyr_p 
	01          "$01-$4999"                     
	02          "$5000-$9999"                   
	03          "$10000-$14999"                 
	04          "$15000-$19999"                 
	05          "$20000-$24999"                 
	06          "$25000-$34999"                 
	07          "$35000-$44999"                 
	08          "$45000-$54999"                 
	09          "$55000-$64999"                 
	10          "$65000-$74999"                 
	11          "$75000 and over"               
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values hiempof  hiempof;
label define hiempof 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values psal     psal;   
label define psal    
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pseinc   pseinc; 
label define pseinc  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pssrr    pssrr;  
label define pssrr   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pssrrdb  pssrrdb;
label define pssrrdb 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pssrrd   pssrrd; 
label define pssrrd  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ppens    ppens;  
label define ppens   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values popens   popens; 
label define popens  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pssi     pssi;   
label define pssi    
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pssid    pssid;  
label define pssid   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values ptanf    ptanf;  
label define ptanf   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values powben   powben; 
label define powben  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pintrstr pintrstr;
label define pintrstr
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pdivd    pdivd;  
label define pdivd   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pchldsp  pchldsp;
label define pchldsp 
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pincot   pincot; 
label define pincot  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values incgrp   incgrp; 
label define incgrp  
	01          "0-$4999"                       
	02          "$5000-$9999"                   
	03          "$10000-$14999"                 
	04          "$15000-$19999"                 
	05          "$20000-$24999"                 
	06          "$25000-$34999"                 
	07          "$35000-$44999"                 
	08          "$45000-$54999"                 
	09          "$55000-$64999"                 
	10          "$65000-$74999"                 
	11          "$75000 and over"               
	12          "$20000 or more (no detail)"    
	13          "Less than $20000 (no detail)"  
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values ab_bl20k ab_bl20k;
label define ab_bl20k
	1           "$20;000 or more"               
	2           "Less than $20;000"             
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values rat_cat  rat_cat;
label define rat_cat 
	01          "Under .50"                     
	02          ".50 to .74"                    
	03          ".75 to .99"                    
	04          "1.00 to 1.24"                  
	05          "1.25 to 1.49"                  
	06          "1.50 to 1.74"                  
	07          "1.75 to 1.99"                  
	08          "2.00 to 2.49"                  
	09          "2.50 to 2.99"                  
	10          "3.00 to 3.49"                  
	11          "3.50 to 3.99"                  
	12          "4.00 to 4.49"                  
	13          "4.50 to 4.99"                  
	14          "5.00 and over"                 
	96          "Undefinable"                   
	99          "Unknown"                       
;
label values houseown houseown;
label define houseown
	1           "Owned or being bought"         
	2           "Rented"                        
	3           "Other arrangement"             
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values fgah     fgah;   
label define fgah    
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values pssapl   pssapl; 
label define pssapl  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values psdapl   psdapl; 
label define psdapl  
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values tanfmyr  tanfmyr;
label define tanfmyr 
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values pfstp    pfstp;  
label define pfstp   
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values fstpmyr  fstpmyr;
label define fstpmyr 
	97          "Refused"                       
	98          "Not ascertained"               
	99          "Don't know"                    
;
label values eligpwic eligpwic;
label define eligpwic
	0           "No WIC age-eligible family members"
	1           "At least 1 WIC age-eligible family member"
;
label values pwic     pwic;   
label define pwic    
	1           "Yes"                           
	2           "No"                            
	7           "Refused"                       
	8           "Not ascertained"               
	9           "Don't know"                    
;
label values wic_flag wic_flag;
label define wic_flag
	0           "Person not age-eligible"       
	1           "Person age-eligible"           
;
*/
#delimit cr

save $mdata/nhis_data/clean/nhis2002_personsx,replace

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
