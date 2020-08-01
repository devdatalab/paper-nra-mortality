year1 = '1992'
year2 = '2015'

f2s = [999 5]  

for num = 1:length(f2s) 

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
   
    % load hte two cefs 
    first_cef = sprintf('~/iec1/mortality/full_cef_bounds/cefmu%d_%s_all_2_50_sex_%d_tsurvrate_3bin.csv', mutype,year1,f2s(num)) 
    second_cef = sprintf('~/iec1/mortality/full_cef_bounds/cefmu%d_%s_all_2_50_sex_%d_tsurvrate_3bin.csv', mutype,year2,f2s(num)) 
    graph_fn = sprintf('time_trend_%s_%s_%d', year1,year2,f2s(num)) 

    % load the two moments 
    first_moments =  '~/iec1/mortality/moments/1992/all_2_50_sex_tsurvrate_3bin.csv'
    second_moments =  '~/iec1/mortality/moments/2015/all_2_50_sex_tsurvrate_3bin.csv'

    % load in data 
    first_cef_data = csvread(first_cef,1)
    first_rank = mutype*first_cef_data(:,2)-1
    first_lb = 100000-first_cef_data(:,4)
    first_ub = 100000-first_cef_data(:,3)

    second_cef_data = csvread(second_cef,1)
    second_rank = mutype*second_cef_data(:,2)-1
    second_lb = 100000-second_cef_data(:,4)
    second_ub = 100000-second_cef_data(:,3)


    % get moments
    first_moments_data = csvread(first_moments,1)
    first_scatter_rank = first_moments_data(:,1)
    first_moments = 100000-first_moments_data(:,2) 

    second_moments_data = csvread(second_moments,1)
    second_scatter_rank = second_moments_data(:,1)
    second_moments = 100000-second_moments_data(:,2) 

    clf 
    hold on 
    

    % plot first graph 
    plot(first_rank,first_lb,'--','Color','b','DisplayName','1992 Bounds')


    plot(second_rank,second_lb,'Color','k','DisplayName','2015 Bounds')
    legend('show') 
    legend boxoff

    % now plot second items, to fix the legend 
    plot(first_rank,first_ub,'--','Color','b')
    plot(second_rank,second_ub,'Color','k') 

    % get momentss
    scatter(first_scatter_rank,first_moments,'x','b','DisplayName','1992 Means')


    % plot second graph 
    scatter(second_scatter_rank,second_moments,'filled','k','DisplayName','2015 Means')



    xlabel('Education Rank')
    ylabel('Deaths/100,000')
    ylim([0 2000])
    axis([0 100 0 2000])

    set(gca,'fontsize',25) 

    write_pdf(graph_fn) 

    % calculate and report the minimum and maximum mortality change at each p
    min_change = second_lb - first_ub;
    max_change = second_ub - first_lb;
    [[1:50]' min_change max_change]

end 

% command = 'cp ~/public_html/png/time_trend_* ~/iec1/output/mortality/'
status = dos(command) 
