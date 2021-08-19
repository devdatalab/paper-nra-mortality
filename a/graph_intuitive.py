import os, sys, re
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.patches as patches
from textwrap import TextWrapper
import matplotlib.pyplot as plt

# hardcode output path
output_path = os.path.expanduser('~/secc/frozen_data/mortality/repl/out')

#########################################################
# set globals.
# -------------
# statistics are listed at the top of plot_mort_cef.do
#
# moments (tmortrate levels, women 50-54, 2016--2018):
tmorts = [np.nan, 800, 535, 318, 168]
# 
# 2016-18 boundaries and midpoints:
boundaries = [0, 8, 37,   66, 100]
midpoints  = [np.nan, 4, 22.5, 46, 84.5]
# note the 4th midpoint is actually much higher, but we shift it left
#      so that it fits on the graph.
#
# bounds:
mu_0_10  = [747, 800]
mu_0_8   = [800, 800]
mu_8_10  = [535, 800]
mu_8_37  = [535, 535]
mu_10_37 = [515, 535]
mu_30_37 = [318, 535]
mu_37_40 = [318, 535]
mu_10_40 = [495, 535]

# graphout
def graphout(filename):
    global output_path
    dest_path = os.path.join(output_path, filename + '.png')
    plt.savefig(dest_path, bbox_inches = 'tight')
    plt.close()
    print(f'See graph at {dest_path}')

# return a winsorized value
def winsorize(x, x_min, x_max):
    if x < x_min: return x_min
    if x > x_max: return x_max
    return x

reg_dict = {
    'a and b':  r'$a$ and $b$',
    'muab':  r'$\\mu_a^b$',
    'mu08':  r'$\\mu_0^8$',
    'mu810':  r'$\\mu_8^{10}$',
    'mu010': r'$\\mu_0^{10}$',
    'mu837': r'$\\mu_8^{37}$',
    'mu3766': r'$\\mu_{37}^{66}$',
    'mu1037': r'$\\mu_{10}^{37}$',
    'mu3740': r'$\\mu_{37}^{40}$',
    'mu1040': r'$\\mu_{10}^{40}$'
}
    
# a function to return wrapped and latexed text
def wrap(text, width):

    # create a textwrapper object with the right width
    wrapper = TextWrapper(width = width)

    # wrap the text and convert to a newline-separated list
    word_list = '\n'.join(wrapper.wrap(text))

    # run the latex conversion
    for regex, repl in reg_dict.items():
        word_list = re.sub(regex, repl, word_list)

    return word_list

# function to set master graph parameters
def set_mpl_defaults():
    
    # set some master parameters to make the font look good
    mpl.rcParams['mathtext.fontset'] = 'custom'
    mpl.rcParams['mathtext.rm'] = 'Bitstream Vera Sans'
    mpl.rcParams['mathtext.it'] = 'Bitstream Vera Sans:italic' 
    mpl.rcParams['mathtext.bf'] = 'Bitstream Vera Sans:bold'
    mpl.rc('font', **{'family': 'serif', 'serif': ['Computer Modern']})
    mpl.rc('text', usetex=True)
    mpl.rcParams['figure.dpi'] = 200
    
    # axis text size
    # mpl.rc('axes', titlesize=12)     # fontsize of the axes title
    # plt.rc('axes', labelsize=10)    # fontsize of the x and y labels

# prepare a standard set of axes
def prep_axes(ax):
    
    # set tick marks
    ax.tick_params(axis ="y", left=False)
    ax.tick_params(axis ="x", bottom=False)
    
    # add a grid
    ax.grid(True)
    ax.yaxis.grid(color='gray', linewidth=0.25, linestyle="--")
    ax.xaxis.grid(color='gray', linewidth=0.25, linestyle="--")
    ax.grid(zorder=0)

    # turn off border box
    for i in ["right", "left", "top", "bottom"]:
        ax.spines[i].set_visible(False)
        
    
# define a helper function we'll use to define the width of a text box.
def get_width(lb, rb, min_width=20):
    """
    lb: the left bound of the bin
    rb: the right bound of the bin
    min_width: the minimum width allowed for the box
    """
    # define the width as half the distance of the bin
    width = (rb - lb) / 2
    
    # if the width is smaller than the minimum allowed, set to the minimum
    if (width < min_width):
        width = min_width
        
    return width

# create a textbox
def textbox(ax, x1, y1, s, edgecolor='black', facecolor='white', pad=3, **kwargs):

    # draw the textbox with default settings
    t = ax.text(x1, y1, s,
                horizontalalignment='center', verticalalignment='center',
                rotation=0, fontsize=12, bbox=dict(facecolor=facecolor, edgecolor=edgecolor, pad=pad), **kwargs)
    return t

