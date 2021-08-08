%% Get global paths
set_matlab_paths

%% set output CSV file
output_fn = strcat(output_path, "/bounds/hisp_sim.csv");

f2_perc = 0.012;
type = "t";
mort_type = "tmortrate";
age = 50;
rank_type = "sex";
race = 1;
spec = "mon-step";
ed = 1;

%% set lists
year_list = [1992 2016];
sex_list = [1 2];

%% add matlab paths
addpath("../mort-solver")

%% read mean mortality from mort_means.csv
table_mort_means = readtable(input_path + "/mort_means_3.csv");

%% read mortality moments dataset
data = readtable(input_path + "/appended_rank_mort_3.csv");

%% write output file header if the file doesn't exist
if ~isfile(output_fn)
  insert_line(output_fn, "sex,year,shift", "mu_lb,mu_ub");
end

fprintf("Starting...\n");
for sex = sex_list
  
  %% loop over all years
  for year = year_list
    
    %% set f2 limit based on average mortality for this race-sex-age-year-type
    index = (table_mort_means.race == race) & (table_mort_means.sex == sex) & (table_mort_means.age == age) & (table_mort_means.year == year) & ...
            (strcmp(table_mort_means.cause, type));
    assert(sum(index) == 1);
    mean_mort = table_mort_means{index, "mort"};
    f2 = mean_mort * f2_perc;

    %% get table index for whites and hispanics in this group
    index_white = (data.sex == sex) & (data.race == 1) & (data.year == year) & (data.age == age);
    index_hisp  = (data.sex == sex) & (data.race == 3) & (data.year == year) & (data.age == age);

    assert(sum(index_white) == 4);
    assert(sum(index_hisp)  == 4);

    %% set cuts for dropout group
    mu_s = 1;
    mu_t = 10;

    %% get actual cuts from the current group (race doesn't matter for this, so use index_white)
    cuts = round(data.cum_ed_rank_sex(index_white)' * 100);

    %% assume 1992 is correct, and shift values for 2016
    if year == 1992
      vals = 100000 - data.(mort_type)(index_white)';
      
      %% set key
      key = sprintf("%d,%d,%5.2f", sex, year, 0);
      
      %% calculate this mu
      mu = bound_mu('', cuts, vals, mu_s, mu_t, f2, spec);

      %% insert result into output file
      val = sprintf("%1.2f,%1.2f", mu(1), mu(2));

      insert_line(output_fn, key, val);
      fprintf("Wrote %s.\n", key);
      
    %% but adjust 2016 years
    elseif year == 2016
  
      %% loop over hispanic shift values
      for shift = 0:.01:.25

        %% get white and hispanic mortality and 
        tmort_white = data.tmort(index_white)';
        tmort_hisp = data.tmort(index_hisp)';
        pop_white = data.tpop_rolling_5(index_white)';
        pop_hisp =  data.tpop_rolling_5(index_hisp)';
  
        trate_hisp  = tmort_hisp   ./ pop_hisp  .* 100000;
        trate_white = tmort_white  ./ pop_white .* 100000;
  
        %% actual white mortality is: tmort_white / pop_white * 100000.
        %% but let's assume X% (shift) of hispanics would have called themselves white in 1992.
        pop_white_adjusted = pop_white + pop_hisp .* shift;
        tmort_white_adjusted = tmort_white + tmort_hisp .* shift;
  
        %% generate new white mortality numbers
        vals = 100000 - tmort_white_adjusted ./ pop_white_adjusted .* 100000;
  
        %% set key
        key = sprintf('%d,%d,%5.2f', sex, year, shift);
        
        %% calculate this mu
        mu = bound_mu('', cuts, vals, mu_s, mu_t, f2, spec);
        
        %% insert result into output file
        val = sprintf('%1.2f,%1.2f', mu(1), mu(2));
        
        insert_line(output_fn, key, val);
        fprintf('Wrote %s,%s.\n', key, val);
      end
    end
  end
end


