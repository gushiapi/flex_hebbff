clear; close all;
for i = 3:10
    i
    folderName_R_Diff{i} = sprintf('trainRecord_anti_force/trainRecord_R_%d_anti_force',i);
    generateProcessedModularData(folderName_R_Diff{i});
end

for i = 1:10
    i
    folderName_R_5_rep{i} = sprintf('trainRecord_R_5_anti_rep/rep%d',i);
    generateProcessedModularData(folderName_R_5_rep{i});
end

for i = 1:120
    i
    folderName_R_5_rep{i} = sprintf('r_5_rep_120_diff_data/%d',i);
    generateProcessedModularData(folderName_R_5_rep{i});
end