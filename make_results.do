/*************************/
/* PROCESS SOLVER OUTPUT */
/*************************/

/* append parallel matlab bounds into a single file */
/* note for replicators: This reads data from individual matlab runs in $mdata/bounds/ and
   writes a single datafile to $mdata/bounds/int/. This is intentionally NOT reading data
   from $mdata/bounds/int/ (produced by the above lines), because there is minor variation in 
   solver solutions across different matlab machines, so we need to use *our* solver results
   to deliver exactly the outputs in the paper */

do $mcode/b/append_parallel_matlab_bounds.do

/*************************************************************************************/
/* NOTE: EVERYTHING ABOVE HERE SAVES BOUNDS TO mdata/int/bounds                             */
/*       EVERYTHING BELOW HERE LOADS BOUNDS FROM mdata/bounds                               */
/*                                                                                   */
/* This is because we supply mdata/bounds/ as a basis for replication, and the prior */
/* stuff is only there to verify that the bounds are produced correctly.

   However, some intermediate files below continue to be saved to int/ */

/*************************************************************************************/

/* take the matlab output CSV and reshape to a directly graphable dataset */
/* [This was formerly append_bounds.do ~/mort/.* -> $mdata/bounds/.*
    Now it converts $mdata/bounds/mord_bounds_all.csv -> [tbd]            */
do $mcode/b/process_matlab_bounds.do

/*******************************/
/* GENERATE TABLES AND FIGURES */
/*******************************/

/* wipe out the paper statistics file */
cap erase $out/mort_paper_stats.csv

/* main figures */
do $mcode/a/figure_scatter_smooth.do
// do $mcode/a/figure_scatter_granular.do
do $mcode/a/figure_trend_bounds.do
do $mcode/a/figure_causes.do

/* updated appendix tables and figures */
do $mcode/a/calc_standardized_rates.do
do $mcode/a/table_icd_causes.do

/* calculate stats for paper body */
do $mcode/a/paper_stats.do

/* comparison of naive and bounded mortality estimates for one group */
do $mcode/a/figure_naive_compare.do

/* intuitive graphs explaining how bounds work */
shell python $mcode/a/graph_intuitive.py

/* CEF graphs walking through method */
FAIL
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
do $mcode/a/graph_mort_hisp_sim.do

/* graph the NHIS vs. NCHS mortality analysis */ 
do $mcode/a/graph_nhis_mortality.do 

/* graph NHIS self-reported health changes by ed group */
do $mcode/a/graph_nhis_self_reported_health.do

/* latex inserts */
do $mcode/a/export_tex_inserts.do

