%% Get global paths
set_matlab_paths

%% Generate semimon graphs and figures at 5 levels of semi-monotonicity

%% add solver path
addpath('../mort-solver')

%% load source data
data             = readtable(input_path + "/appended_rank_mort_3.csv");
table_mort_means = readtable(input_path + "/mort_means_3.csv");

%% prepare to read from the table
age = 50;
rank_type = 'sex';
type = 't';
mort_type = 'tmortrate';
race = 1;
year_list = [1992 2016];
f2_perc = 0.03;

%% set parameters for each sex and year
for sex = 1:2
  for y = 1:length(year_list)
    year = year_list(y);

    %% set f2 limit based on average mortality for this race-sex-age-year-type
    index = (table_mort_means.race == race) & (table_mort_means.sex == sex) & (table_mort_means.age == age) & (table_mort_means.year == year) & (strcmp(table_mort_means.cause, type));
    assert(sum(index) == 1);
    mean_mort = table_mort_means{index, 'mort'};
    f2{y, sex} = mean_mort * f2_perc;

    %% get table index for this group's mortality moments
    index = (data.sex == sex) & (data.race == race) & (data.year == year) & (data.age == age);
    assert(sum(index) == 4)

    %% store the cuts and values (converting vals to survival rates)
    cuts{y, sex} = round(data.cum_ed_rank_sex(index)' * 100);
    vals{y, sex} = 100000 - data.(mort_type)(index)';
  end
end

%% hard-code cuts, values, and f2 (which is a function of mean group mortality for whites age 50
%% s1_1992_f2 = 19.5;
%% s2_1992_f2 = 11.25;
%% s1_2016_f2 = 17.75;
%% s2_2016_f2 = 11.25;

%% cuts1_1992 = [ 17 52 73 100];
%% vals1_1992 = [ 98743 99204 99539 99607 ];
%% 
%% cuts2_1992 = [ 17 60 81 100];
%% vals2_1992 = [ 99365 99573 99731 99755 ];
%% 
%% cuts1_2016 = [ 10 44 69 100];
%% vals1_2016 = [ 98113 99135 99538 99768 ];
%% 
%% cuts2_2016 = [ 8 37 67 100];
%% vals2_2016 = [ 98520 99424 99688 99834 ];

%% create list of semi-monotonicity parameters
mon_list = [0 5 10 15 20 50 100];

%% create an empty matrix to hold all the bounds: [sex, year, mon_limit, lb/ub]
bounds = zeros(2, 2, length(mon_list), 2);

%% create the seed matrices for each subgroup
min_seed = zeros(2, 2, 100);
for s = 1:2
  for r = 1:2
    min_seed(s, r, 1:100) = zeros(100, 1);
    max_seed(s, r, 1:100) = zeros(100, 1);
  end
end

%% create permuted min/max seeds to make it easy to extract the long vector
pmin_seed = permute(min_seed, [3 1 2]);
pmax_seed = permute(max_seed, [3 1 2]);

%% loop over monotonicity settings
for m = 1:length(mon_list)
  mon = mon_list(m);

  %% calculate and graph bounds for white women, 1992, with graph
  [bounds(2, 1, m, :) min_seed(2, 1, 1:100) max_seed(2, 1, 1:100)] = calc_semimon_mort_bounds(cuts{1,2}, vals{1,2}, f2{1,2}, mon, graph_path + sprintf("/f1992_semimon_%d", mon), pmin_seed(:, 2,1)', pmax_seed(:, 2,1)');
  
  %% 1992 white men
  [bounds(1, 1, m, :) min_seed(1, 1, 1:100) max_seed(1, 1, 1:100)] = calc_semimon_mort_bounds(cuts{1,1}, vals{1,1}, f2{1,1}, mon, '', pmin_seed(:, 1, 1)', pmax_seed(:, 1, 1)');

  %% 2016 men and women
  [bounds(2, 2, m, :) min_seed(2, 2, 1:100) max_seed(2, 2, 1:100)] = calc_semimon_mort_bounds(cuts{2,2}, vals{2,2}, f2{2,2}, mon, '', pmin_seed(:, 2, 2)', pmax_seed(:, 2, 2)');
  [bounds(1, 2, m, :) min_seed(1, 2, 1:100) max_seed(1, 2, 1:100)] = calc_semimon_mort_bounds(cuts{2,1}, vals{2,1}, f2{2,1}, mon, '', pmin_seed(:, 1, 2)', pmax_seed(:, 1, 2)');

  %% permute the min_seed and max_seed vectors so it is easy to get the long column vector out of them
  pmin_seed = permute(min_seed, [3 1 2]);
  pmax_seed = permute(max_seed, [3 1 2]);
end

%% write all results to a CSV file
sex_list = {'m','f'};
bound_list = {'lb','ub'};
f = fopen(graph_path + "/semimon_bounds.csv", 'w');

for s = 1:2
  sex = sex_list{s};
  for mon = 1:length(mon_list)

    %% write the 1992 bounds
    fprintf(f, 'b_%s_1992_%d_lb,$[%1.0f,%1.0f]$\n', sex, mon_list(mon), bounds(s,1,mon,1), bounds(s,1,mon,2));
    
    %% write the 2016 bounds
    fprintf(f, 'b_%s_2016_%d_ub,$[%1.0f,%1.0f]$\n', sex, mon_list(mon), bounds(s,2,mon,1), bounds(s,2,mon,2));

    %% calculate and write the % difference
    diff_ub = (bounds(s,2,mon,2) / bounds(s,1,mon,1) - 1) * 100;
    diff_lb = (bounds(s,2,mon,1) / bounds(s,1,mon,2) - 1) * 100;
    
    fprintf(f, 'b_%s_diff_%d,$[%2.1f\\%%, %2.1f\\%%]$\n', sex, mon_list(mon), diff_lb, diff_ub);
  end
end

fclose(f);

%% convert the CSV to a latex table using a template
%% !python ~/ddl/stata-tex/table_from_tpl.py -t ~/ddl/mortality/a/tpl/semimon_bounds.tpl -o ~/iec/output/mort_new/semimon_bounds.tex -r ~/iec/output/mort_new/semimon_bounds.csv
pycall = sprintf("python ../stata-tex/table_from_tpl.py -t ../a/tpl/semimon_bounds.tpl -o %s/semimon_bounds.tex -r %s/semimon_bounds.csv", graph_path, graph_path)
system(pycall);
