function [c,ceq] = c_fun_mse_semimon(x);

global A_moments b_moments f_min_mse max_nomons_global


%% calculate slope at each point
slopes = x(2:end) - x(1:end-1);

%% calculate moment MSE
mse = fun_mse(x);

%% if we fail monotonicity, make the constraint continuous so the solver can use it
if sum(slopes < 0) > max_nomons_global
  semimon_constraint = sum(slopes(slopes > 0));

%% otherwise, the constraint is satisfied, and set it to zero
else
  semimon_constraint = 0;
end

%% require MSE below threshold AND number of non-mon steps is below threshold
c = mse - (f_min_mse) + semimon_constraint;

%% no non-linear equality constraints so set this to empty
ceq = [];

