clear 
cd  ~/iecmerge/paul/mobility/

p_skip = 1 
% preamble 
ranks = {'all' 'sex' 'race_sex'}
ranks = {'sex'}
sex = [2] 
races = {'white' 'black' 'hisp' 'other'}
races = {'all'}
ages = [50] 
f2s = [1 2 5 10 20 50 100] 
deathtypes = {'t' 'd'}
cohorts = {'1992' '2015'} 
edtypes = {'_3bin'} 
% plug mus into an array 
functions = {} 

% plug mus into an array 
functions = {} 
n = 2 
last  = 100 / n
for p = 1:last
    pn = n * p
    p_minus_n = n*p - (n - 1) 
    functions{p} = @(x) mean(x(p_minus_n:pn));
end

for race = 1:length(races)
    for year = 1:length(cohorts) 
        for deathtype = 1:length(deathtypes) 
            for s = 1:length(sex) 
                for age = 1:length(ages)
                    for rank = 1:length(ranks)
                        for fc = 1:length(f2s) 
                            for ed = 1:length(edtypes)
                                tic 
                               f2limit = f2s(fc) 
                               f2suffix = num2str(f2limit) 


                               moments_fn = sprintf('~/iec1/mortality/moments/%s/%s_%d_%d_%s_%ssurvrate%s.csv', cohorts{year},races{race}, sex(s),ages(age),ranks{rank},deathtypes{deathtype},edtypes{ed}) 
                               bounds_fn = sprintf(['~/iec1/mortality/full_cef_bounds/' ...
                                                   'cefmu%d_%s_%s_%d_%d_%s_%s_%ssurvrate%s.csv'], n, cohorts{year},races{race}, sex(s),ages(age),ranks{rank},f2suffix,deathtypes{deathtype},edtypes{ed}) 

                               pmat = zeros(0,2) 

                               for p = 1:last 
                                   pmat(p,:) = bound_generic_mort_fun(moments_fn, f2s(fc), functions{p})
                               end 

                               fprintf('Writing output file %s...\n\n\n', bounds_fn)                     
                               f = fopen(bounds_fn, 'w');                                                

                               % write header line                                                       
                               fprintf(f, 'f2,p,p_min,p_max\n');                                 

                               toc 

                               for p = 1:last                                                              
                                 fprintf(f, '%10.8f,%d,%5.4f,%5.4f\n', f2limit, p, pmat(p,1), pmat(p,2)); 
                               end       

                               fclose(f) 
                            end 
                        end
                    end
                end    
             end
        end
    end
end 


