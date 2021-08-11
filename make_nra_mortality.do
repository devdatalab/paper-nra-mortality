/* DELETE THIS LINE */
cd ~/ddl/paper-nra-mortality/
/* END DELETE */

clear

/* set the following globals:
$out: path for output files to be created
mdata: path to data [intermediate data files will be put here too] */
global out /scratch/pn/mort-test/out
global tmp /scratch/pn/mort-test/tmp
global mdata /scratch/pn/mort-test

if mi("$out") | mi("$tmp") | mi("$mdata") {
  display as error "Globals 'out', 'tmp', and 'mdata' must be set for this to run."
  error 1
}

/* IMPORTANT: set Matlab paths in matlab/set_matlab_paths.m */


/* load Stata programs */
qui do tools.do
qui do masala-merge/masala_merge
qui do stata-tex/stata-tex

/* add ado folder to adopath */
adopath + ado

/* start logging */
cap log close
log using $out/nra_mortality.log, text replace

/* store current path (assumed to be repo root folder) */
global mcode = "`c(pwd)'"

/* create new folders */
cap mkdir $mdata/tmp
foreach f in bounds nchs matlab_inputs nchs/clean {
  cap mkdir $mdata/int/`f'
}

/*********************************************************/
/* 1. Build mortality file from restricted NCHS data     */
/*********************************************************/
do $mcode/make_mortality_data

/***************************************/
/* 2. Prepare inputs for Matlab solver */
/***************************************/

/* create mortality moments for NHIS analysis */
do $mcode/b/mort_moments.do

/* prepare the inputs for the matlab mort-solver */
do $mcode/b/prep_matlab_inputs.do

/********************************************/
/* 3. Run all versions of the Matlab solver */
/********************************************/
do $mcode/run_matlab_solver.do

/************************************************************/
/* 4. Process solver output and generate all paper results  */
/************************************************************/
do $mcode/make_results.do

