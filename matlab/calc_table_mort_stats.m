%% Get global paths
set_matlab_paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate mortality stats for 1992-94 and 2016-18 for Table 1

%% tell matlab where to find the solver 
addpath('../mort-solver')

%% set constant parameters
output_fn = output_path + "/bounds/mort_bounds_sample_table.csv";
ed_list = [1];
sex_list = [2];
race_list = [5];
year_list = [1992 2016];
src_data = 'ybin';
cause_list = 't';
rank_list = {'sex'};
recalc = 1;
age_list = [50];

%% set target cuts for the 8 statistics we want
target_cuts = ...
[0 20 45 70 100; ...
0 50 60 70 100; ...
0 8 60 70 100; ...
0 16 60 70 100];

%% calculate under monotonicity + curvature
spec_list = {'mon-step', 'nomon'};
f2_perc_list = [0.03];

%% loop over target cut lists
for t = 1:size(target_cuts, 1)
  target_cut_list = target_cuts(t, :);
  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list, ed_list, src_data, recalc)
end

%% repeat for the p's, where we target ed group 2
ed_list = [2];
target_cuts = ...
[0 10 11 70 100; ...
 0 25 26 70 100; ...
 0 4 5  70 100; ...
 0 8 9 70 100];

%% calculate under monotonicity + curvature
spec_list = {'mon-step', 'nomon'};
f2_perc_list = [0.012 0.03];

%% loop over target cut lists
for t = 1:size(target_cuts, 1)
  target_cut_list = target_cuts(t, :);
  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list, ed_list, src_data, recalc)
end



