%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GOAL: CALCULATE ALL MOBILITY STATS OF INTEREST, FOR ALL GROUPS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ~/iecmerge/paul/mobility/
clear all 
% measures: gradient, p25, mu_40_50
tic 
moment_folder = '~/iec1/mortality/simulations/us/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % MOBILITY STATISTIC FUNCTIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun_mu_0_10 = @(x) mean(x(1:10));
fun_mu_10_20 = @(x) mean(x(11:20));
fun_mu_20_30 = @(x) mean(x(21:30));
fun_mu_30_40 = @(x) mean(x(31:40));
fun_mu_40_50 = @(x) mean(x(41:50));
fun_mu_50_60 = @(x) mean(x(51:60));
fun_mu_60_70 = @(x) mean(x(61:70));
fun_mu_70_80 = @(x) mean(x(71:80));
fun_mu_80_90 = @(x) mean(x(81:90));
fun_mu_90_100 = @(x) mean(x(91:100));

fun_mu_0_25 = @(x) mean(x(1:25));
fun_mu_25_50 = @(x) mean(x(26:50));
fun_mu_50_75 = @(x) mean(x(51:75));
fun_mu_75_100 = @(x) mean(x(76:100));

fun_mu_0_50 = @(x) mean(x(1:50)); 
fun_mu_0_39 = @(x) mean(x(1:39)); 
fun_mu_39_68 = @(x) mean(x(40:68)); 
fun_mu_68_100 = @(x) mean(x(69:100)); 

fun_mu_0_20 = @(x) mean(x(1:20));
fun_mu_20_40 = @(x) mean(x(21:40));
fun_mu_40_60 = @(x) mean(x(41:60));
fun_mu_60_80 = @(x) mean(x(61:80));
fun_mu_80_100 = @(x) mean(x(81:100));

fun_mu_10_45 = @(x) mean(x(11:45));
fun_mu_45_70 = @(x) mean(x(46:70));
fun_mu_70_100 = @(x) mean(x(71:100));
fun_mu_0_45 = @(x) mean(x(1:45));

fun_mu_0_64 = @(x) mean(x(1:64));
fun_mu_64_83 = @(x) mean(x(65:83));

%%%%%%%%%%%%%%%%%
% 3bin results  %
%%%%%%%%%%%%%%%%%
output_folder = '~/iec1/mortality/simulations/bounds_us/'; 
cohorts = {'2014'} 
ranks = {'sex'}  
sex = [2] 
races = {'all'}
ages = [52] 
f2s = [1 2 5 10 100 500] 

deathtypes = {'t'}  
edtypes = {'_3bin'}

% mus tells which mus to request 
% 1=custom , 2 = deciles, 3 = quartiles, 4 = quintiles, 5 = 3bin 
mus = [5 6] 
run ~/iecmerge/mortality/get_mort_stats_test.m



