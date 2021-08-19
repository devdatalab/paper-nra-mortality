%% takes a string bounds-fn, or a 100x2 vector of bounds
function plot_semimon_bounds(graph_fn, bounds, cuts, vals)

  %% load raw data 
  %% raw_data = csvread(moment_fn, 1, 0);

  %% set up the graph
  clf
  hold on

  %% note subtracting 0.5 since bound(1) -> mean value in [0,1] interval
  plot((1:100)' - 0.5, bounds(1:100, 1),'Color', 'k','DisplayName','Implied bounds')
  plot((1:100)' - 0.5, bounds(1:100, 2),'Color', 'k','DisplayName','Implied bounds')

  %% plot bin means
  %% scatter(raw_data(:,1), raw_data(:,2), 'filled', 'k')

  %% plot bin boundaries
  for i = 1:length(cuts)
    plot([cuts(i) cuts(i)], [0 2000], 'r')
  end

  %% axis label
  xlabel('Education Rank') 
  ylabel('Deaths per 100,000')

  %% set axis limits
  xlim([0 100]);
  ylim([0 1400]);

  %% grid lines
  grid on
  grid minor

  %% set axis font size 
  set(gca,'FontSize',18)
  
  %% write graph
  write_pdf(graph_fn);

  hold off 
end
