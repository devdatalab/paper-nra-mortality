global out ~/iec1/output/mort-desc


/* create causes appendix table */
usemort
keep if year == 2015
global mort_partition tmort icd10*mort amort cmort dmort clmort cdmort hmort 
collapse (sum) $mort_partition  [aw=tpop], by(year)

foreach v of varlist *mort {
  replace `v' = 0 if mi(`v')
}
gen icd10abmort = icd10amort + icd10bmort
drop icd10amort icd10bmort

gen respmort = clmort + icd10jmort
drop clmort icd10jmort

replace hmort = hmort + icd10imort
drop icd10imort

ren *mort mort*

reshape long mort, string i(year) j(cause)

gen cause_name = ""
replace cause_name = "Total mortality" if cause == "t"
replace cause_name = "Infectious and parasitic diseases" if cause == "icd10ab"
replace cause_name = "Cancer" if cause == "c"
replace cause_name = "Diseases of the blood and immune disorders" if cause == "icd10d"
replace cause_name = "Endocrine, nutritional and metabolic diseases" if cause == "icd10e"
replace cause_name = "Mental and behavioural disorders" if cause == "icd10f"
replace cause_name = "Diseases of the nervous system" if cause == "icd10g"
replace cause_name = "Diseases of the eye, ear, mastoid and adnexa" if cause == "icd10h"
replace cause_name = "Heart and other diseases of the circulatory system" if cause == "h"
replace cause_name = "Diseases of the respiratory system" if cause == "resp"
replace cause_name = "Diseases of the digestive system" if cause == "icd10k"
replace cause_name = "Diseases of the skin and subcutaneous tissue" if cause == "icd10l"
replace cause_name = "Diseases of the musculoskeletal system and connective tissue" if cause == "icd10m"
replace cause_name = "Diseases of the genitourinary system" if cause == "icd10n"
replace cause_name = "Pregnancy, childbirth and the puerperium" if cause == "icd10o"
replace cause_name = "Certain conditions originating in the perinatal period" if cause == "icd10p"
replace cause_name = "Congenital malformations, deformations and chromosomal abnormalities" if cause == "icd10q"
replace cause_name = "Deaths not elsewhere classified" if cause == "icd10r"
replace cause_name = "Accidents and injuries (primarily falls, motor vehicles, assaults)" if cause == "a"
replace cause_name = `"Poisoning, suicide, chronic liver disease ("deaths of despair") "' if cause == "d"
replace cause_name = "Cerebrovascular diseases" if cause == "cd"

sum mort if cause == "t"
gen mort_share = mort / `r(mean)'

gsort -mort_share
replace mort_share = mort_share * 100
format mort_share %5.2f
drop if cause == "t"
listtex cause_name mort_share using $out/icd_causes.tex , replace rstyle(tabular)
