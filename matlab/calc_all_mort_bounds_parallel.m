%% make successive calls to get_mort_stats.m to create output files matching
%% every specification used in the paper
function calc_all_mort_bounds_parallel(age, race, solver_path, output_path)
  
  %% tell matlab where to find the solver 
  addpath(solver_path)

  %% COMPLETE FUNCTION CALL
  %% this generates all possible specs but takes a long time. so instead
  %% we just calculate what we use in the paper.  
  %% f2_perc_list = [0.012];
  %% cause_list = 'thcdao';
  %% year_list = 1992:2018;
  %% sex_list = [1 2];
  %% age_list = [25:5:65];
  %% target_cut_list = [0 10 45 70 100];
  %% rank_list = {'sex', 'race_sex'};
  %% race_list = [1 2];
  %% spec_list = {'mon-step', 'mon', 'nomon'};
  %% output_fn = '/scratch/pn/mus/mort_bounds.csv';
  %% ed_list = 1:4;

  %% set universal parameters used by all function calls
  f2_perc_list = [0.03];
  ed_list = 1:4;
  sex_list = [1 2];
  target_cut_list = [0 10 45 70 100];
  race_list = [race];
  src_data = 'ybin';
  recalc = 0;

  %% note all specs use the same output function because we use insert_into_file() and recalc = 0.
  output_fn = sprintf('%s/mort_bounds_all_%d_%d.csv', output_path, age, race);

  %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  fprintf('Full output dataset: every year, total mortality, all ages, all races\n')
  cause_list = 'tdn';
  year_list = 1992:3:2016;
  race_list = [race];
  age_list = [age];
  rank_list = {'sex'};
  spec_list = {'mon'};

  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list, ed_list, src_data, recalc)

  %% rest of file only runs for races 1, 2, and 5
  if race == 3 | race == 4
    exit
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% a few specialized call for the naive comparison graph
  fprintf('Specialized entries for naive comparison\n')
  target_naive_women_50 = [0 17 60 81 100];
  target_naive_men_50 = [0 17 52 73 100];
  cause_list = 'td';

  get_mort_stats(output_fn, f2_perc_list, cause_list, [1992:3:2016], [2], age_list, target_naive_women_50  , rank_list, [race], spec_list, ed_list, src_data, recalc)

  get_mort_stats(output_fn, f2_perc_list, cause_list, [1992:3:2016], [1], age_list, target_naive_men_50  , rank_list, [race], spec_list, ed_list, src_data, recalc)

  %% rest of file only for races 1 and 2
  if race == 5
    exit
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  fprintf('mon-step spec')

  year_list = [1992 2016];
  cause_list = 't';
  spec_list_step = {'mon-step'};

  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list_step, ed_list, src_data, recalc)


%%%%%%%%%%%%%%%%%%%%%%%%
  fprintf('Table A2: all causes, first and last year\n')
  cause_list = 'tdchao';
  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list, ed_list, src_data, recalc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% SENSITIVITY TESTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  cause_list = 't';
  year_list = [1992 2013 2016];
  rank_list = {'sex'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  fprintf('E1-A: 1992 PERCENTILE BOUNDARIES\n')
%%  target_cut_list_1992 = [0 17 60 81 100];
%%  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list_1992, rank_list, race_list, spec_list, ed_list, src_data, recalc)

  fprintf(' E1-B: WITHIN RACE-GENDER PERCENTILES\n')
  rank_list_rs = {'race_sex'};
  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list_rs, race_list, spec_list, ed_list, src_data, recalc)

  fprintf(' E1-C: no monotonicity\n')
  spec_list_nomon = {'nomon'};
  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list_nomon, ed_list, src_data, recalc)

  fprintf(' E1-D: no smoothness\n')
  spec_list_nomon = {'mon'};
  f2_perc_list_none = 10;
  get_mort_stats(output_fn, f2_perc_list_none, cause_list, year_list, sex_list, age_list, target_cut_list, rank_list, race_list, spec_list, ed_list, src_data, recalc)

  %% 3-bin education results
  cause_list = 't';
  year_list = [1992 2016];
  rank_list = {'sex'};
  spec_list = {'mon'};
  fprintf(' E9: 3 bin education results\n')
  src_data_3bin = 'ybin_ed3';
  target_cut_list_3bin = [0 45 70 100];
  ed_list_3bin = 1:3;
  get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list_3bin, rank_list, race_list, spec_list, ed_list_3bin, src_data_3bin, recalc)

  %% Case-Deaton replication: no longer used
  %% fprintf(' Case-Deaton replication with and without bounds\n')
  %% year_list = 1992:3:2016;
  %% get_mort_stats(output_fn, f2_perc_list, cause_list, year_list, sex_list, age_list, target_cut_list_3bin, rank_list, race_list, spec_list, ed_list, src_data_3bin, recalc)
end
