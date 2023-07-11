function [ H ] = entropy_multi_gauss( Cov, D )
%ENTROPY_MULTI_GAUSS 
H = 0.5 * logdet(Cov,'chol') + 0.5*D*(1+log(2*pi));
end

