%% PN NOTES 2020/08: I think this file is obsolete. It looks like a prior version of get_mort_stats.
%%                   But it's also possible that this is a different program that generates some one-off result.
%%                   One key difference between this and get_mort_stats.m is that this one takes a bc_list, and the
%%                   other takes an age list. I'm not yet clear on what this means.                   

function ans = get_cohort_stats(output_fn, f2_perc_list, type_list, year_list, sex_list, bc_list, target_cut_list, ...
                                       rank_list, race_list, spec_list, ed_list, recalc_if_exist)

% add solver path
addpath('~/iecmerge/paul/mort-solver')
addpath('~/iecmerge/include/matlab')

% read mean mortality from mort_means.csv -- for f2 calibrations
table_mort_means = readtable('~/mort/mort_means.csv');

% read mortality moments dataset
data = readtable('~/mort/mort_data_granular_10.csv');

% set constant parameters
moment_folder = '~/mort';
race_names = {'white', 'black', 'hispanic', 'other'};

% calculate target_cut_name_list
for row = 1:size(target_cut_list, 1)
    target_cut_name_list{row} = '';
    for col = 1:(size(target_cut_list, 2) - 2)
        target_cut_name_list{row} = strcat(target_cut_name_list{row}, '-', int2str(target_cut_list(row, col + 1)));
    end

    % remove initial dash
    target_cut_name_list{row} = target_cut_name_list{row}(2:end);
end

% write output file header
insert_line(output_fn, 'spec,base_year,f2,type,bc,sex,race,year,edclass,rank_type,mu_s,mu_t', 'mu_lb,mu_ub');
% note base_year === target_cut_name

% calculate number of requests
num_requests = length(bc_list) * length(rank_list) * length(f2_perc_list) * length(type_list) * length(sex_list) * ...
    length(race_list) * size(target_cut_list, 1) * length(year_list) * length(ed_list) * length(spec_list);
fprintf('Number of requests: %d\n', num_requests);

% set initial timer and completion counter
num_complete = 0;

% loop over all birth cohorts
for bc = bc_list
  % loop over rank types
  for r = 1:length(rank_list)
    rank_type = rank_list{r};
    
    % loop over f2s, death types, sex
    for f2_perc = f2_perc_list
      for type = type_list
        mort_type = strcat(type, 'mortrate');
        
        for sex = sex_list
          
          % loop over race
          for race = race_list
            race_name = race_names{race};
            
            % loop over target cut list
            for target = 1:size(target_cut_list, 1)
              target_cuts = target_cut_list(target, :);
              target_name = target_cut_name_list{target};

              % loop over all years
              for year = year_list
                
                % set f2 limit based on average mortality for this race-sex-age-year-type
                age_gp = floor((year - bc) / 5) * 5;
                f2_index = (table_mort_means.race == race) & (table_mort_means.sex == sex) & (table_mort_means.age == age_gp) & (table_mort_means.year == year) & ...
                        (strcmp(table_mort_means.cause, type));
                
                % continue if we didn't find this field -- means birth cohort / year combination not in data
                if sum(f2_index) < 1
                  num_complete = num_complete + 4;
                  continue
                end
                assert(sum(f2_index) == 1);
                mean_mort = table_mort_means{f2_index, 'mort'};
                f2 = mean_mort * f2_perc;

                % get table index for this group's mortality moments
                index = (data.sex == sex) & (data.race == race) & (data.year == year) & (data.bc == bc);

                % if no data for this entry, skip it
                if sum(index) < 4
                  error('Got somewhere unexpected.\n');
                  num_complete = num_complete + 4;
                  continue
                end
                if sum(index) ~= 4
                  sum(index)
                  error('More than 4 rows in moments file.\n')
                end

                % loop over four ed bins
                for ed = ed_list
                  
                  % define mu bounds for this ed bin. Shift mu_s by 1 b/c discrete -- 
                  % so cuts at 10, 45 give mu_s, mu_t = 11, 45
                  mu_s = target_cuts(ed) + 1;
                  mu_t = target_cuts(ed + 1);

                  % get actual cuts from the current group
                  cuts = round(data.cum_ed_rank_sex(index)' * 100);
                  vals = 100000 - data.(mort_type)(index)';

                  % loop over specs
                  for s = 1:length(spec_list)
                    tic
                    spec = spec_list{s};

                    % set key
                    key = sprintf('%s,%s,%6.3f,%s,%d,%d,%d,%d,%d,%s,%d,%d', target_name, spec, f2_perc, type, bc, sex, race, ...
                                  year, ed, rank_type, mu_s, mu_t);
                    % if key already in file, skip it unless recalc is on
                    if recalc_if_exist | (key_exists(output_fn, key) == 0)

                      % calculate this mu under each spec
                      mu = bound_mu('', cuts, vals, mu_s, mu_t, f2, spec);
                      
                      % insert result into output file
                      val = sprintf('%1.2f,%1.2f', mu(1), mu(2));
                      insert_line(output_fn, key, val);
                      
                      % report progress
                      mu_time = toc;
                      num_complete = num_complete + 1;
                      time_left = (num_requests - num_complete) * (mu_time) / 3600;
                      fprintf('Wrote %s: %5.0fs (%d/%d). ETA: %5.1f hours.\n', key, mu_time, num_complete, num_requests, ...
                              time_left);
                    else
                      fprintf('Skipping %s.\n', key);
                      
                      % adjust timer so we don't get confused
                      num_requests = num_requests - 1;
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

