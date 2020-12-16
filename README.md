# paper-nra-mortality

* Calculates analytical and numerical bounds on conditional expectation functions from censored data, from [Novosad, Rafkin & Asher (2020) "Mortality Change Among Less Educated Americans"](http://paulnovosad.com/pdf/nra-mortality.pdf).

* Calculates mortality change in constant education percentile bins. This is non-trivial because education rank boundaries change over time: dropouts were the bottom 20% in 1992 and the bottom 9% in 2018.

* Provides replication code and data for [Novosad, Rafkin & Asher (2020) "Mortality Change Among Less Educated Americans"](http://paulnovosad.com/pdf/nra-mortality.pdf). (See replication information below)

# Details

This is a set of programs that bounds a conditional expectation function E(y|x), when x is uniformly distributed but only observed in a discrete set of non-overlapping intervals. The bounds are derived in "Mortality Change Among Less Educated Americans" above.

The method is valid for any conditional expectation function with uniformly distributed x. Bounds with other known distributions are derived in the paper; these are not included in the present implementation, but it would be straightforward to extend the Matlab code to these use cases.

We include Stata and Matlab code. The Stata code is analytical, and thus fast and easy to run. The Matlab code uses a numerical optimization, which is slower and more involved on the coding side, but allows complex structural restrictions on the CEF. We present an example by constraining the curvature of the CEF.

# `bound_mort` usage (stata)

We calculated bounds on expected mortality in arbitrary education rank bins, for example education among the least educated 10%. These bounds are calculated under the assumption that mortality is non-increasing in the education rank.

The stata program `bound_mort()` in `mortality_programs.do` calculates bounds on mortality, assuming that import parameters specify mortality rates in deaths per 100,000 people.

Sample usage to bound mortality in the bottom 20%:

```
bound_mort tmortrate if sex == 1, s(0) t(20) gen(varname) [xvar(varname) by(varname)]
```

`tmortrate` is the mortality rate in deaths per 100,000. Arbitrary use of `if` and `by` are permissible. `xvar` is the interval-censored rank variable. `s()` and `t()` are the desired rank range for the mortality estimate as described above. `gen` specifies a stub for the upper and lower bounds. e.g. If you specify `gen(mu)`, `bound_mort()` will generate variables `mu_lb` and `mu_ub` with the bounds for each row of the data.

For instance, to calculate mortality among the least educated 10%, you
would use:
```
bound_mort tmortrate, s(0) t(10) gen(mu) [xvar(varname) by(varname)]
```

The Matlab code in the repo can implement bounds with curvature restrictions; these are not yet documented. But if you want to figure it out yourself, `bound_mort_stats.m` might be a good place to start.

# `bound_mu` usage (Matlab)

Syntax: `bound_mu(input_csv, cuts, vals, mu_s, mu_t, f2, spec)`

Need to specify either `input_csv` or `cuts` and `vals` but not both.

* `input_csv`: 2-column input file with (i) mean education rank [0-1] in bin; (ii) mean mortality in bin.
* `cuts`: rank bin boundaries. e.g. If 15% are dropouts, `cuts(1) = 15`.
* `vals`: mean mortality in each rank bin
* `mu_s`, `mu_t`: Target bin boundaries. To calculate mortality in bottom 10%, use `mu_s = 0, mu_t = 10`.
* `f2`: maximum allowed curvature across any pair of bins is mean mortality * `f2`
* `spec`: (i) `nomon`: no monotonicity constraint; (ii) `mon`: monotonicity constraint; (iii) `mon-step`: monotonicity constraint, but no curvature constraint at bin boundaries.

The function returns a pair of floats with the bounds on mortality in the desired bin.

# Replication Code and Data for NRA 2020

To regenerate the tables and figures from the paper, take the
following steps:

1. Download and unzip the replication data package from this Google
   Drive
   folder (not yet linked--waiting for sharing permission)
   * To get as many files as possible in .dta form, plus necessary
   CSVs, use this
   link (tbd)
   * To get all the files in CSV format, use this
     link (tbd)
   * Regardless of your choice from the two above options, use this
     link (tbd)
     to download the raw National Health Interview Survey data
     (1997-2017), which can be used to re-build the clean NHIS dataset.
     The clean all-years dataset is also included in the two files above.

2. Clone this repo and switch to the code folder.

3. Open the do file make_mortality_repl.do, and set the globals `out`,
   `repdata`, `tmp`, and `mcode`.  
   * `out` is the target folder for all outputs, such as tables
   and graphs. 
   * `tmp` is the folder for the data files and
   temporary data files that will be created during the rebuild.
   * `repdata` is the folder where you unzipped and saved the
     replication data package.
   * `mcode` is the code folder of the clone of the replication repo

4. Run the do file `make_mortality_repl.do`.  This will run through all the
   other do files to regenerate all of the results.
   
We have included all the required programs to generate the main
   results. However, some of the estimation output commands (like
   `estout`) may fail if certain Stata packages are missing. These can
   be replaced by the estimation output commands preferred by the
   user.
   
Please note we use globals for pathnames, which will cause errors if
   filepaths have spaces in them. Please store code and data in paths
   that can be access without spaces in filenames.
   
The current makefile uses precompiled mortality bounds and changes from
the data folder, as these results take ~48 hours to generate with Matlab on a
server with max memory of 429 GB. However, the Matlab programs that generate these files are included in the repo and can be run by uncommenting the Matlab lines in the makefile.

This code was tested using Stata 15.0. Run time to generate all
results on our server was about __ minutes.
