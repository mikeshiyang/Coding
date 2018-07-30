function [y] = myDFTConv(x, h)
M = length(x);
N = length(h);
y = zeros(1, M+N-1);

x_pad = [x zeros(1, N-1)];
h_pad = [h zeros(1, M-1)];

y = ifft(fft(x_pad).*fft(h_pad));

ans = conv(x, h);

figure(1);
stem(y);
xlabel('n','fontsize',14);
ylabel('y(n)','fontsize',14);
title('myDFTConv result');

figure(2);
stem(ans);
xlabel('n','fontsize',14);
ylabel('y(n)','fontsize',14);
title('Built-in Conv result');
end