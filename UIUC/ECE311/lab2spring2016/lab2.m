%%
%Report_Item_4
load('signal.mat');
Xw = fft(x); %calculate fft
[M, N] = size(x); % N is the size of x, M = 1
fs = 200; %sampling rate

shift_Xw = fftshift(Xw); %shift xw
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi; %shift w

omega = fs*w; %get corrsponding omega

figure(1);
subplot(2, 1, 1);
plot(w, abs(shift_Xw));
xlabel('w(Radians)');
ylabel('magnitude');
title('X(w) magnitude with digital frequency axis');
subplot(2, 1, 2);
plot(w, angle(shift_Xw));
xlabel('w(Radians)');
ylabel('angle');
title('X(w) angle with digital frequency axis');

figure(2);
subplot(2, 1, 1);
plot(omega, abs(shift_Xw));
xlabel('omega(Radians)');
ylabel('magnitude');
title('X(omega) magnitude with analog frequency axis');
subplot(2, 1, 2);
plot(omega, angle(shift_Xw));
xlabel('omega(Radians)');
ylabel('angle');
title('X(omega) angle with analog frequency axis');
%%
%Report_Item_5
load('NMRSpec.mat');

%calculate the fft and then shift it
origin = fft(st);
st_length = length(st);
shift_origin = fftshift(origin);
w = fftshift((0:st_length-1)/st_length*2*pi);
w(1:st_length/2) = w(1:st_length/2)-2*pi;
%plot the origin spectrum
figure(1);
subplot(2, 1, 1);
plot(BW*w/(2*pi), abs(shift_origin));
xlabel('frequency (Hz)');
ylabel('amplitude');
title('original signal amplitude vs. frequency');
subplot(2, 1, 2);
plot(BW*w/(2*pi), angle(shift_origin));
xlabel('frequency (Hz)');
ylabel('angle');
title('original signal angle vs. frequency');

%calculate the 32-point DFT
shorter = st(1:32);
shorterfft = fft(shorter);
shorter_shift = fftshift(shorterfft);

ww = fftshift((0:32-1)/32*2*pi);
ww(1:32/2) = ww(1:32/2)-2*pi;
%plot the 32-point spectrum
figure(2);
subplot(2, 1, 1);
plot(BW*ww/(2*pi), abs(shorter_shift));
xlabel('frequency (Hz)');
ylabel('amplitude');
title('32-point DFT spectrum amplitude vs. frequency');
subplot(2, 1, 2);
plot(BW*ww/(2*pi), angle(shorter_shift));
xlabel('frequency (Hz)');
ylabel('angle');
title('32-point DFT spectrum angle vs. frequency');

%zero-pad the 32-point DFT to 512 points
longer = zeros(512, 1);
longer(1:32) = shorter;
longerfft = fft(longer);
longer_shift = fftshift(longerfft);

www = fftshift((0:512-1)/512*2*pi);
www(1:512/2) = www(1:512/2)-2*pi;
%plot 512-points DFT spectrum
figure(3);
subplot(2, 1, 1);
plot(BW*www/(2*pi), abs(longer_shift));
xlabel('frequency (Hz)');
ylabel('amplitude');
title('512-point DFT spectrum amplitude vs. frequency');
subplot(2, 1, 2);
plot(BW*www/(2*pi), angle(longer_shift));
xlabel('frequency (Hz)');
ylabel('angle');
title('512-point DFT spectrum angle vs. frequency');

%%
%Report_Item_6
N = 20;
M = 512;
origin = zeros(1, M);
%get frequency response of rectangular window
rect = origin;
rect(1:N) = 1;
fftrect = fftshift(fft(rect));
w = fftshift((0:M-1)/M*2*pi);
w(1:M/2) = w(1:M/2)-2*pi;
%plot rectangular window
figure(1);
subplot(2, 1, 1);
stem(rect(1:N));
xlabel('n');
ylabel('w(n)');
title('rectangular window')

subplot(2, 1, 2);
plot(w, mag2db(abs(fftrect)));
xlabel('w');
ylabel('dB');
title('magnitude responce of zero-padding (512 points) rectangular window');

%get frequency response of triangular window
tri = origin;
for k = 1 : N/2+1
    tri(1, k) = 2*(k-1)/N;
