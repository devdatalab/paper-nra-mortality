%%%%%%%%%%%%%%%%%%
% loop and plot  %
%%%%%%%%%%%%%%%%%%
cd ~/iecmerge/paul/mobility/
moment = '~/iec1/mortality/moments/2015/all_2_50_sex_tsurvrate_3bin.csv'

% set folder 
folder = '~/iec1/mortality/full_cef_bounds/'

f2s = [999]
f2s = [0 1 2 5 10 20 50 100 500 999]  

% set years 
years = {'2015'}

% set simulation - empty if not a simulation

for num = 1:length(f2s) 
    for year = 1:length(years)

        %%%%%%%%%%%%%%%%%%%%%%%%%
        % % set up the mu type --- this is the number of integers rounded together 
        % in the numeric calc. for analytical, set as 1. for numeric, it is currently set as 2 --- i.e., we compute
        % mu_0-2, mu 2-4, etc. 
        %%%%%%%%%%%%%%%%%%%%%%%%%
        if isequal(f2s(num),999) == 1 
            mutype = 1 
        elseif  isequal(f2s(num),0) == 1
            mutype = 1 
        else 
            mutype = 2  
        end

        %%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%
        % that allows  you to call the graph %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        cef = sprintf('%s/cefmu%d_%s_all_2_50_sex_%d_tsurvrate_3bin.csv', folder,mutype,years{year},f2s(num)) 
        graph_fn = sprintf('cef_%s_all_2_50_sex_%d_tmortrate', years{year},f2s(num)) 

        if isequal(f2s(num), 999) == 0 
            expand = 1
        else 
            expand = 0 
        end 
        %%%%%%%%%%%%%
        %%%%% plot the cef using the dedicated function as long as it's not the line 
        %%%%%%%%%
        if f2s(num) > 0
            cef_graph_fn(cef,moment,graph_fn,expand)

            %%%%%% if it's the line, plot the weighted rank %%%%%%%%
        elseif f2s(num) == 0 
            %%%%%% plot the weighted rank %%%%%% 
            clf 
            hold on 
            moments = csvread(moment,1) 
            scatter(moments(:,1),100000-moments(:,2),'filled','k')

            % load in the data 
            data = csvread(moment,1) 

            % plot and get best fit line 
            p = polyfit(data(:,1),100000-data(:,2),1) ;         
            x1 = linspace(0,100) 
            y1 = polyval(p,x1)

            line(x1,y1,'Color','k')

            % print 
            axis([0 100 0 2000]) 
            ylim([0 2000]) 
            xlabel('Education Rank')
            ylabel('Deaths/100,000') 
            hold off 

            set(gca,'fontsize',25) 

            write_pdf(graph_fn) 
        end

    end

end 

command='cp ~/public_html/png/cef_*_all_2_50_sex_*_tmortrate.png ~/iec1/output/mortality/'
status = dos(command) 

