%report_item_2
q2 = linspace(0,1,12);
%% 
%report_item_3
x1 = linspace(0,5,100);
y = x1.^2.*log(x1).*sin(x1);
figure(1);
plot(x1,y);
xlabel('x','fontsize',14);
ylabel('f(x)','fontsize',14);
title('Report Item #3','fontsize',14);
%%
%report_item_4
x2 = 0:0.2:5;
sq = sqrt(x2);
fx = x2.^2.*exp(sq);
g = 3.*sq + sin(8*pi*x2);
figure(2);
subplot(2,1,1);
plot(x2,fx);
xlabel('x','fontsize',14);
ylabel('f(x)','fontsize',14);
title('Report Item #4_plot plot1','fontsize',14);
subplot(2,1,2);
plot(x2,g);
xlabel('x','fontsize',14);
ylabel('g(x)','fontsize',14);
title('Report Item #4_plot plot2','fontsize',14);

figure(3);
subplot(2,1,1);
stem(x2,fx);
xlabel('x','fontsize',14);
ylabel('f(x)','fontsize',14);
title('Report Item #4_stem plot1','fontsize',14);
subplot(2,1,2);
stem(x2,g);
xlabel('x','fontsize',14);
ylabel('g(x)','fontsize',14);
title('Report Item #4_stem plot2','fontsize',14);
%%
%report_item_5
x5 = linspace(-5, 5, 400);
y5 = linspace(-4, 4, 300);
[xx,yy] = meshgrid(x5, y5);
f = sinc(sqrt(xx.^2+yy.^2));
imagesc(x5,y5,f);
xlabel('x','fontsize',14);
ylabel('y','fontsize',14);
title('Report Item #5.1 f(x, y)','fontsize',14);
axis xy;
%%
x52 = linspace(-5, 5, 400);
y52 = linspace(-4, 4, 300);
[xxx,yyy] = meshgrid(x5, y5);
f2 = sinc(xxx).*sinc(yyy);
imagesc(x52,y52,f2);
xlabel('x','fontsize',14);
ylabel('y','fontsize',14);
title('Report Item #5.2 f(x, y)','fontsize',14);
axis xy;
%%
%report_item_7

soundsc(x, 10000);
%line up?
%frequency 10000Hz
%%
%report_item_8
load('clown');
figure(1);
colormap(map);
imagesc(X);
xlabel('pixel_x','fontsize',14);
ylabel('pixel_y','fontsize',14);
title('Clown picture','fontsize',14);

figure(2);
colormap(map);
subplot(2,1,1);
plot(X(17, :));
xlabel('pixel number','fontsize',14);
ylabel('gray value','fontsize',14);
title('17th row column value','fontsize',14);
subplot(2,1,2);
plot(X(:, 49));
xlabel('pixel number','fontsize',14);
ylabel('gray value','fontsize',14);
title('49th column value','fontsize',14);

Xt = X';
figure(3);
colormap(map);
imagesc(Xt);
xlabel('pixel_x','fontsize',14);
ylabel('pixel_y','fontsize',14);
title('Transposed clown picture','fontsize',14);