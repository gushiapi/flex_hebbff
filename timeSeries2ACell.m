function [ amatcell ] = timeSeries2ACell(timeseries, winSize)
% time series is NxTxp matrix
% amatcell is px1 cell of NxN matrix
[N,T,p] = size(timeseries);
nWin = floor(T/winSize);
for i = 1:p
    amatcell{i} = cell(nWin,1);
    aslice = squeeze(timeseries(:,:,i)');
    for j = 1:nWin
        amatcell{i}{j} = corr(aslice(winSize*(j-1)+1:winSize*j,:));
    end
end
end

