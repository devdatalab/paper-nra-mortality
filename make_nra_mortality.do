/* SEE STEPS 1 AND 2 BELOW TO SET UP REPLICATION */
clear all
set more off

/* STEP 1: SET THE FOLLOWING GLOBALS:
$out: path for output files to be created
mdata: path to data [intermediate data files will be put here too] */
global out /scratch/pn/mort-test/out
global tmp /scratch/pn/mort-test/tmp
global mdata /scratch/pn/mort-test

if mi("$out") | mi("$tmp") | mi("$mdata") {
  display as error "Globals 'out', 'tmp', and 'mdata' must be set for this to run."
  error 1
}

/* STEP 2: SET MATLAB PATHS SIMILARLY IN matlab/set_matlab_paths.m */
file open myfile using "matlab/set_basepath.m", write replace
file write myfile "base_path = '$mdata'"
file close myfile

/* load Stata programs */
qui do tools.do
qui do masala-merge/masala_merge
qui do stata-tex/stata-tex

/* load mortality programs (chiefly bound_mort and helpers) */
do mortality_programs

/* add ado folder to adopath */
adopath + ado

/* start logging */
cap log close
log using $out/nra_mortality.log, text replace

/* provide some info about how and when the program was run */
/* See https://www.stata.com/manuals13/pcreturn.pdf#pcreturn */
local variant = cond(c(MP),"MP",cond(c(SE),"SE",c(flavor)) )  
// alternatively, you could use 
// local variant = cond(c(stata_version)>13,c(real_flavor),"NA")  

di "=== SYSTEM DIAGNOSTICS ==="
di "Stata version: `c(stata_version)'"
di "Updated as of: `c(born_date)'"
di "Variant:       `variant'"
di "Processors:    `c(processors)'"
di "OS:            `c(os)' `c(osdtl)'"
di "Machine type:  `c(machine_type)'"
di "=========================="

/* set root folder for running to current path */
local pwd : pwd
global rootdir "`pwd'"

/* tell stata where to find packages */
capture mkdir "$rootdir/ado"
sysdir set PERSONAL "$rootdir/ado/personal"
sysdir set PLUS     "$rootdir/ado/plus"
sysdir set SITE     "$rootdir/ado/site"
sysdir



/* store current path (assumed to be repo root folder) */
global mcode = "`c(pwd)'"

/* create new folders */
cap mkdir $mdata/tmp
foreach f in bounds nchs nhis matlab_inputs nhis/clean {
  cap mkdir $mdata/int/`f'
}

/*********************************************************/
/* 1. Build mortality file from restricted NCHS data     */
/*********************************************************/
// Line commented out since it requires restricted data
// do $mcode/make_mortality_data

/*********************/
/* 2. Prep NHIS data */
/*********************/
do $mcode/make_nhis

/***************************************/
/* 3. Prepare inputs for Matlab solver */
/***************************************/

/* prepare the inputs for the matlab mort-solver */
do $mcode/b/prep_matlab_inputs.do

/********************************************/
/* 4. Run all versions of the Matlab solver */
/********************************************/
do $mcode/run_matlab_solver.do

/************************************************************/
/* 5. Process solver output and generate all paper results  */
/************************************************************/
do $mcode/make_results.do

