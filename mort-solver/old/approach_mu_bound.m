% APPEARS TO BE OBSOLETE -- PREVIOUSLY, THIS CALCULATED MU BOUNDS BY RUNNING FOUR SEQUENTIAL
% FEEDBACKED ESTIMATES, AND THEN PICKING HIGHEST OR LOWEST FOOM. BUT SEQUENTIAL APPROACH SEEMS BETTER.
function mu_bound = approach_mu_bound(moment_fn, f2, mu)

min_seed = 0;
max_seed = 0;

% step up approach  [still fails sometimes]
% for i = 5:5:mu
%     [mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, f2, @(x) mean(x(1:i)), min_seed, max_seed);
% end

% run four sequential trials -- keep the one with lowest first order optimality measure
[mu_bound_list(1:2,1), min_seed, max_seed, foom(1)] = bound_generic_fun_seed(moment_fn, f2, @(x) mean(x(1:mu)), 0, 0);
for i = 2:4
    [mu_bound_list(1:2,i), min_seed, max_seed, foom(i)] = bound_generic_fun_seed(moment_fn, f2, @(x) mean(x(1:mu)), min_seed, max_seed);
end

% pick the best result
mu_bound = mu_bound_list(1:2, 1);
best = 1;
for i = 2:4
    if foom(i) > foom(best)
        mu_bound = mu_bound_list(1:2, i);
        best = i;
    end    
end

mu_bound = flipud(100000 - mu_bound);
