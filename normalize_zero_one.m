function [ nV ] = normalize_zero_one( V )
 nV = (V - min(V)) / ( max(V) - min(V) );
end

