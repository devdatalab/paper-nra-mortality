# paper-nra-mortality

* Calculates analytical and numerical bounds on conditional expectation functions from censored data, from [Novosad, Rafkin & Asher (2021) "Mortality Change Among Less Educated Americans"](http://paulnovosad.com/pdf/nra-mortality.pdf).

* Calculates mortality change in constant education percentile bins. This is non-trivial because education rank boundaries change over time: dropouts were the bottom 20% in 1992 and the bottom 9% in 2018.

* Replication code and data for [Novosad, Rafkin & Asher (2021) "Mortality Change Among Less Educated Americans"](http://paulnovosad.com/pdf/nra-mortality.pdf). (See replication information below)

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

# Replication Code and Data for NRA 2021

To regenerate the tables and figures from the paper, take the
following steps:

1. Download and unzip the replication data package from this [Google Drive Folder](https://drive.google.com/drive/folders/1DnOP2XfCMVygZ--OrRyY5_HkCoo3E6Mc?usp=sharing)
   * `nra-mortality.zip` -- huge file includes ACS and CPS components
   * `nra-mortality-small.zip` -- replication mortality datasets, allows complete replication of paper but not some appendices
   
2. Clone this repo.

3. Open the do file make_nra_mortality.do, and set the globals `out`,
   `mdata`, and `tmp`.  
   * `$out` is the target folder for all outputs, such as tables
   and graphs. 
   * `$mdata` is the folder where you unzipped and saved the
     replication data package.
   * intermediate files will be placed in both `$tmp` and `$mdata/int`.

4. Open `matlab/set_matlab_paths.m` and set `base_path` to the same path as `$mdata`.

5. Open `a/graph_intuitive.py` and set `output_path` to `$mdata/out` in line 10.

**NOTE:** The code probably won't work if you have spaces in the pathnames. Blame Stata, not us.

6. Run the do file `make_nra_mortality.do`.  This will run through all the
   other do files to regenerate all of the results in `$out/`.
   
## Replication Notes

This paper uses restricted NCHS data, because it requires the education of the deceased, which was not reported in public NCHS files beginning around 2005. These restricted data cannot be included in the replication package. Therefore, the makefile comments out `make_mortality_data.do`, which constructs the NCHS + ACS + CPS national aggregates which form the basis of the analysis. However, `make_mortality_data.do` and its subcomponents are provided for anyone with access to the restricted access data. The outputs of this code appear in `$mdata/mort` (and are provided). We have permission from NCHS to post national mortality aggregates constructed from the microdata.

The Matlab bound-generating code (`run_matlab_solver.do`) was run in parallel across 45 processes on a research server, each process taking about 6 hours. As such, we have configured the code to generate bounds only for one age/race group (age 25, white), which are saved in `$mdata/bounds/int/`. The analysis draws all of its code from `$mdata/bounds/`, which has the complete set of bounds. Note that the Matlab bound-generating code is based on a 100-parameter numerical minimization problem which can have local minima, and thus may produce marginally different results in different versions of Matlab or on servers with different memory or default parameters. As such, the bounds generated in `bounds/int` may differ slightly from those in `bounds/`. We do not expect any substantive differences that would affect any of the conclusions of the paper.

You might need to change `\mortalitypath` in `mortality.tex` to an absolute path. The relative path to `exhibits/` works for some of us and not for others.

This code was tested using Stata 16.0 and Matlab R2019a. Estimated run times on our server are:
* NCHS build and pre-Matlab build: 2 hours
* Matlab bound generation: 6 hours * 45 parallel processes
* `make_results.do`: 1 hour
