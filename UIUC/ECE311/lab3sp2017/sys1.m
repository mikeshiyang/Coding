function [y] = sys1(a, x)
%y{n} = 2*y(n-1) + 0.3x(n) - 2*x(n-10)
M = length(x);
y = zeros(1, M);
h = zeros(1, 64);
y(1, 1) = 0.3*x(1, 1);
if M > 1
    for i = 2 : M
        y(1, i) = a*y(1, i-1) + 0.3*x(1, i) - 2*x(1, i-1);
    end    
end

h(1, 1) = 0.3;
for j = 2 : 64
    h(1, j) = a*h(1, j-1);
    if j == 2
        h(1, j) = h(1, j) - 2;
    end
end

figure(1);
stem(h);
xlabel('n','fontsize',14);
ylabel('h(n)','fontsize',14);
title('impulse response of the system');

end