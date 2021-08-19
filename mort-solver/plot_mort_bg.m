% sets the background for the mobility plot -- vertical bin boundaries and moments
function plot_mort_bg(fn, cuts, values)
    hold off

    % calculate the mean value in each cut
    c(1) = cuts(1) / 2;
    for i = 2:length(cuts)
        c(i) = cuts(i-1) + (cuts(i) - cuts(i-1)) / 2;
    end

    % plot the original data
    scatter(c, values, [], 'filled','k');
    hold on

    % plot bin dividers
    for i = 1:length(cuts)
        plot([cuts(i) cuts(i)], [0 2000], 'k')
    end

    % set x axis length
    xlim([1 100])
    ylim([0 2000])

    % label axes
    xlabel('Education Rank') 
    ylabel('Deaths per 100,000')

    % write PNG and PDF files
    write_pdf(fn);
