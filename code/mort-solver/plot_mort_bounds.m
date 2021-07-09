% takes a string bounds-fn, or a 100x2 vector of bounds
function plot_mort_bounds(moment_fn, bounds_fn, graph_fn, bounds)

% load raw data 
raw_data = csvread(moment_fn, 1, 0);

% get bin boundaries 
[cuts] = read_bins(moment_fn);

% load bounds from data file
if length(bounds_fn) > 0
    bounds = csvread(bounds_fn, 1, 2);
end

% plot CEF bounds
clf
hold on

% TEMPORARY: flip from survival to mortality
raw_data(:, 2) = 100000 - raw_data(:, 2);
a = 100000 - bounds(1:100, 1);
b = 100000 - bounds(1:100, 2);
bounds(1:100, 2) = a;
bounds(1:100, 1) = b;
bounds

% note subtracting 0.5 since bound(1) -> mean value in [0,1] interval
plot((1:100)' - 0.5, bounds(1:100, 1),'Color', 'k','DisplayName','Implied bounds')
plot((1:100)' - 0.5, bounds(1:100, 2),'Color', 'k','DisplayName','Implied bounds')

% plot bin means
scatter(raw_data(:,1), raw_data(:,2), 'filled', 'k')

% plot bin boundaries
for i = 1:length(cuts)
    plot([cuts(i) cuts(i)], [0 2000], 'r')
end

% axis label
xlabel('Education Rank') 
ylabel('Deaths per 100,000')

% set axis limits
xlim([0 100]);
ylim([0 2000]);

% grid lines
grid on
grid minor

% write graph
write_pdf(graph_fn);

hold off 
