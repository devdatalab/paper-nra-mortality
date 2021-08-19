## Mortality Solver Code

|---------------------------|------------------------------------------------|
| calc_all_mort_bounds.m    | loops over all desired mort stats              |
| get_mort_stats.m          | calls solver on a series of race/age/sex lists |
| bound_mu.m                | run a solver seed and then runs the solver     |
| bound_generic_fun2.m      | runs fmincon()                                 |
| get_mort_solver_params2.m | sets solver parameters, e.g. mon/nomon         |
|                           |                                                |

