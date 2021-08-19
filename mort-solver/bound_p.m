% Get a P
% - Takes input csv OR cuts / values.
% - pass blank string to input_csv if providing cuts and values
function p_bound = bound_p(input_csv, cuts, vals, p, f2, spec)

% turn off warnings when setting seeds -- we don't care
warning('off', 'MATLAB:nearlySingularMatrix')

% seed the solver at p/2
[p_bound, next_min_seed, next_max_seed] = bound_generic_fun2(input_csv, cuts, vals, @(x) x(ceil(p/2)), f2, spec);

% restore warnings for main run
warning('on', 'MATLAB:nearlySingularMatrix')

% calculate p from starting seed
[p_bound, next_min_seed, next_max_seed] = bound_generic_fun2(input_csv, cuts, vals, @(x) x(p), f2, spec, next_min_seed, next_max_seed);

p_bound       = fliplr(100000 - p_bound);
