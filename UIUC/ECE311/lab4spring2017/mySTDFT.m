function [m1, f2, t3] = mySTDFT(x, fs, M, D, P, number)%remove xname, number for the plot
if (number ~= 1) && (number ~= 2)
    number = 1;
end
%load(xname); %get x and fs
N = length(x);
row = ceil(P/2);
column = floor((N-M)/D)+1;
dt = D/fs;
f2 = zeros(1, row);
t3 = zeros(1, column);
m1 = zeros(row, column);
%get matrix m1
for m = 1 : column
    t3(m) = m*dt; %get vector t3
    temp = zeros(1, P);
    tempcolumn = zeros(1, P);
    temp(1:M) = x((m-1)*D+1 : (m-1)*D+M);
    for k = 1 : P
        for n = 1 : P
            tempcolumn(k) = tempcolumn(k) + temp(n)*exp(-1i*2*pi*k*n/P);
        end
    end
    m1(1:row, m) = tempcolumn(1:row);        
end
%get the vector f2 to store omgea
w = fftshift((0:P-1)/P*2*pi);
w(1:P/2) = w(1:P/2)-2*pi;
f2 = w(P/2+1:P)/(2*pi)*fs;
%plot
figure(number);
imagesc(t3, f2(1:row), abs(m1(1:row, :))); %row/10 for more information
xlabel('time(s)');
ylabel('frequency(Hz)');
title('Spectrogram');
end
