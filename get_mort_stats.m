cd ~/iecmerge/paul/mobility/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
for rank = 1:length(ranks)
    for f2 = 1:length(f2s) 
        for age = 1:length(ages)
            for deathtype = 1:length(deathtypes) 
                for race = 1:length(races)
                    for s = 1:length(sex) 

                        % write to a csv - we write 5 different deciles 
                        output_csv_mu_0_10 = sprintf('%s/mu_0_10_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_10_20 = sprintf('%s/mu_10_20_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_20_30 = sprintf('%s/mu_20_30_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_30_40 = sprintf('%s/mu_30_40_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_40_50 = sprintf('%s/mu_40_50_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_50_60 = sprintf('%s/mu_50_60_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_60_70 = sprintf('%s/mu_60_70_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_70_80 = sprintf('%s/mu_70_80_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_80_90 = sprintf('%s/mu_80_90_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_90_100 = sprintf('%s/mu_90_100_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 

                        output_csv_mu_0_20 = sprintf('%s/mu_0_20_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_20_40 = sprintf('%s/mu_20_40_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_40_60 = sprintf('%s/mu_40_60_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_60_80 = sprintf('%s/mu_60_80_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_80_100 = sprintf('%s/mu_80_100_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 

                        output_csv_mu_0_25 = sprintf('%s/mu_0_25_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_25_50 = sprintf('%s/mu_25_50_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_50_75 = sprintf('%s/mu_50_75_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_75_100 = sprintf('%s/mu_75_100_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 

                        output_csv_mu_10_45 = sprintf('%s/mu_10_45_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_45_70 = sprintf('%s/mu_45_70_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 
                        output_csv_mu_70_100 = sprintf('%s/mu_70_100_%s_%d_%d_%s_%d_%srate.csv', output_folder, races{race},sex(s),ages(age),ranks{rank},f2s(f2),deathtypes{deathtype}) ; 

                        % open all output files
                        f_mu_0_10 = fopen(output_csv_mu_0_10, 'w') ;
                        f_mu_10_20 = fopen(output_csv_mu_10_20, 'w') ;
                        f_mu_20_30 = fopen(output_csv_mu_20_30, 'w') ;
                        f_mu_30_40 = fopen(output_csv_mu_30_40, 'w') ;
                        f_mu_40_50 = fopen(output_csv_mu_40_50, 'w') ;
                        f_mu_50_60 = fopen(output_csv_mu_50_60, 'w') ;
                        f_mu_60_70 = fopen(output_csv_mu_60_70, 'w') ;
                        f_mu_70_80 = fopen(output_csv_mu_70_80, 'w') ;
                        f_mu_80_90 = fopen(output_csv_mu_80_90, 'w') ;
                        f_mu_90_100 = fopen(output_csv_mu_90_100, 'w') ;

                        f_mu_0_20 = fopen(output_csv_mu_0_20, 'w') ;
                        f_mu_20_40 = fopen(output_csv_mu_20_40, 'w') ;
                        f_mu_40_60 = fopen(output_csv_mu_40_60, 'w') ;
                        f_mu_60_80 = fopen(output_csv_mu_60_80, 'w') ;
                        f_mu_80_100 = fopen(output_csv_mu_80_100, 'w') ;

                        f_mu_0_25 = fopen(output_csv_mu_0_25, 'w') ;
                        f_mu_25_50 = fopen(output_csv_mu_25_50, 'w') ;
                        f_mu_50_75 = fopen(output_csv_mu_50_75, 'w') ;
                        f_mu_75_100 = fopen(output_csv_mu_75_100, 'w') ;

                        % open custom output files 
                        f_mu_10_45 = fopen(output_csv_mu_10_45, 'w') ;
                        f_mu_45_70 = fopen(output_csv_mu_45_70, 'w') ;
                        f_mu_70_100 = fopen(output_csv_mu_70_100, 'w') ;

                        % loop over all of these deciles quartiles and quintiles 
                        names_of_outputs_custom = {f_mu_0_10 , f_mu_10_45,  f_mu_45_70, f_mu_70_100}
                        names_of_outputs_deciles = {f_mu_0_10 f_mu_10_20 f_mu_20_30 f_mu_30_40 f_mu_40_50 f_mu_50_60 f_mu_60_70 f_mu_70_80 f_mu_80_90 ...
                                            f_mu_90_100 }
                        names_of_outputs_quartiles = {f_mu_0_25 f_mu_25_50 f_mu_50_75 f_mu_75_100 }
                        names_of_outputs_quintiles = {f_mu_0_20 ... 
                                           f_mu_20_40 f_mu_40_60 f_mu_60_80 f_mu_80_100 } 

                        functions_custom = {fun_mu_0_10 fun_mu_10_45 fun_mu_45_70 fun_mu_70_100} 
                        functions_deciles = {fun_mu_0_10 fun_mu_10_20 fun_mu_20_30 fun_mu_30_40 fun_mu_40_50 fun_mu_50_60 fun_mu_60_70 fun_mu_70_80 fun_mu_80_90 ...
                                            fun_mu_90_100 }
                        functions_quartiles = {fun_mu_0_25 fun_mu_25_50 fun_mu_50_75 fun_mu_75_100 }
                        functions_quintiles = {fun_mu_0_20 ... 
                                           fun_mu_20_40 fun_mu_40_60 fun_mu_60_80 fun_mu_80_100 } 

                        names_of_outputs_list = {names_of_outputs_custom names_of_outputs_deciles ...
                                            names_of_outputs_quartiles names_of_outputs_quintiles} 

                        functions_list = {functions_custom functions_deciles ...
                                            functions_quartiles functions_quintiles} 
                        % horizontally concatenate the outputs you want 
                        names_of_outputs = { } 
                        functions = { } 

                        for i = 1:length(mus)                                     
                            name_append = names_of_outputs_list{1,mus(i)}  
                            names_of_outputs = horzcat(names_of_outputs, name_append )
                            function_append = functions_list{1,mus(i)} 
                            functions = horzcat(functions, function_append )
                        end 

                        for output = 1:length(names_of_outputs) 

                            % write headers
                            fprintf(names_of_outputs{output}, 'f2_limit,cohort,lb,ub\n') ;
                        end 

                        for output = 1:length(names_of_outputs) 

                            % reset matrix 
                            mu = zeros(0,2) 
                            % loop over years 

                            toc 
                            for year = 1:length(cohorts) 
                                input_csv = sprintf('%s/%s/%s_%d_%d_%s_%ssurvrate.csv', moment_folder,cohorts{year},races{race},sex(s), ...
                                                ages(age), ranks{rank}, deathtypes{deathtype} )               

                                %% put into a matrix, rows are years %% 
                                mu(year, :) = bound_generic_mort_fun(input_csv, f2s(f2), functions{1,output} ) 

                                % write year 
                                fprintf(names_of_outputs{output}, '%6.2f, %s, %10.5f, %10.5f\n', f2s(f2), cohorts{year}, mu(year, 1), mu(year, 2));
                            end 

                            % close loop over what you write 
                            fclose(names_of_outputs{output});

                        end 

                    end 
                end
            end
        end   
    end
end 




