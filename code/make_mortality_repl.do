/*****************************************************/
/* MORTALITY DATA BUILD AND ANALYSIS FOR REPLICATION */
/*****************************************************/

/********************************************/
/* FRONT MATTER: PATHS, PROGRAMS, AND TOOLS */
/********************************************/

/* clear any existing globals, programs, data to make sure they don't clash */
clear all

/* Stata programs required from SSC:
ssc install unique
*/

/* set the following globals:
$out: path where output files will be created
$repdata: path to initial data inputs 
$tmp: intermediate data files will be put here
$mcode: path to folder of build and analysis .do and .py files*/

global out
global repdata 
global tmp 
global mcode 

/* redirect several directories used in the code to $repdata */
global mdata $repdata
global mortality $repdata

/* display an error and break if any of the globals are empty or set to old values*/
if "$out" == "" | regexm("$out", "iec|ddl| ") ///
    display  "error: Global out not set properly. See instructions in README"

if "$repdata" == "" | regexm("$repdata", "iec|ddl| ") ///
    display  "error: Global repdata not set properly. See instructions in README"

if "$mcode" == "" | regexm("$mcode", "iec| ") ///
    display  "error: Global mcode not set properly. See instructions in README"

if "$tmp" == "" | regexm("$tmp", "iec|ddl| ") ///
    display  "error: Global tmp not set properly. See instructions in README"

/* set the makefile to crash immediately if globals aren't set properly  */
if "$out" == "" | regexm("$out", "iec|ddl| ") ///
    | "$repdata" == "" | regexm("$repdata", "iec|ddl| ") ///
    | "$tmp" == "" | regexm("$tmp", "iec|ddl| ") ///
    | "$mcode" == "" | regexm("$mcode", "iec| ") ///
    exit 1

/* define programs for mortality analysis */
do $mcode/ado/mortality_programs.do
do $mcode/ado/tools.do

/**************/
/* NHIS build */
/**************/

/* run the individual file */ 
do $mcode/nhis/build_personsx.do

/* build the deaths files */
do $mcode/nhis/build_mortfile.do

/* merge the individual records with the deaths */
do $mcode/nhis/merge_nhis.do

/* collapse the nhis deaths */ 
do $mcode/nhis/collapse_nhis.do

// /********************************************/
// /* RUN EVERYTHING THROUGH THE MATLAB SOLVER */
// /********************************************/
// 
 /* prepare the inputs for the mort-solver */
 do $mcode/b/prep_matlab_inputs.do
// 
// /* run the matlab bounds calculations to create data for all main and appendix tables */
// /* output: /scratch/pn/mus/mort_bounds.csv */
// // serial version: shell matlab -r "run('$mcode/b/calc_all_mort_bounds.m'); exit;"
// 
// // parallel version:
// // ssh discovery
// // cd ~/batch/mort
// // mkdir ~/batch/mort
// // mksub ~/ddl/mortality/batch/race1.pbs
// // mksub ~/ddl/mortality/batch/race2.pbs
// // mksub ~/ddl/mortality/batch/race3.pbs
// // mksub ~/ddl/mortality/batch/race5.pbs
// 
// /* run some ancillary specifications for the appendix */
// /* hispanic identity shift simulation */
// shell matlab -r "run('$mcode/a/mort_hisp_sim.m'); exit;"
// 
// /* run some additional scenarios used here and there */
// 
// /* calculate a full CEF undervarious scenarios */
// shell matlab -r "run('$mcode/a/plot_mort_cef.m'); exit;"
// 
// /* calculate mortality stats under different scenarios for Table 2 */
// shell matlab -r "run('$mcode/b/calc_table_mort_stats.m'); exit;"
// 
// /* graphs / tables showing results under variable monotonicity */
// shell matlab -r "run('$mcode/a/semimon_results.m'); exit;"
// 
// /*************************/
// /* PROCESS SOLVER OUTPUT */
// /*************************/
// 
// /* append parallel matlab bounds (I'm assuming we only work in parallel starting now) */
// do $mcode/b/append_parallel_matlab_bounds.do
// 
// /* take the matlab output CSV and reshape to a directly graphable dataset */
// /* [This was formerly append_bounds.do ~/mort/.* -> $mdata/bounds/.*
//     Now it converts $mdata/bounds/mord_bounds_all.csv -> $mdata/bounds/mort_bounds_all.dta */
// do $mcode/b/process_matlab_bounds.do


/*******************************/
/* GENERATE TABLES AND FIGURES */
/*******************************/

/* wipe out the paper statistics file */
cap erase $out/mort_paper_stats.csv

/* main figures */
do $mcode/a/figure_scatter_smooth.do
do $mcode/a/figure_scatter_granular.do
do $mcode/a/figure_trend_bounds.do
do $mcode/a/figure_causes.do

/* updated appendix tables and figures */
do $mcode/a/calc_standardized_rates.do
do $mcode/a/table_icd_causes.do

/* calculate stats for paper body */
do $mcode/a/paper_stats.do

/* comparison of naive and bounded mortality estimates for one group */
do $mcode/a/figure_naive_compare.do

/* CEF graphs walking through method */
do $mcode/a/plot_mort_cef.do

/* table 2 showing mortality stats under different assumptions */
do $mcode/a/table_mort_stats

/* APPENDIX FIGURES */

/* CPS synthetic cohort analysis with GED data */
do $mcode/a/forecast_pop_change_all_cohorts.do

/* creates polynomial cbar figures and checks the max cbar */
do $mcode/a/polynomial_cbar.do

/* graph size of hispanic and non-hispanic groups */
do $mcode/a/graph_hisp_group_size.do

/* income ranks of low ed blacks/ whites to test composition change */
do $mcode/a/graph_income_ranks.do

/* simulate changes in  */
// commented out for now because this file inputs a matlab output
// do $mcode/a/graph_mort_hisp_sim.do

/* graph the NHIS vs. NCHS mortality analysis */ 
do $mcode/a/graph_nhis_mortality.do 

/* graph NHIS self-reported health changes by ed group */
do $mcode/a/graph_nhis_self_reported_health.do

/* latex inserts */
do $mcode/a/export_tex_inserts.do
