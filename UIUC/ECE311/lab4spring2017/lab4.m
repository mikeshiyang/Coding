%%
%report_item_1
N = 81; %total number of points in the impulse response, changing between 41 and 81
n = -(N-1)/2 : (N-1)/2; %-20 to 20 or -40 to 40
wc = pi/3;
w0 = pi/2;
%get low pass filter response
h_low = wc/pi*sinc(wc/pi*n);
H_low = fft(h_low);
shift_H_low = fftshift(H_low);
%get high pass filter response
delta = dirac(n);
delta(1,(N-1)/2+1) = 1;
h_high = delta - wc/pi*sinc(wc/pi*n);
H_high = fft(h_high);
shift_H_high = fftshift(H_high);
%get band pass filter response
h_band = cos(w0*n).*sinc(wc/pi*n);
H_band = fft(h_band);
shift_H_band = fftshift(H_band);
%get radians axis information
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
%plot low pass filter
figure(1);
subplot(2, 1, 1);
stem(n, h_low);
xlabel('n');
ylabel('magnitude');
title('impulse response of low pass filter');
subplot(2, 1, 2);
plot(w, abs(shift_H_low));
xlabel('w(Radians)');
ylabel('magnitude');
title('magnitude response of low pass filter');
%get high pass filter
figure(2);
subplot(2, 1, 1);
stem(n, h_high);
xlabel('n');
ylabel('magnitude');
title('impulse response of high pass filter');
subplot(2, 1, 2);
plot(w, abs(shift_H_high));
xlabel('w(Radians)');
ylabel('magnitude');
title('magnitude response of high pass filter');
figure(3);
subplot(2, 1, 1);
stem(n, h_band);
xlabel('n');
ylabel('magnitude');
title('impulse response of band pass filter');
subplot(2, 1, 2);
plot(w, abs(shift_H_band));
xlabel('w(Radians)');
ylabel('magnitude');
title('magnitude response of band pass filter');
%%
%report_item_2
load('impulseresponse.mat');

N = length(h);
H = fft(h);
shiftH = fftshift(H);
dbH = mag2db(abs(shiftH));%change to dB
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
%plot
figure(1);
stem(h);
xlabel('n');
ylabel('magnitude');
title('impulse response');
figure(2);
plot(w, dbH);
xlabel('w(Radians)');
ylabel('magnitude');
title('magnitude response in dB');
grid on;
figure(3);
plot(w, angle(shiftH));
xlabel('w(Radians)');
ylabel('phase');
title('phase response');
grid on;

%%
%Report_Item_3
N = 25;
w = linspace(-pi, pi, N);
wc = pi/3;
Gw = zeros(1, N);
M = N/2;
%find G(w)
for i = 1 : N
    if abs(w(i)) < wc
        Gw(i) = exp(-1i*M*w(i));
    else
        Gw(i) = 0;
    end
end
gn = ifft(Gw); %have gn
hn = zeros(1,N);
%add hamming window on it
for i = 1 : N
    hn(i) = gn(i)*(0.54-0.46*cos(2*pi*i/(N-1)));
end

Hw = fft(hn);

figure(1);
stem(gn);
xlabel('n');
ylabel('magnitude');
title('impulse response');
figure(2);
subplot(2,1,1);
plot(w, mag2db(abs(Hw)));
xlabel('w(Radians)');
ylabel('magnitude');
title('magnitude response in dB');
subplot(2,1,2);
plot(w, angle(Hw));
xlabel('w(Radians)');
ylabel('Phase');
title('phase response');
%%
%Report Item 4
fs = 1500;
f = [0.3*fs/2, 0.36*fs/2];
a = [1,0];
rp = 3;
rs = 50;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n, fo, mo, w] = firpmord(f, a, dev, fs);
b = firpm(n, fo, mo, w);
figure(1);
freqz(b, 1);
figure(2);
impz(b);
%%
%Report Item 6
[y, fs] = audioread('sound1.wav');%no wavread in Matlab, use audioread instead
%find magnitude spectrum
N = length(y);
Wy = fft(y);
shiftWy = fftshift(Wy);
omega = fftshift((0:N-1)/N*2*pi);
omega(1:N/2) = omega(1:N/2)-2*pi;
%filter
f = [0.4*fs/2, 0.6*fs/2];
a = [1, 0];
rp = 3;
rs = 50;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n, fo, mo, w] = firpmord(f, a, dev, fs);
b = firpm(n, fo, mo, w);
%apply the filter
yfilter = filter(b,1, y);
soundsc([y; yfilter], fs); %play the original sound and the filterd sound together

Wyfilter = fft(yfilter);
shiftWyfilter = fftshift(Wyfilter);
figure(3);
plot(omega/(2*pi)*fs, abs(shiftWy));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response');
figure(4);
plot(omega/(2*pi)*fs, abs(shiftWyfilter));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response after filtering');
mySTDFT(y, fs, 256, 512, 512, 1);
mySTDFT(yfilter, fs, 256, 512, 512, 2);

%%
%Report Item 7
[y, fs] = audioread('sound2.wav');
%find magnitude spectrum
N = length(y);
Wy = fft(y);
shiftWy = fftshift(Wy);
omega = fftshift((0:N-1)/N*2*pi);
omega(1:N/2) = omega(1:N/2)-2*pi;
%filter
f = [5000, 6000];
a = [1, 0];
rp = 3;
rs = 50;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n, fo, mo, w] = firpmord(f, a, dev, fs);
b = firpm(n, fo, mo, w);
%apply the filter
yfilter = filter(b,1, y);
soundsc([y; yfilter], fs); %play the original sound and the filterd sound together
mySTDFT(y, fs, 256, 512, 512, 1);
mySTDFT(yfilter, fs, 256, 512, 512, 2);
Wyfilter = fft(yfilter);
shiftWyfilter = fftshift(Wyfilter);
figure(3);
plot(omega/(2*pi)*fs, abs(shiftWy));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response');
figure(4);
plot(omega/(2*pi)*fs, abs(shiftWyfilter));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response after filtering');
%%
%report Item 8:
load('speechsig.mat');
leng = length(x);
N = 128;%fft length
m = 2;%step size
row = N/2+1;
column = floor((leng - N) / m)+1;
f2 = zeros(1, row);
t3 = zeros(1, column);
m1 = zeros(row, column);
m2 = zeros(row, column);
hamming = zeros(1, N);
rect = zeros(1, N);
%get hamming window
for i = 1 : N
    hamming(i) = (0.54-0.46*cos(2*pi*i/(N-1)));
    rect(i) = 1;
end
%get matrix m1
for i = 1 : column
    t3(i) = i; %get vector t3
    temp = zeros(1, N);
    tempcolumn = zeros(1, N);
    temp(1:N) = x((i-1)*m+1 : (i-1)*m+N);
    tempcolumn = abs(fft(hamming.*temp));
    m1(1:row, i) = tempcolumn(1:row);    
    tempcolumn = abs(fft(rect.*temp));
    m2(1:row, i) = tempcolumn(1:row);
end
%get the vector f2 to store omgea
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
f2 = w(N/2+1:N)/pi;
%plot
figure(1);
imagesc(t3, f2, m1); %row/10 for more information
xlabel('time');
ylabel('frequency(Hz)');
title('Spectrogram with hamming window');
figure(2);
imagesc(t3, f2, m2); %row/10 for more information
xlabel('time');
ylabel('frequency(Hz)');
title('Spectrogram with rectangular window');