/* The Matlab solver calculates bounds on mortality for a wide range of sex, ed, race, age, year
   groups under various parameters. We run these in parallel on a cluster; they take about a week
   to run serially. We parallelize over 4 race groups and 9 age bins. This matlab call calculates
   bounds for age group 25-29 (age param = 25), for whites (race param = 1). To run this for all
   groups, age needs to loop over 25(5)65, and race over "1 2 3 5". 
*/
cd $mcode/matlab
shell matlab -nodisplay -r "calc_all_mort_bounds_parallel(25, 1, '$mcode/mort-solver', '$mdata/int/bounds'); exit;"

/* The Matlab creates a set of output files, such as $mdata/int/bounds/mort_bounds_all_25_1.csv.

For faster replication, we recommend just running any particular age/race combination and verifying
that the results line up with the results in $mdata/bounds/, which are the results that are used later
in the analysis.

Note that the solver optimization is complex, as it is estimating a 100-parameter result vector, and
this can occasionally find local minima that are different from the absolute minima. As such, results
may vary depending on Matlab version and default server settings. We therefore expect replication
results may vary a little bit across different machines; but a minor variation in the bounds at
this stage will not overturn the large mortality change and black/white mortality differences
described in the paper.

*/

/* run some ancillary specifications for the appendix */
/* hispanic identity shift simulation */
shell matlab -r "run('mort_hisp_sim.m'); exit;"

/* run some additional scenarios used here and there */

/* calculate a full CEF undervarious scenarios */
shell matlab -r "run('plot_mort_cef.m'); exit;"

/* calculate mortality stats under different scenarios for Table 2 */
shell matlab -r "run('calc_table_mort_stats.m'); exit;"

/* graphs / tables showing results under variable monotonicity */
shell matlab -r "run('semimon_results.m'); exit;"
cd $mcode
