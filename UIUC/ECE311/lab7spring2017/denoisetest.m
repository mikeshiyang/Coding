clc, clear all, close all

[xorig,fs] = audioread('original.wav');
[xnoise,fs] = audioread('noisy.wav');

wname = 'db1';
a1thresh = 0.0; % Must be positive.
d1thresh = 0.0; % Must be positive.
a2thresh = 0.0; % Must be positive.
d2thresh = 0.0; % Must be positive.
a3thresh = 0.0; % Must be positive.
d3thresh = 0.0; % Must be positive.
a4thresh = 0.0; % Must be positive.
d4thresh = 0.0; % Must be positive.
a5thresh = 0.0; % Must be positive.
d5thresh = 0.0; % Must be positive.

% DWT
x = xnoise;
[a1,d1] = dwt(x,wname);
[a2,d2] = dwt(a1,wname);
[a3,d3] = dwt(a2,wname);
[a4,d4] = dwt(a3,wname);
[a5,d5] = dwt(a4,wname);

% Inverse DWT
N = 500;
number = 0;
min = 1000000;
for i = 1 : N
    a1thresh = (i-1)/N;%change this line through a1 to d5 independently
    a5_ = (abs(a5)>a5thresh).*a5;
    d5_ = (abs(d5)>d5thresh).*d5;
    a4t = idwt(a5_,d5_,wname);
    a4_ = (abs(a4t)>a4thresh).*a4t;
    d4_ = (abs(d4)>d4thresh).*d4;
    a3t = idwt(a4_,d4_,wname);
    a3_ = (abs(a3t)>a3thresh).*a3t;
    d3_ = (abs(d3)>d3thresh).*d3;
    a2t = idwt(a3_,d3_,wname);
    a2_ = (abs(a2t)>a2thresh).*a2t;
    d2_ = (abs(d2)>d2thresh).*d2;
    a1t = idwt(a2_,d2_,wname);
    a1_ = (abs(a1t)>a1thresh).*a1t;
    d1_ = (abs(d1)>d1thresh).*d1;
    x_ = idwt(a1_,d1_,wname);
    E = norm(x_ - xorig)/norm(xorig)*100;
    if E < min
        min = E;
        number = (i-1)/N;
    end
end
    disp(['Percent Relative Error: ', num2str(min)]);
    disp(['threshold: ', num2str(number)]);
