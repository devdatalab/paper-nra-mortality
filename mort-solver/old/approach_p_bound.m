function p_bound = approach_p_bound(moment_fn, f2, p)
global f_min_mse
min_seed = 0;
max_seed = 0;

% step up to the request p/mu
% for i = 5:5:p
%     [p_bound, min_seed, max_seed] = bound_generic_fun_seed(moment_fn, f2, @(x) x(i), min_seed, max_seed);
% end

% run four sequential trials -- keep the one with lowest first order optimality measure
[p_bound_list(1:2,1), min_seed, max_seed, foom(1)] = bound_generic_fun_seed(moment_fn, f2, @(x) x(p), 0, 0);
for i = 2:4
    [p_bound_list(1:2,i), min_seed, max_seed, foom(i)] = bound_generic_fun_seed(moment_fn, f2, @(x) x(p), min_seed, max_seed);
end

% pick the best result
p_bound = p_bound_list(1:2, 1);
best = 1;
for i = 2:4
    if foom(i) > foom(best)
        p_bound = p_bound_list(1:2, i);
        best = i;
    end    
end

p_bound = flipud(100000 - p_bound);
