clear

/* set the following globals:
$out: path for output files to be created
mdata: path to data [intermediate data files will be put here too] */

global out /scratch/pn/mort-test/out
global tmp /scratch/pn/mort-test/tmp
global mdata /scratch/pn/mort-test/dta

if mi("$out") | mi("$tmp") | mi("$mdata") {
  display as error "Globals 'out', 'tmp', and 'mdata' must be set for this to run."
  error 1
}

/* load Stata programs */
qui do tools.do
qui do masala-merge/masala_merge
qui do stata-tex/stata-tex

/* add ado folder to adopath */
adopath + ado

/* start logging */
cap log close
log using $out/nra_mortality.log, text replace

/* store current path */
global mcode = "`c(pwd)'"

/* create new folders */
cap mkdir $mdata/tmp
cap mkdir $mdata/int/bounds
cap mkdir $mdata/int/matlab_inputs

/* run different subcomponents of the build */

/*********************************************************/
/* 1. Build restricted NCHS data including matlab inputs */
/*********************************************************/
/* [for CR: is this just prep_mort_rates_all.do?? ] */
do $mcode/make_nchs_mortality

/**************************************/
/* 2. Build all public ancillary data */
/**************************************/
do $mcode/make_ancillary_data

/***************************************/
/* 3. Prepare inputs for Matlab solver */
/***************************************/

/* create mortality moments for NHIS analysis */
do $mcode/b/mort_moments.do

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

