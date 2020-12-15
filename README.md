# mortality
Paper: Mortality Change Among Less Educated Americans


## replication plan

Starting data sources:

### NCHS Mortality

Raw data is protected under a DUA. Public data starts with `$mdata/outfiles/nchs/appended_rank_mort.dta`. This first gets used by `$mcode/b/prep_matlab_inputs.do`

### NHIS

Raw data can be posted --- include the entire build.

CR: What is happening with `mort_moments.do`?  We can't incorporate into the replication repo because it uses the protected data. But it seems to be an input for the NHIS graph. Is it possible to generate this from one of the appended_rank_mort files?

### CPS

CR to fill in

### Bounds

For now, we should treat the Matlab outputs (`$mdata/bounds/mort_bounds_all.dta` and `$mdata/bounds/mort_changes_all.dta`) as input files. We will decide later whether we want the replication repo to reproduce these. (The issue is they are produced by a parallel job on Discovery.)

## Dealing with the solver

Defer all the matlab stuff -- we will have to deal with it and include it in the replication but first let's get this working for Stata. This means you won't be able to run `a/graph_mort_hisp_sim.do`, which uses one of the Matlab outputs.
