function [ pca ] = PCAtransform(mean, V, x)
xnew = x - mean;
pca = V'*xnew';
pca = pca';
end