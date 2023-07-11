function  generateProcessedModularData( trainFolder )

% trainFolder = 'trainRecord_anti_force/trainRecord_R_4_anti_force';
runDataPreparation;
%%% module structure of a and h?

% case 1: analysis cross multiple epochs
winSize = 50;
nWin = T/winSize;
AmatCellSlidingWin = timeSeries2ACell(a,winSize);

epochEarlystop = 101;

gplus = 1.02;
gminus = 1.0;
omega = 1.0;

modularity = zeros(epochEarlystop,1);
nCommunity = zeros(epochEarlystop,1);
meanCommunitySize = zeros(epochEarlystop,1);
stationarity = zeros(epochEarlystop,1);
S = cell(epochEarlystop,1);
flexibility = zeros(epochEarlystop,1);
allegianceMatrix = zeros(N,N,epochEarlystop);

parfor (i = 1:epochEarlystop,4)
    [modularity(i), nCommunity(i),meanCommunitySize(i),stationarity(i),S{i},flexibility(i)] = multiSliceCommunityStats(AmatCellSlidingWin{i},gplus,gminus,omega);
end
for i = 1:epochEarlystop
    for s = 1:N
        for t = 1:N
            allegianceMatrix(s,t,i) = allegianceMatrix(s,t,i) + nanmean(S{i}(s,:)==S{i}(t,:));
        end
    end
end
fileSaveName = sprintf('data/%s/moduleResultFull.mat',trainFolder);
save(fileSaveName,'train_data','train_label','valid_data','valid_label','modularity','nCommunity','meanCommunitySize','stationarity','S','flexibility','winSize','nWin','epochEarlystop','gplus','gminus','omega',...
    'acc','acc_np','acc_tp','b1','b2','eta','a','h','w1','w2','-v7.3');
end

