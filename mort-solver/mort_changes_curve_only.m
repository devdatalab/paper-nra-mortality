% set constant parameters
moment_folder = '~/iec1/mortality/moments';
year_list = [1992 2015];
race = 'all';
sex = 2;
age = 50;
type = 't';
bins = '';

f2 = 3;
year = 1992;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate mortality change over time for LEHS-1992 (for Figure 7)

% set up output file -- put in a header as this is source data for a graph
mu_output_fn = '/scratch/pn/mort_mus_nomon_new.csv';
f = fopen(mu_output_fn, 'w');
fprintf(f, 'year,sex,edclass,type,base_year,f2,mu_lb,mu_ub\n');
f2_list = [1 2 3 5];
type_list = 'td';

% loop over f2s
for f2 = f2_list

    for type = type_list

        % loop over all years
        for year = 1992:2015
    
            % loop over sexes
            for sex = 1:2
    
                % Calculate 0-64 for women and 0-54 for men
                if sex == 1
                    mu_top = 54;
                else
                    mu_top = 64;
                end
                    
                % set moment filename
                moment_fn = sprintf('%s/%d/%s_%d_%d_%s_%ssurvrate%s.csv', moment_folder, year, race, sex, age, 'sex', type, bins);
            
                % seed the solver at p10
                tic
                [p_bound_10, next_min_seed_nomon, next_max_seed_nomon, foom] = bound_generic_fun_nomon_seed(moment_fn, f2, @(x) x(10), 0, 0);
                seed_time = toc;
    
                % calculate mu-0-64
                tic
                [mu_bound, next_min_seed_nomon, next_max_seed_nomon, foom] = bound_generic_fun_nomon_seed(moment_fn, f2, @(x) mean(x(1:mu_top)), 0, 0);
                mu_time = toc;
                mu_bound = fliplr(100000 - mu_bound);
                
                % write it to the output file
                fprintf(f, '%d,%d,%d,%s,%d,%d,%5.2f,%5.2f\n', year, sex, 1, type, 1992, f2, mu_bound(1), mu_bound(2));
    
                % report progress
                fprintf('Wrote %d-%d-%d-%s: (%5.1f, %5.1f)\n', f2, year, sex, type, seed_time, mu_time);
            end
        end
    end
end

% close the output file
fclose(f)
