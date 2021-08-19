%% Get global paths
set_matlab_paths
addpath("../mort-solver")

%% read mortality moments dataset -- 3-year grouped version
data = readtable(input_path + "/appended_rank_mort_3.csv");
table_mort_means = readtable(input_path + "/mort_means_3.csv");

%% set parameters to identify table row that we want
age = 50;
sex = 2;
race = 5;
year = 2016;
type = 't';
mort_type = 'tmortrate';
f2_list = [0.012 0.024 0.048 100];
ranktype = 'sex';
spec = 'mon';
ed = 1;
target_cut_list = [0 10 45 70 100];
ed_list = 1:4;

%% get mean mort for this group
index = (table_mort_means.race == race) & (table_mort_means.sex == sex) & (table_mort_means.age == age) & (table_mort_means.year == year) & (strcmp(table_mort_means.cause, type));
assert(sum(index) == 1);
mean_mort = table_mort_means{index, 'mort'};

%% get table index for this group's mortality moments
index = (data.sex == sex) & (data.race == race) & (data.year == year) & (data.age == age);

%% if no data for this entry, skip it
if sum(index) ~= length(ed_list)
  sum(index)
  error(sprintf('Wrong number of matching rows in moments file.\n', length(ed_list)))
end

%% get actual cuts from the current group
cuts = round(data.cum_ed_rank_sex(index)' * 100);

%% transform data from mortality rates to survival rates -- so it is monotonic positive
vals = 100000 - data.(mort_type)(index)';

%% loop over f2 values
for f = 1:length(f2_list)
  
  %% set f2 percentage and name
  f2_perc = f2_list(f);
  f2_name = string(round(f2_perc * 1000));
                        
  %% loop over all possible p values with default f2
  fprintf("calculating cef with f2 = %7.4f\n", f2_perc)
  f2 = mean_mort * f2_perc;
  for i = 1:99
    
    if mod(i, 10) == 0
      fprintf('\b%d', i)
    else
      fprintf('.')
    end
    
    %% calculate mu from i to i+1
    mu = bound_mu('', cuts, vals, i, i+1, f2, spec);
    mu_lb(i) = mu(1);
    mu_ub(i) = mu(2);
  end
  fprintf('\n')
  
  %% get the bin midpoints from the cuts
  mid(1) = cuts(1) / 2;
  mid(2) = (cuts(2) - cuts(1)) / 2 + cuts(1);
  mid(3) = (cuts(3) - cuts(2)) / 2 + cuts(2);
  mid(4) = (cuts(4) - cuts(3)) / 2 + cuts(3);
  
  %% smooth mus
  mu_lb_smooth = mu_lb;
  mu_lb_smooth(2:98) = (mu_lb(1:97) + mu_lb(2:98) + mu_lb(3:99)) / 3;
  mu_ub_smooth = mu_ub;
  mu_ub_smooth(2:98) = (mu_ub(1:97) + mu_ub(2:98) + mu_ub(3:99)) / 3;

  %% store smooth mus
  csv_fn = sprintf(output_path + "/mort_cef_%s.csv", f2_name);
  csvwrite(csv_fn,[[1:99]' mu_lb' mu_ub'])
  
  clf
  hold on
  plot(1:99, mu_lb_smooth, 'LineWidth', 1, 'color', 'k') 
  plot(1:99, mu_ub_smooth, 'LineWidth', 1, 'color', 'k')
  
  %% plot bin means
  scatter(mid, 100000 - vals, 'filled', 'k')
  
  %% plot bin boundaries
  for i = 1:length(cuts)
    plot([cuts(i) cuts(i)], [0 2500], 'k', 'LineStyle', '-')
  end
  
  % axis label
  xlabel('Education Percentile');
  ylabel('Mortality Rate (per 100,000)');
  
  write_pdf(sprintf(graph_path + "/mort_cef_%s", f2_name))
end

