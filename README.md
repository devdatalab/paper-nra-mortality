# paper-nra-mortality

* Calculates analytical and numerical bounds on conditional expectation functions from censored data, from [Novosad, Rafkin & Asher (2020) "Mortality Change Among Less Educated Americans"](http://www.dartmouth.edu/~novosad/nra-mortality.pdf).

The use case in the paper is the calculation of mortality rates in constant education rank bins over time. e.g. calculate mortality in the least educated 10%. This is non-trivial because education rank boundaries change over time: dropouts were the bottom 20% in 1992 and the bottom 9% in 2015.

# Details

This is a set of programs that bounds a conditional expectation function E(y|x), when x is uniformly distributed but only observed in a discrete set of non-overlapping intervals. The bounds are derived in "Mortality Change Among Less Educated Americans" above.

The method is valid for any conditional expectation function with uniformly distributed x. Bounds with other known distributions are derived in the paper; these are not included in the present implementation, but it would be straightforward to extend the Matlab code to these use cases.

We include Stata and Matlab code. The Stata code is analytical, and thus fast and easy to run. The Matlab code uses a numerical optimization, which is slower and more involved on the coding side, but allows complex structural restrictions on the CEF. We present an example by constraining the curvature of the CEF.

# `bound_mort` Usage

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

# Replication Code and Data for NRA 2020

The repo currently contains code for the graphs and tables in the paper (`graph*.do`, `figure*.do`, `table*.do`). Future versions will include data and the full build.
