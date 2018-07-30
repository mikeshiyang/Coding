function [y] = myFFT(x)

N = length(x);
y = zeros(1, N);
if N == 2
    y(1) = x(1) + x(2);
    y(2) = x(1) - x(2);
elseif N == 1
        y(1) = x(1);
elseif mod(N, 2) == 0
    Xe = myFFT(x(1:2:N-1));
    X0 = myFFT(x(2:2:N));    
    y = [Xe, Xe] + exp(-1i*2*pi*(0:N-1)/N).*[X0, X0];
elseif mod(N, 2) == 1
    for k = 0 : (N-1)
        for j = 0 : (N-1)
            y(1, k+1) = y(1, k+1) + x(j+1)*exp(-1i*2*pi*k*j/N);
        end
    end
end
end