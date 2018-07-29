function [Xk] = myDFT(x)
[M,N] = size(x);
Xk = zeros(1, N);
for k = 0 : (N-1)
    for j = 0 : (N-1)
        Xk(1, k+1) = Xk(1, k+1) + x(j+1)*exp(-1i*2*pi*k*j/N);
    end
end
Y = fft(x);
Xreal = real(Xk);
Ximag = imag(Xk);
Yreal = real(Y);
Yimag = imag(Y);

figure(1);
stem(Xreal);
hold on
stem(Ximag);
xlabel('k','fontsize',14);
ylabel('X(k)','fontsize',14);
legend('Real part','Imaginary part');
title('myDFT result');

figure(2);
stem(Yreal);
hold on;
stem(Yimag);
xlabel('k','fontsize',14);
ylabel('X(k)','fontsize',14);
title('built-in fft function result');
legend('Real part','Imaginary part');
end