end
for j = (N/2+2) : N
    tri(1, j) = tri(1, N+2-j);
end
ffttri = fftshift(fft(tri));

%plot triangular window
figure(2);
subplot(2, 1, 1);
stem(tri(1:N));
xlabel('n');
ylabel('w(n)');
title('triangular window')

subplot(2, 1, 2);
plot(w, mag2db(abs(ffttri)));
xlabel('w');
ylabel('dB');
title('magnitude responce of zero-padding (512 points) triangular window');

%get frequency response of hamming window
hamm = origin;
for j = 1 : N
    hamm(j) = 0.54 - 0.46*cos(2*pi*(j-1)/N);
end

ffthamm = fftshift(fft(hamm));
%plot hamming window
figure(3);
subplot(2, 1, 1);
stem(hamm(1:N));
xlabel('n');
ylabel('w(n)');
title('hamming window');

subplot(2, 1, 2);
plot(w, mag2db(abs(ffthamm)));
xlabel('w');
ylabel('dB');
title('magnitude responce of zero-padding (512 points) hamming window');

%get frequency response of hanning window
hann = origin;
for j = 1 : N
    hann(j) = 0.5 - 0.5*cos(2*pi*(j-1)/N);
end

ffthann = fftshift(fft(hann));
%plot hanning window
figure(4);
subplot(2, 1, 1);
stem(hann(1:N));
xlabel('n');
ylabel('w(n)');
title('hanning window');

subplot(2, 1, 2);
plot(w, mag2db(abs(ffthann)));
xlabel('w');
ylabel('dB');
title('magnitude responce of zero-padding (512 points) hanning window');

%get frequency response of kaiser window
kaiser = origin;
beta = 0.1;
Z = 0 : (N-1)
%calculate x in the bessel function
for k = 1 : N
    Z(k) = beta*sqrt(1-((Z(k)-N/2)/(N/2))*((Z(k)-N/2)/(N/2)));
end
J = besselj(0, Z);%get bessel function

kaiser(1:N) = J;

fftkaiser = fftshift(fft(kaiser));
%plot kaiser window
figure(5);
subplot(2, 1, 1);
stem(kaiser(1:N));
xlabel('n');
ylabel('w(n)');
title('kaiser window');

subplot(2, 1, 2);
plot(w, mag2db(abs(fftkaiser)));
xlabel('w');
ylabel('dB');
title('magnitude responce of zero-padding (512 points) kaiser window');

%%
%Report_Item_7
N1 = 20;
w = linspace(0, 1, N1);
Xw = exp(-1i*w*N1/2)./exp(-1i*w/2)*N1.*diric(w, N1);
%plot the magnitude and phase response when N = 20;
figure(1);
subplot(2, 1, 1);
plot(w, abs(Xw));
xlabel('radians');
ylabel('amplitude');
title('magnitude response of rectangular window when N = 20');
subplot(2, 1, 2);
plot(w, angle(Xw));
xlabel('radians');
ylabel('angle');
title('phase response of rectangular window when N = 20');

%plot the magnitude and phase response when N = 40
N2 = 40;
ww = linspace(0, 1, N2);
Xww = exp(-1i*ww*N2/2)./exp(-1i*ww/2)*N2.*diric(ww, N2);
%plot the magnitude and phase response when N = 40;
figure(2);
subplot(2, 1, 1);
plot(ww, abs(Xww));
xlabel('radians');
ylabel('amplitude');
title('magnitude response of rectangular window when N = 40');
subplot(2, 1, 2);
plot(ww, angle(Xww));
xlabel('radians');
ylabel('angle');
title('phase response of rectangular window when N = 40');

%%
%Report_Item_8
f0 = 5;
dt = 0.02;
T = 1/f0;
N = T/dt; %which is 10 in this situation

n = 0 : (N-1);
xn = sin(2*pi*f0*n*dt); %signal function
%get the response

fftx = fftshift(fft(xn));
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
%plotting
figure(1);
subplot(2, 1, 1);
plot(1/dt*w/2/pi, abs(fftx));
xlabel('frequency (Hz)');
ylabel('amplitude');
title('amplitude response of the signal');
subplot(2,1,2);
plot(1/dt*w/2/pi, angle(fftx));
xlabel('frequency (Hz)');
ylabel('angle');
title('angle response of the signal');


