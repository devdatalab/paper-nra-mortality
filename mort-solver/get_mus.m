function [mu] = get_mus(target_cuts, actual_cuts, vals, f2, spec);

% Takes a set of target cuts, and actual cuts, and returns a matrix where each row is a [mu_lb mu_ub]

% REQUIREMENTS: 
% - # OF BINS IS SAME IN BOTH CUT SETS
% - last cut = 100 (or highest possible value)
% - target_cuts is a row vector [used in the depths of the solver]
% - vals is a survival function

assert(size(target_cuts, 1) == 1);
assert(size(actual_cuts, 1) == 1);

% lengthen target cuts so we can start at 1
tcuts = [1 target_cuts];

% loop over number of bins 
for i = 1:length(target_cuts)

    % set mu_s and mu_t
    mu_s = round(tcuts(i));
    mu_t = round(tcuts(i + 1));

    % bound this mu
    mu(i, 1:2) = bound_mu('', round(actual_cuts), vals, mu_s, mu_t, f2, spec);
end

