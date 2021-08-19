function [p_min p_max] = get_mort_bounds(input_csv, f2_limit, spec);

% return value: matrix with p value, lower bound, upper bound
global A_moments b_moments f_min_mse

% if f2_limit is zero, just exit -- takes forever---just use analytical numbers from stata.
if f2_limit == 0
    fprintf('get_mort_bounds() called with f2_limit == 0.  Use Stata gradient predictions instead.\n')
    return
end

% get standard solver parameters
[options, num_ps, A_moments, b_moments, A_ineq, b_ineq, x0_start, lb, ub] = get_mort_solver_params2(f2_limit, spec, input_csv);

% create arrays to hold max and minimum values of p. start at extreme values, so we can tell if the solver failed
clear p_min p_max
p_min = zeros(num_ps, 1);
p_max = 100000 * ones(num_ps, 1);

% STEP 1: CALCULATE MINIMUM MSE UNDER THIS f2 CONSTRAINT
[x_start, f_min_mse, exit_flag, output] = fmincon(@fun_mse, x0_start, A_ineq, b_ineq, [], [], lb, ub, [], options);

assert(exit_flag == 1 | exit_flag == 2);

% STEP 2: MAXIMIZE/MINIMIZE EACH p-BOUND, S.T. TO MEETING THIS MSE

% preload x_min and x_max
x_min = x_start;
x_max = x_start;

% set starting max value to p1 value
[x_max, f_min_mse_tmp, exit_flag, output] = fmincon(@(x) (x(1)), x_start, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse, options);

% now set starting max value to p2 value
[x_max, f_min_mse_tmp, exit_flag, output] = fmincon(@(x) (x(2)), x_max, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse, options);

% loop over all p-levels
fprintf(sprintf('Finding bounds on requested p-levels (%s) ...', spec));

for j = 1:100

    if mod(j, 10) == 1
        fprintf('\nCalculating p-levels %d to %d.', j, j + 9);
    else
        fprintf('.');
    end

    % calculate max feasible p-level
    [x_min, f_min, exit_flag, output] = fmincon(@(x) (x(j)), x_min, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse, options);
    if (exit_flag == 1 | exit_flag == 2)
        p_min(j, 1) = x_min(j);
    end
    
    % calculate minimum feasible p-level
    [x_max, f_min, exit_flag, output] = fmincon(@(x) (-x(j)), x_max, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse, options);
    if (exit_flag == 1 | exit_flag == 2)
        p_max(j, 1) = x_max(j);
    end
end
fprintf('\n');
