%% PN NOTES 2020/10: This is the primary mortality solver result genererating file.
function ans = get_mort_stats(output_fn, f2_perc_list, type_list, year_list, sex_list, age_list, target_cut_list, ...
                              rank_list, race_list, spec_list, ed_list, src_data, recalc_if_exist)
  
  %% TEMPORARY: PRELOAD FUNCTION ARGUMENTS
  %% f2_perc_list = [0.012];
  %% type_list = 'thcdao';
  %% year_list = [1992 2000 2018];
  %% sex_list = [1 2];
  %% age_list = [30 35 40 45 50 55 60 65];
  %% target_cut_list = [0 10 45 70 100];
  %% rank_list = {'sex', 'race_sex'};
  %% race_list = [1 2];
  %% spec_list = {'mon-step', 'mon', 'nomon'};
  %% ed_list = 1:4;
  %% output_fn = '/scratch/pn/mus/mort_causes_fixed.csv';
  %% END FUNCTION ARGUMENTS

  %% add solver path
  addpath('../mort-solver')

  %% read mean mortality from mort_means.csv -- for f2 calibrations

  %% read mortality moments dataset

  %% if we received 13 parameters, check src_data parameter to see if this is the
  %% 3-bin function call.
  if nargin == 13
    if strcmp(src_data, 'ybin')
      data = readtable('~/iec/mortality/int/matlab_inputs/appended_rank_mort_3.csv');
      table_mort_means = readtable('~/iec/mortality/int/matlab_inputs/mort_means_3.csv');
    elseif strcmp(src_data, 'ybin_ed3')
      data = readtable('~/iec/mortality/int/matlab_inputs/appended_rank_mort_ed3.csv');
      table_mort_means = readtable('~/iec/mortality/int/matlab_inputs/mort_means_3.csv');
    else    %% implies strcmp(src_data, 'main')
      data = readtable('~/iec/mortality/int/matlab_inputs/appended_rank_mort.csv');
      table_mort_means = readtable('~/iec/mortality/int/matlab_inputs/mort_means.csv');
    end
  end

  %% set constant parameters
  race_names = {'white', 'black', 'hispanic', 'other', 'all'};

  %% calculate target_cut_name_list
  for row = 1:size(target_cut_list, 1)
    target_cut_name_list{row} = '';
    for col = 1:(size(target_cut_list, 2) - 2)
      target_cut_name_list{row} = strcat(target_cut_name_list{row}, '-', int2str(target_cut_list(row, col + 1)));
    end

    %% remove initial dash
    target_cut_name_list{row} = target_cut_name_list{row}(2:end);
  end

  %% write output file header
  insert_line(output_fn, 'target_name,spec,f2,cause,age,sex,race,year,edclass,ranktype,mu_s,mu_t', 'mu_lb,mu_ub');
  %% note base_year === target_cut_name

  %% calculate number of requests
  num_requests = length(age_list) * length(rank_list) * length(f2_perc_list) * length(type_list) * length(sex_list) * ...
                 length(race_list) * size(target_cut_list, 1) * length(year_list) * length(ed_list) * length(spec_list);
  fprintf('Number of requests: %d\n', num_requests);

  %% set initial timer and completion counter
  num_complete = 0;

  %% loop over all ages
  for age = age_list
    %% loop over rank types
    for r = 1:length(rank_list)
      rank_type = rank_list{r};
      
      %% loop over f2s, death types, sex
      for f2_perc = f2_perc_list
        for type = type_list
          mort_type = strcat(type, 'mortrate');
          
          for sex = sex_list
            
            %% loop over race
            for race = race_list
              race_name = race_names{race};
              
              %% loop over target cut list
              for target = 1:size(target_cut_list, 1)
                target_cuts = target_cut_list(target, :);
                target_name = target_cut_name_list{target};

                %% loop over all years
                for year = year_list
                  
                  %% set f2 limit based on average mortality for this race-sex-age-year-type
                  index = (table_mort_means.race == race) & (table_mort_means.sex == sex) & (table_mort_means.age == age) & (table_mort_means.year == year) & (strcmp(table_mort_means.cause, type));
                  assert(sum(index) == 1);
                  mean_mort = table_mort_means{index, 'mort'};
                  f2 = mean_mort * f2_perc;

                  %% get table index for this group's mortality moments
                  index = (data.sex == sex) & (data.race == race) & (data.year == year) & (data.age == age);

                  %% if no data for this entry, skip it
                  if sum(index) < length(ed_list)
                    error('Got somewhere unexpected.\n');
                    num_complete = num_complete + length(ed_list);
                    continue
                  end
                  if sum(index) < length(ed_list)
                    sum(index)
                    error(sprintf('More than %d rows in moments file.\n', length(ed_list)))
                  end

                  %% loop over three or four ed bins
                  for ed = ed_list
                    
                    %% define mu bounds for this ed bin. Shift mu_s by 1 b/c discrete -- 
                    %% so cuts at 10, 45 give mu_s, mu_t = 11, 45
                    mu_s = target_cuts(ed) + 1;
                    mu_t = target_cuts(ed + 1);

                    %% get actual cuts from the current group
                    %% these depend on the rank type
                    if strcmp(rank_type, 'sex')
                      cuts = round(data.cum_ed_rank_sex(index)' * 100);
                    elseif strcmp(rank_type, 'race_sex')
                      cuts = round(data.cum_ed_rank_race_sex(index)' * 100);
                    end

                    %% transform data from mortality rates to survival rates -- so it is monotonic positive
                    vals = 100000 - data.(mort_type)(index)';

                    %% loop over specs
                    for s = 1:length(spec_list)
                      tic
                      spec = spec_list{s};

                      %% set key
                      key = sprintf('%s,%s,%6.3f,%s,%d,%d,%d,%d,%d,%s,%d,%d', target_name, spec, f2_perc, type, age, sex, race, ...
                                    year, ed, rank_type, mu_s, mu_t);

                      %% if key already in file, skip it unless recalc is on
                      if recalc_if_exist | (key_exists(output_fn, key) == 0)

                        %% calculate this mu under each spec
                        mu = bound_mu('', cuts, vals, mu_s, mu_t, f2, spec);
                        
                        %% insert result into output file
                        val = sprintf('%1.2f,%1.2f', mu(1), mu(2));
                        insert_line(output_fn, key, val);
                        
                        %% report progress
                        mu_time = toc;
                        num_complete = num_complete + 1;
                        time_left = (num_requests - num_complete) * (mu_time) / 3600;
                        fprintf('Wrote %s: %5.0fs (%d/%d). ETA: %5.1f hours.\n', key, mu_time, num_complete, num_requests, ...
                                time_left);
                      else
                        fprintf('Skipping %s.\n', key);
                        
                        %% adjust timer so we don't get confused
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

