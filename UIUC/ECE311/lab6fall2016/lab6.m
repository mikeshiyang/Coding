%report_item_1
x = [1, 4, -4, -3,2, 5, -6];
n = length(x);
h = [1,2,3,4,5];
C = convmtx(h, n);
y1 = x*C;
y2 = conv(x, h);
figure(1);
imagesc(C);
title('convolution matrix');
figure(2);
subplot(2, 1, 1);
stem(y1);
title('result using matrix');
subplot(2, 1, 2);
stem(y2);
title('result using conv');
%%
%report_item_3
A = [1, 4, -2; 3, 11, 5; 7, 7, 7];
[V1, D1] = eig(A*A');
[V2, D2] = eig(A'*A);
[U,S,V] = svd(A);
eigenvalue = S*S'
test1 = A*A'*U - U*eigenvalue
test2 = A'*A*V - V*eigenvalue
%%
%report_item_4
x = [1,1,4,-4,-3,2,5,-6,3,2,4,-2,5,9,-8,4];
n = length(x);
dm = dftmtx(n);
figure(1);
subplot(2,1,1);
imagesc(real(dm));
title('real part of DFT matrix');
subplot(2,1,2);
imagesc(imag(dm));
title('imaginary part of DFT matrix');
%%
%report_item_5
x = [1,1,4,-4,-3,2,5,-6,3,2,4,-2,5,9,-8,4];
n = length(x);
dm = dftmtx(n); %W matrix
y = dm*x'; %result, y = W*x'
inverse = dm'./n;%inverse matrix
X_b = inverse*y %x = W'/N * y;
A = inverse'*inverse;
%%
%report_item_6
X = loadImages('./yalefaces');
mean = compMeanVec(X);
[row, column] = size(X);
mean_reshape = reshape(mean, [60, 80]);
figure(1);
imagesc(mean_reshape);
colormap(gray);
%%
%report_item_7
X = loadImages('./yalefaces');
mean = compMeanVec(X);
[row, column] = size(X);
Xmean = zeros(row, column);
for i = 1 : row
    Xmean(i, :) = X(i, :) - mean;
end
R = Xmean'*Xmean;% covariance matrix
[U,S,V] = svd(R);%first 100 column of U (same as V) and first 
                 %100 column of S
eigenvalue = zeros(1, 100);
for i = 1 : 100
    eigenvalue(i) = S(i, i); %first 100 eigenvalue
end
%reshapre the first 4 eigenvector and the 50th and the 100th
eigen1 = reshape(U(:, 1), [60, 80]);
eigen2 = reshape(U(:, 2), [60, 80]);
eigen3 = reshape(U(:, 3), [60, 80]);
eigen4 = reshape(U(:, 4), [60, 80]);
eigen50 = reshape(U(:, 50), [60, 80]);
eigen100 = reshape(U(:, 100), [60, 80]);
figure(1);
plot(eigenvalue);
title('first 100 eigenvalue');
figure(2);
imagesc(eigen1);
colormap(gray);
title('the first eigenvector image');
figure(3);
imagesc(eigen2);
colormap(gray);
title('the second eigenvector image');
figure(4);
imagesc(eigen3);
colormap(gray);
title('the third eigenvector image');
figure(5);
imagesc(eigen4);
colormap(gray);
title('the fourth eigenvector image');
figure(6); %the 50th image
imagesc(eigen50);
colormap(gray);
title('the fifth eigenvector image');
figure(7);%the 100th image
imagesc(eigen100);
colormap(gray);
title('the 100th eigenvector image');
%%
%report_item_9
X = loadImages('./yalefaces');
mean = compMeanVec(X);
[row, column] = size(X);
Xmean = zeros(row, column);
for i = 1 : row
    Xmean(i, :) = X(i, :) - mean;
end
R = Xmean'*Xmean;% covariance matrix
[U,S,V] = svd(R);%first 100 column of U (same as V) and first 
                 %100 column of S
Vtest = V(:, 1:100);
A = imread('noisy_face.tiff');
Atest = double(A)./255;
[M, N] = size(Atest);
sizet = M*N;
Aorig = reshape(Atest, [1, sizet]);
Apca = PCAtransform(mean, Vtest, Aorig);
Areorig = invPCAtransform(mean, Vtest, Apca).*255;
Areconst = reshape(Areorig, [M, N]);
figure(1);
imagesc(Areconst);
colormap(gray);
title('the original basis image');