% bound the some mobility function of the CEF, under some level of allowed curvature of the underyling function
function [bounds, min_seed, max_seed, foom] = bound_generic_fun_step_seed(input_csv, f2_limit, fun, min_seed, max_seed);
    global f_min_mse

    % create negative function (so we can get a max value by minimizing negative function)
    function val = neg_fun(p)
        val = -fun(p);
    end

    % set globals
    global A_moments b_moments f_min_mse

    % get standard solver parameters
    [options, cuts, vals, num_ps, A_moments, b_moments, A_ineq, b_ineq, x0_start, lb, ub] = get_mort_solver_params_step(input_csv, f2_limit);

    % create arrays to hold max and minimum values of p. start at extreme values, so we can tell if the solver failed
    clear p_min p_max
    p_min = zeros(1, num_ps);
    p_max = 100 * ones(1, num_ps);

    % STEP 1: calculate any feasible CEF to set f_min_mse
    [seed, f_min_mse, exit_flag, output] = fmincon(@fun_mse, x0_start, A_ineq, b_ineq, [], [], lb, ub, [], options); 
    assert(exit_flag == 1 | exit_flag == 2);

    % if seed is initialized to zero, use starting seed above
    if max(max_seed) == 0
        min_seed = seed;
        max_seed = seed;
    end
        
    % STEP 2: MAXIMIZE/MINIMIZE EACH p-BOUND, S.T. TO MEETING THIS MSE
    
    % now find lowest possible value of regression coefficient
    [min_seed, f_min, exit_flag, output] = fmincon(fun,     min_seed, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse, options);

    % now find highest possible value of the regression coefficient
    [max_seed, f_max, exit_flag, output] = fmincon(@neg_fun, max_seed, A_ineq, b_ineq, [], [], lb, ub, @c_fun_mse, options);

    foom = output.firstorderopt;
    bounds = [f_min, -f_max];
end
