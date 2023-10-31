% load the module data for 120 reps on R = 5, earlyStop = 60
% if it is of the full length, we need to set earlyStop = 100 with
% moduleResultfull.mat
clear; close all;
epochEarlystop = 100;

for i = 1:120
    i
    folderName_R_5_rep_120_diff_data{i} = sprintf('r_5_rep_120_diff_data/%d',i);
    dataFile_R_5_rep_120_diff_data{i} = load(sprintf('data/%s/moduleResultFull.mat',folderName_R_5_rep_120_diff_data{i}));
end


%%
epochEarlystop = 100;
