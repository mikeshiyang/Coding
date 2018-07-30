function [Xk] = myMatrixDFT(x)
[N, M] = size(x);
Xk = zeros(N, 1);
Z = zeros(N); % DFT matrix initialization

for k = 0 : (N-1)
    for j = 0 : (N-1)
        Z(k+1, j+1) = exp(-1i*2*pi*k*j/N);
    end
end

Xk = Z*x;

Y = fft(x);
Xreal = real(Xk);
Ximag = imag(Xk);
Yreal = real(Y);
Yimag = imag(Y);

figure(1);
plot(Xreal);
hold on
plot(Ximag);
xlabel('k','fontsize',14);
ylabel('X(k)','fontsize',14);
legend('Real part','Imaginary part');
title('myMatrixDFT result');

figure(2);
plot(Yreal);
hold on;
plot(Yimag);
xlabel('k','fontsize',14);
ylabel('X(k)','fontsize',14);
title('built-in fft function result');
legend('Real part','Imaginary part');

end