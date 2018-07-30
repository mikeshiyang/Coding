function [y] = sys2(a, x)
%y{n} = a*y(n-1) + x(n)^2
M = length(x);
y = zeros(1, M);
h = zeros(1, 64);
y(1, 1) = x(1, 1)*x(1, 1);
if M > 1
    for i = 2 : M
        y(1, i) = a*y(1, i-1) + x(1, i)*x(1, i);
    end    
end

h(1, 1) = 1;
for j = 2 : 64
    h(1, j) = a*h(1, j-1);
end

figure(1);
stem(h);
xlabel('n','fontsize',14);
ylabel('h(n)','fontsize',14);
title('impulse response of the system');

end