% Create all statistics for summary table in Bounds paper
% goal: women's mortality by constant rank education group, in 1992 and in 2015

moment_folder = '~/iec1/mortality/moments';
year_list = [1992 2015];
race = 'all';
sex = 2;
age = 50;
type = 't';
bins = '_3bin';
f2_list = [3 5];
fun_mu_f_ed1_1992 = @(x) mean(x(1:64));
fun_mu_f_ed2_1992 = @(x) mean(x(64:83));
fun_mu_f_ed3_1992 = @(x) mean(x(83:100));

% create mus and ps of interest for output table
p_list  = [10 19 25 32];

% open output file
output_fn = '/scratch/pn/mort_stats.csv';
f = fopen(output_fn, 'w');

f2_list = [3 5];
year_list = [1992 2015];

% loop over f2 constraints
for f2_index = 1:length(f2_list)
    f2 = f2_list(f2_index);

    % loop over years
    for year = year_list
        fprintf('%d,%d\n', f2, year)

        % set moment filename
        moment_fn = sprintf('%s/%d/%s_%d_%d_%s_%ssurvrate%s.csv', moment_folder, year, race, 2, age, 'sex', type, bins);
        
        % get bounds for each p of interest
        for p = p_list
            
            % define p function
            % p_fun_cmd = sprintf('fun_p = @(x) x(%d);', p);
            % eval(p_fun_cmd);

            % define mu function
            % mu_fun_cmd = sprintf('fun_mu = @(x) mean(x(1:%d));', p * 2);
            % eval(mu_fun_cmd);

            % define mu
            mu = p * 2;
            if (mu == 38) 
                mu = 39;
            end

            % get bounds on p function
            p_bound =  approach_p_bound(moment_fn, f2, p);
            mu_bound = approach_mu_bound(moment_fn, f2, mu);

            % p_bound = fliplr(100000 - bound_generic_fun(moment_fn, f2, fun_p));

            % get bounds on mu function
            % mu_bound = fliplr(100000 - bound_generic_fun(moment_fn, f2, fun_mu));

            % write results to output file
            fprintf(f, 'mu_%d_%d_%d_low,%5.1f\n',  p, year, f2, mu_bound(1));
            fprintf(f, 'mu_%d_%d_%d_high,%5.1f\n', p, year, f2, mu_bound(2));
            fprintf(f, 'p_%d_%d_%d_low,%5.1f\n',  p, year, f2, p_bound(1));
            fprintf(f, 'p_%d_%d_%d_high,%5.1f\n', p, year, f2, p_bound(2));

            % print results to screen
            fprintf('p_%d_%d_%d,%5.1f,%5.1f\n', p, year, f2, p_bound(1), p_bound(2));
            fprintf('mu_%d_%d_%d,%5.1f,%5.1f\n', p, year, f2, mu_bound(1), mu_bound(2));
        end
    end
end

% create 1992 tabular file
output_tex_fn = '/scratch/pn/table_mort_stats_1992.tex';
tpl_fn = '~/iecmerge/paul/mort-solver/tpl_p_mu_ests_1992.tex';
shell_cmd = sprintf('python ~/iecmerge/include/stata-tex/table_from_tpl.py -t %s -r %s -o %s -v', tpl_fn, output_fn, output_tex_fn);
system(shell_cmd)

% create 2015 tabular file
output_tex_fn = '/scratch/pn/table_mort_stats_2015.tex';
tpl_fn = '~/iecmerge/paul/mort-solver/tpl_p_mu_ests_2015.tex';
shell_cmd = sprintf('python ~/iecmerge/include/stata-tex/table_from_tpl.py -t %s -r %s -o %s -v', tpl_fn, output_fn, output_tex_fn);
system(shell_cmd)

