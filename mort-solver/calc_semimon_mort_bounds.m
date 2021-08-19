%% matlab code to calculate semimonotonic mortality bounds on bottom 10%
%% based on bound_generic_fun2()
function [bounds, min_seed, max_seed] = calc_semimon_mort_bounds(cuts, vals, f2_limit, max_nomons, graph_fn, min_seed, max_seed)
  fprintf('\n-------------------\nstarting bounds function...nomons=%d\n', max_nomons)
  
  %% hardcode cuts, vals according to the bottom 10% of white women.
  mu_s = 1;
  mu_t = 10;

  %% set input_csv to blank, since cuts and vals are passed in
  input_csv = '';

  %% define the object we are trying to bound
  fun = @(x) mean(x(mu_s:mu_t));

  %% create a negative value function (so we can get a max value by minimizing negative function)
  neg_fun = @(x) -fun(x);

  %% set global min_mse and max number of non-monotonic cells for fmincon
  global f_min_mse
  global max_nomons_global
  max_nomons_global = max_nomons;

  %% define the non-linear constraint.
  count_nomons = @(p) (sum((p(2:end) - p(1:end-1)) < 0) - max_nomons_global);

  %% get the standard solver parameters for a monotonic solution
  [options, num_ps, A_moments, b_moments, A_ineq, b_ineq, x0_start, lb, ub] = get_mort_solver_params2(f2_limit, 'nomon', input_csv, cuts, vals);

  %% if blank seeds were passed in, then seed the solver with the monotonic best:
  if sum(min_seed) == 0
    fprintf('setting seed...\n')
    [p_bound, min_seed, max_seed] = bound_generic_fun2(input_csv, cuts, vals, fun, f2_limit, 'mon');
  end

  %% SOLVER STEP 1: calculate any feasible CEF to set f_min_mse
  fprintf('finding a feasible starting point...\n')
  f_min_mse = 100000000;
  [seed, f_min_mse, exit_flag, output] = fmincon(@fun_mse, x0_start, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse_semimon, options); 

  %% if we didn't find a solution, return min and max bounds of 100,000
  if ~(exit_flag == 1 | exit_flag == 2)
    fprintf('Solution not found. Returning [0, 0].\n');
    bounds = [100000, 100000];
    return
  end

  %% STEP 2: MAXIMIZE/MINIMIZE EACH p-BOUND, S.T. TO MEETING THIS MSE
  fprintf('running the solver with all the constraints...\n')
  
  %% now find lowest possible value of mu-0-10
  [min_seed, f_min, exit_flag, output] = fmincon(fun,     min_seed, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse_semimon, options);

  %% now find highest possible value of mu-0-10
  [max_seed, f_max, exit_flag, output] = fmincon(neg_fun, max_seed, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse_semimon, options);

  %% plot the graph if it's not missing
  if length(graph_fn) > 0
    ps = 100000 - [max_seed' min_seed'];
    plot_semimon_bounds(graph_fn, ps, cuts, vals)
  end
  
  bounds = fliplr(100000 - [f_min, -f_max]);
end

