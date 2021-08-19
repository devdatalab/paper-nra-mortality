function [A_moments, b_moments] = get_moment_constraints(cuts, values);

% BEGIN TMP
% cuts = [36, 47, 62, 79, 88, 94, 100];
% values = [35.06, 41.69, 51.04, 58.84, 69.20, 74.01, 80.54];
% END TMP

% initialize
num_cuts = length(cuts);

% set starting bound, which is 1
start = 0;

clear A_moments
clear b_moments

% loop over the cuts
for i = 1:num_cuts

    % generate row i of the bound function
    % each row is a set of zeroes of length x (which could be 0), a set of 1/y (length y), and a set of zeros of length z
    % (which could be zero)
    num_entries = cuts(i) - start;

    zeros_1 = zeros(1, start);
    vals = ones(1, num_entries) .* (1 / num_entries);
    zeros_2 = zeros(1, 100 - num_entries - start);

    A_moments(i, :) = [zeros_1 vals zeros_2];

    % set y-value for this bound
    b_moments(i) = values(i);

    % update starting point for next iteration
    start = start + num_entries;
end

% transpose b_moments
b_moments = b_moments';