# plot a 2-headed arrow but scale it to the graph's xlim and ylim
def arrow2(ax, x1, y1, x2, y2, arrowstyle='<->', **kwargs):

    # get axis limits
    (xlim1, xlim2) = ax.get_xlim()
    (ylim1, ylim2) = ax.get_ylim()

    # if both x1 and x2 are outside the limits (or same for y), then return
    if (not xlim1 < x1 < xlim2) and (not xlim1 < x2 < xlim2): return
    if (not ylim1 < y1 < ylim2) and (not ylim1 < y2 < ylim2): return
    
    # create a placeholder for the winsorized values
    xc = []
    yc = []

    # winsorize x and y values to axis limits and cut arrows
    for x in [x1, x2]:
        if x < xlim1: x, arrowstyle = xlim1, '->'
        if x > xlim2: x, arrowstyle = xlim2, '<-'
        xc.append(x)
    for y in [y1, y2]:
        if y < ylim1: y, arrowstyle = ylim1, '->'
        if y > ylim2: y, arrowstyle = ylim2, '<-'
        yc.append(y)

    # draw the 2-sided arrow
    plt.annotate(s='', xy = (xc[1], yc[1]),  # arrow end point
                 xytext=(xc[0], yc[0]), # arrow start point
                 arrowprops=dict(arrowstyle=arrowstyle, **kwargs))

########
# MAIN #
########

# use default matplotlib settings
set_mpl_defaults()

# --------- #
# Plot Data #
# --------- #

# draw the moments
def draw_moments():
    
    # create the figure and set up axes
    f, ax = plt.subplots(figsize = [10, 6])
    prep_axes(ax)
    
    # set axes limits - making these 1 unit longer than desired range 
    # to ensure the limit lines are plotted by the grid
    ax.set_ylim([-1, 1201], auto=False)
    ax.set_xlim([-1, 50], auto=False)
    
    # axes labels
    ax.set_xlabel("Education Rank", fontsize=14)
    ax.set_ylabel("Mortality Rate (Deaths / 100,000)", fontsize=14)

    # create sample data -- these are all women age 50, 2016--2018
    df = pd.DataFrame(columns=["bin", "binmid"])
    df["bin"] = boundaries
    df["binmid"] = midpoints
    df["mort"] = tmorts
    
    # cycle through the dataframe to plot the bounds and midpoints
    for i in df.index:
    
        # skip plotting the 0 line
        if i == 0:
            continue
            
        # label the point 40 points above it, if we are in range
        if df.loc[i, 'binmid'] < 70:
            textbox(ax, df.loc[i, "binmid"], df.loc[i, "mort"] + 50, '%1.0f' % (df.loc[i, "mort"]), edgecolor='w')
    
        # plot the mean mortality in each bin
        ax.scatter(df.loc[i, "binmid"], df.loc[i, "mort"], color="k")
        
        # plot the bound of the bin as a line
        ax.axvline(df.loc[i, "bin"], color="k", linewidth=1)
    
        # draw arrows around bin means to show they are means
        arrow2(ax, df.bin[i - 1], df.mort[i], df.bin[i], df.mort[i])

    # draw an xline at zero
    ax.axvline(0, color="k", linewidth=1)
    
    return f, ax


###########################
# PANEL A
f, ax = draw_moments()

# plot the annotations for mu08 and mu837
ann1 = wrap('muab is the mean mortality between percentiles a and b. mu08 and mu837 are known, since they line up with bins in the data.', 48)
textbox(ax, 10, 1100, ann1, pad = 6)
arrow2(ax, 8,  1005, 4,    870, arrowstyle = '->')
arrow2(ax, 12, 1005, 21.5, 640, arrowstyle = '->')

# draw the <---?---> and vertical boundaries for mu-0-10
arrow2(ax, 0, 675, 10, 675)
textbox(ax, 5, 675, '?')
plt.plot([0, 0], [600, 800], color='k', linestyle=':')
plt.plot([10, 10], [600, 800], color='k', linestyle=':')

# annotate mu010
ann2 = wrap('mu010 is a weighted mean of mu08 and mu810.', 15)
textbox(ax, 4,  200, ann2, pad = 6)
arrow2(ax, 4, 315, 5, 625, arrowstyle = '->')

## draw the bounds for mu810
r = patches.Rectangle((8, mu_8_10[0]), 2, mu_8_10[1] - mu_8_10[0], facecolor='#66cc00', edgecolor='g', linewidth=2, zorder=0)
ax.add_patch(r)

