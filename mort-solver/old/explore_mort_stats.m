% Create all statistics for summary table in Bounds paper
% goal: women's mortality by constant rank education group, in 1992 and in 2015

% set constant parameters
moment_folder = '~/iec1/mortality/moments';
year_list = [1992 2015];
race = 'all';
sex = 2;
age = 50;
type = 't';
bins = '_3bin';

% set variable parameters
f2 = 3;
year = 2015;

% set moment filename
moment_fn = sprintf('%s/%d/%s_%d_%d_%s_%ssurvrate%s.csv', moment_folder, year, race, 2, age, 'sex', type, bins);

% define mu and p functions
p = 32;

p_fun_cmd = sprintf('fun_p = @(x) x(%d);', p);
eval(p_fun_cmd);

mu_fun_cmd = sprintf('fun_mu = @(x) mean(x(1:%d));', p * 2);
eval(mu_fun_cmd);
    
% get bounds on p -- with no seed
p_bound_3 = fliplr(100000 - bound_generic_fun(moment_fn, 3, fun_p));
p_bound_5 = fliplr(100000 - bound_generic_fun(moment_fn, 5, fun_p));

% review
[3 p_bound_3; 5 p_bound_5]

% generate some starting seeds
p15 = fliplr(100000 - bound_generic_fun(moment_fn, 3, @(x) x(15)));
approach_p_bound(moment_fn, f2, 15)

min_seed = 0;
max_seed = 0;
for i = [5 10 15 20 25 30]
    i
    [p_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 5, @(x) x(i), min_seed, max_seed);
end

% calculate p32 using generated seed
[p_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 5, @(x) x(32), min_seed, max_seed);
p_bound = fliplr(100000 - p_bound)

% compare to original value
p_bound_3
p_bound_5

% try mu-0-30 two times in a row
fun_mu = @(x) mean(x(1:38))
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 5, fun_mu, 0, 0);
100000-mu_bound
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 5, fun_mu, min_seed, max_seed);
100000-mu_bound
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 5, fun_mu, min_seed, max_seed);
100000-mu_bound
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 5, fun_mu, min_seed, max_seed);
100000-mu_bound

% try mu-0-30 two times in a row
fun_mu = @(x) mean(x(1:38))
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 3, fun_mu, 0, 0);
100000-mu_bound
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 3, fun_mu, min_seed, max_seed);
100000-mu_bound
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 3, fun_mu, min_seed, max_seed);
100000-mu_bound
[mu_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, 3, fun_mu, min_seed, max_seed);
100000-mu_bound

