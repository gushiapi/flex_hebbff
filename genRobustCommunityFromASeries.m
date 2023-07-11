function [c_partition,allegianceMatrix,modularity] = genRobustCommunityFromASeries(A, gplus, gminus)
% for consensus_comm_wei
% C is a pxn matrix of community assignments where p is the number of optimizations
% that have been performed. n is the number of nodes in the system. C gives the real partitions. 
n = size(A{1},1);
p = length(A);
partitions = zeros(p,n);
for i = 1:p
    Acell{1} = A{i};
    B{i} = multiSliceA2B(Acell,gplus,gminus,0,'orderedSlice');
    partitions(i,:) = genlouvain(B{i},10000,0);
end
allegianceMatrix = zeros(n,n);
for i = 1:p
    for j = 1:n
        for k = 1:n
            allegianceMatrix(j,k) = allegianceMatrix(j,k) + (partitions(i,j)==partitions(i,k))/p;
        end
    end
end
[c_partition,modularity,~] = multislice_static_unsigned(allegianceMatrix,1.0);
end