# annotate these bounds
ann2 = wrap('mu810 must be between mu08 and mu837 by monotonicity.', 15)
textbox(ax, 12, 200, ann2, pad = 6, edgecolor='g')
arrow2(ax, 11, 315, 9, 630, arrowstyle = '->', color='g')
graphout('intuit_a')

## ---------------------------- cell:  ---------------------------- ##
####################################
# PANEL B -- explain the bounds
f, ax = draw_moments()

# draw the bounds
r = patches.Rectangle((0, mu_0_10[0]), 10, mu_0_10[1] - mu_0_10[0], facecolor='#66cc00', edgecolor='g', linewidth=2, zorder=0)
ax.add_patch(r)

# annotate the bounds
ann1 = wrap(f'mu010 is tightly bounded between {mu_0_10[0]} and {mu_0_10[1]}.', 15)
textbox(ax, 11, 1100, ann1, pad = 6, edgecolor='g')
arrow2(ax, 11,  992, 9, 805, arrowstyle = '->', color='g')

# annotate the lower bound
ann2 = '$747=800\\cdot\\frac{8}{10}+535\\cdot\\frac{2}{10}$'
textbox(ax, 21, 800, ann2, pad = 6, edgecolor='g')
arrow2(ax, 15,  800, 10, 747, arrowstyle = '->', color='g')

graphout('intuit_b')

## ---------------------------- cell:  ---------------------------- ##

##############################
# PANEL C --- mu-10-40
f, ax = draw_moments()

# draw the <---?---> for mu-10-40
arrow2(ax, 10, 450, 40, 450)
textbox(ax, 25, 450, '?')
plt.plot([40, 40], [310, 520], color='k', linestyle=':')
plt.plot([10, 10], [310, 520], color='k', linestyle=':')

# annotate mu1040
ann2 = wrap('mu1040 is a weighted mean of mu1037 and mu3740', 25)
textbox(ax, 25,  100, ann2, pad = 6)
arrow2(ax, 25, 195, 25, 400, arrowstyle = '->')

## draw the bounds for mu1037 and mu3740
r = patches.Rectangle((10, mu_10_37[0]), 27, mu_10_37[1] - mu_10_37[0], facecolor='#66cc00', edgecolor='g', linewidth=2, zorder=0)
ax.add_patch(r)
r = patches.Rectangle((37, mu_37_40[0]), 3, mu_37_40[1] - mu_37_40[0], facecolor='#66cc00', edgecolor='g', linewidth=2, zorder=0)
ax.add_patch(r)

## annotate mu3740
ann = wrap('mu3740 must be between mu837 and mu3766 by monotonicity', 25)
textbox(ax, 45, 940, ann, pad = 6, edgecolor = 'g')
arrow2(ax, 45, 850, 40, 550, arrowstyle = '->', color='g')

## annotate mu1037
ann = wrap('By monotonicity, mu1037 cannot be above mu837 but cannot be so low that mu810 needs to be above mu08 (see note below)', 30)
textbox(ax, 27, 900, ann, pad = 6, edgecolor = 'g')
arrow2(ax, 27, 785, 30, 550, arrowstyle = '->', color='g')

# annotate the lower bound
mpl.rc('text', usetex=True) #use latex for text
mpl.rcParams['text.latex.preamble']=[r"\usepackage{color}"]
ann2 = '$535=800\\cdot\\frac{10-8}{37-8}+\\textcolor{green}{515} \\cdot\\frac{37-10}{37-8}$'
textbox(ax, 6, 200, ann2, pad = 6, edgecolor='g')
arrow2(ax, 9, 220, 9.9, 515, arrowstyle = '->', color='g')

graphout('intuit_c')

## ---------------------------- cell:  ---------------------------- ##



################################################
# PANEL D -- explain the second set of bounds
f, ax = draw_moments()

# draw the bounds on mu-10-40
r = patches.Rectangle((10, mu_10_40[0]), 30, mu_10_40[1] - mu_10_40[0], facecolor='#66cc00', edgecolor='g', linewidth=2, zorder=0)
ax.add_patch(r)

# annotate the bounds
ann1 = wrap('mu1040 is tightly bounded between 495 and 535.', 20)
textbox(ax, 30, 200, ann1, pad = 6)
arrow2(ax, 30, 300, 30, 481, arrowstyle = '->', color='g')

# annotate the lower bound
ann2 = '$495=\\frac{515(27)+318(3)}{30}$'
textbox(ax, 6, 300, ann2, pad = 6, edgecolor='g')
arrow2(ax, 2.5, 323, 9.9, 495, arrowstyle = '->', color='g')

graphout('intuit_d')
