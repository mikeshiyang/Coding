%q1
load 'signal.mat';
fs = 100;
%calculate fft and shift the plot
y = fft(x);
shifty = fftshift(y);
N = length(x);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
w = w/(2*pi)*fs;
%find the peak value and print
counter = 0;
for i = 1 : N
    if (shifty(i) > 10) && (w(i) > 0)
        counter = counter + 1;
        fprintf('tone %d is: %f Hz \n', counter, w(i));
    end
end
%plot
figure(1);
plot(w, abs(shifty));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response of the signal');
figure(2);
plot(w, angle(shifty));
xlabel('frequency(Hz)');
ylabel('phase');
title('phase response of the signal');
%%
%q2
load 'samplerate.mat';
N = length(x);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
%1st part
fs = 40;
y1 = fft(x);
shifty1 = fftshift(y1);
t1 = 0: 1/fs : (N-1)/fs;
w = w/(2*pi)*fs;
figure(1);
plot(w, abs(shifty1));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response of the signal');
figure(2);
stem(t1, x);
xlabel('time(t)');
ylabel('magnitude');
title('time domain plots of the original signal');
%2nd part
x2 = upsample(x, 3);
N2 = length(x2);
y2 = fft(x2);
shifty2 = fftshift(y2);
t2 = 0: 1/(fs*3) : (N2-1)/(fs*3);
w2 = fftshift((0:N2-1)/N2*2*pi);
w2(1:N2/2) = w2(1:N2/2)-2*pi;
w2 = w2/(2*pi)*fs;
figure(3);
plot(w2, abs(shifty2));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response of the upsampling signal');
figure(4);
stem(t2, x2);
xlabel('time(t)');
ylabel('magnitude');
title('time domain plots of the upsampling signal');
%3rd part
%apply the ideal LPF
y3 = zeros(1, N2);
for i = 1 : N2
    if (w2(i) < -5) || (w2(i) > 5)
        y3(i) = 0;
    else
        y3(i) = shifty2(i);
    end
end
x3 = ifft(y3);
figure(5);
subplot(2, 1, 1);
plot(w2, abs(y3));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response of the upsampling signal after LPF');
subplot(2, 1, 2);
plot(t2, x3);
xlabel('time(t)');
ylabel('magnitude');
title('time domain plots of the upsampling signal after LPF');
%4th part
x4 = downsample(x3, 2);
N4 = length(x4);
y4 = fft(x4);
shifty4 = fftshift(y4);
t4 = 0: 1/(fs*3/2) : (N4-1)/(fs*3/2);
w4 = fftshift((0:N4-1)/N4*2*pi);
w4(1:N4/2) = w4(1:N4/2)-2*pi;
w4 = w4/(2*pi)*fs;

figure(6);
subplot(2, 1, 1);
plot(w4, abs(shifty4));
xlabel('frequency(Hz)');
ylabel('magnitude');
title('magnitude response of the downsampling signal after LPF');
subplot(2, 1, 2);
plot(t4, x4);
xlabel('time(t)');
ylabel('magnitude');
title('time domain plots of the downsampling signal after LPF');
%%
%q3
load 'q1_signal.mat';
N = length(x);
y = fft(x);
%1st part
shifty = fftshift(y);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
figure(1);
subplot(2, 1, 1);
plot(w, abs(shifty));
xlabel('frequency(rad/s)');
ylabel('magnitude');
title('magnitude spectrum of the signal');
subplot(2, 1, 2);
plot(w, angle(shifty));
xlabel('frequency(rad/s)');
ylabel('phase');
title('phase spectrum of the signal');
%2nd part
ysig = zeros(1, N);
siglen = length(sig);
for i = 1 : N
    temp = mod(i, siglen);
    if temp == 0
        temp = siglen;
    end
    ysig(i) = sig(temp);
end

yysig = fft(ysig);
shiftysig = fftshift(yysig);


figure(2);
subplot(2, 1, 1);
plot(w, abs(shiftysig));
xlabel('frequency(rad/s)');
ylabel('magnitude');
title('magnitude spectrum of the sig');
subplot(2, 1, 2);
plot(w, angle(shiftysig));
xlabel('frequency(rad/s)');
ylabel('phase');
title('phase spectrum of the sig');
%3rd part
y3 = zeros(1, N);
for i = 1 : N
    if ((w(i) < -1.54) && (w(i) > -1.6)) || ((w(i) > 1.54) && (w(i) < 1.6))
        y3(i) = shifty(i);
    else
        y3(i) = 0;
    end
end
x3 = ifft(y3);
figure(3);
plot(x3);
xlabel('samples');
ylabel('magnitude');
title('bandpass filter the signal from 1.54 to 1.6');
%%
%q4
load 'q2_signal.mat';
%soundsc(x, fs);
figure(1);
spectrogram(x, 256, 128, 256, fs);

%part2
N = round(length(x)/2);

x2 = zeros(1, N);
for i = 1 : N
    x2(i) = x(2*i-1);
end
figure(2);
%soundsc(x2, fs/2);
spectrogram(x2, 256, 128, 256, fs/2);

%part3:
y = resample(x, 1, 2);
figure(3);
%soundsc(y, fs/2);
spectrogram(y, 256, 128, 256, fs/2);