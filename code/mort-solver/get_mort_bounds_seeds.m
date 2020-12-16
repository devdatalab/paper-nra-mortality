function [p_min p_max] = get_mort_bounds_seeds(input_csv, f2_limit);

% return value: matrix with p value, lower bound, upper bound
global A_moments b_moments f_min_mse

% if f2_limit is zero, just exit -- takes forever ---just use analytical numbers from
% stata.
if f2_limit == 0
    fprintf('get_mob_bounds() called with f2_limit == 0.  Use Stata gradient predictions instead.\n')
    return
end

% get standard solver parameters
[options, cuts, vals, num_ps, A_moments, b_moments, A_ineq, b_ineq, x0_start, lb, ub] = get_mort_solver_params(input_csv, f2_limit);

% create arrays to hold max and minimum values of p. start at extreme values, so we can tell if the solver failed
clear p_min p_max
p_min = zeros(num_ps, 1);
p_max = 100000 * ones(num_ps, 1);

% STEP 1: CALCULATE MINIMUM MSE UNDER THIS f2 CONSTRAINT
[x_start, f_min_mse, exit_flag, output] = fmincon(@fun_mse, x0_start, A_ineq, b_ineq, [], [], lb, ub, [], options);

assert(exit_flag == 1 | exit_flag == 2);

% STEP 2: MAXIMIZE/MINIMIZE EACH p-BOUND, S.T. TO MEETING THIS MSE

% preload x_min and x_max
%x_min = x_start;
%x_max = x_start;

% do ten tests of initial seed for xmax @p1, stepping out 500 (by 100) in each direction of initial x_start - 5 steps in
% either direction
% first, drop down to the lowest in the range we will step over
xmax_seed_list{1} = x_start - 500;

% loop over the remaining steps, all increasing 100 at a time. this completes our 11 input seeds
for i = 2:11
    xmax_seed_list{i} = xmax_seed_list{1} + (i-1)*100;
end

% loop over the 11 input seeds, and save the output foom - we will use this to select our seed
for i = 1:11
    [x_max_out_list{i}, f_min_mse_list(i), exit_flag, output] = fmincon(@(x) (-x(1)), xmax_seed_list{i}, A_ineq, b_ineq, [], [], lb, ub,@c_fun_mse, options);
    foom_list_max{i} = output.firstorderopt;
    fprintf('\nfoom_max %d:  %d', i, foom_list_max{i});
end

% do these same steps for xmin
xmin_seed_list{1} = x_start - 500;
for i = 2:11
    xmin_seed_list{i} = xmin_seed_list{1} + (i-1)*100;
end
for i = 1:11
    [x_min_out_list{i}, f_min_mse_list(i), exit_flag, output] = fmincon(@(x) (x(1)), xmin_seed_list{i}, A_ineq, b_ineq, [], [], lb, ub,@c_fun_mse, options);
    foom_list_min{i} = output.firstorderopt;
    fprintf('\nfoom_min %d:  %d', i, foom_list_min{i});
end

% now, pick the best result (lowest foom) for both min and max
% start our comparisons with the first (lowest) step, and move up from there
x_max = xmax_seed_list{1};
x_min = xmin_seed_list{1};

% set indicators for the index of each of the 11 seeds, initialize to 1
best_min = 1;
best_max = 1;

% loop over the remaining steps and compare foom - keep a record of which is smallest for each of min and max
for i = 2:11
    if foom_list_max{i} < foom_list_max{best_max}

        % if this is the best step so far, save as our starting seeds
        x_max = xmax_seed_list{i};
        best_max = i;
    end    
    if foom_list_min{i} < foom_list_min{best_min}
        
        % if this is the best step so far, save as our starting seeds
        x_min = xmax_seed_list{i};
        best_min = i;
    end    
end

% return the index of the min and max (helpful for diagnostics, can be commented out)
fprintf('\nBest of all of the 1-11 runs for MAX:  %d', best_max);
fprintf('\nBest of all of the 1-11 runs for MIN:  %d', best_min);

% loop over all p-levels
fprintf('\nFinding bounds on requested p-levels...');

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
