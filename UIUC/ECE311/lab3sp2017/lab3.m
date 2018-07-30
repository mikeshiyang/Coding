%%
%report item 4
w = linspace(0, pi, 1000);
amp1 = zeros(1, 1000);
amp2 = zeros(1, 1000);

for i = 1 : 1000
    if i == 1
        amp2(1, i) = 20;
    else 
        if i == 250
            amp1(1, i) = 5;
        end
        if i < 1000/3
            amp2(1, i) = i;
        end
    end
end

figure(1);
plot(w, amp1);
xlabel('w/rads');
ylabel('amplitude');
title('approximate amplitude response for (a)');

figure(2);
plot(w, amp2);
xlabel('w/rads');
ylabel('amplitude');
title('approximate amplitude response for (b)');

%%
%report item 5
%H1(z) section
b1 = [2, 0, 5, 4, 0, 0, -3];
a1 = [1, 0, 0, 0, 0, 0, 0];
S1 = tf(b1, a1);
N = 20;

figure(1);
subplot(121);
pzplot(S1);
subplot(122);
impz(b1, a1, N);

%H2(z) section
b2 = [3, 2, 0, -2];
a2 = [1, 0, 0, 0];
S2 = tf(b2, a2);

figure(2);
subplot(121);
pzplot(S2);
subplot(122);
impz(b2, a2, N);

%H3(z) section
b3 = [0, 0, 0, 1, 0, 0, 1, -2];
a3 = [12, 1, 0, 4, 0, 0, 0, 0];
S3 = tf(b3, a3);

figure(3);
subplot(121);
pzplot(S3);
subplot(122);
impz(b3, a3, N);

%%
%report_item 6
b = [0, 1];
a = [1, exp(-1i*8*pi/10)+exp(1i*8*pi/10), 1];
s = tf(b, a);
N = 35;
figure(1);
subplot(121);
pzplot(s);
subplot(122);
impz(b, a, N);
