function [ mean ] = compMeanVec(X)
[M, N] = size(X);% M = 165, N = 4800 in this case
mean = zeros(1, N);
for i = 1 : M
    mean = mean + X(i, :)/M;
end
end