% Homework 1
clear all; close all; clc;

%% Problem 1
x1 = 15001500;
sum = 0;
for k = 1:10000
    sum = sum + 0.3*k;
end
x1 = abs(x1 - sum);

x2 = 0;
for k = 1:5000
    x2 = x2 + 0.01*k^2;
end
x2 = abs(x2 - 416791675);

x3 = 15000000;
sum2 = 0;
for k = 1:30000000
    sum2 = sum2 + 0.5;
end
x3 = abs(x3 - sum2);

x4 = 0;
for k = 1:30000000
    x4 = x4 + 0.1;
end
x4 = abs(x4 - 3000000);

%% Problem 2
x = (-pi:0.01:pi);

set(gca, 'Fontsize', [10]);
plot(x, cos(x), 'Linewidth', [2]);
hold on;
xlabel('x-values', 'Fontsize', [10]);
ylabel('cos(x)', 'Fontsize', [10]);
title('cos(x) and its Taylor approximations', 'Fontsize', [10]);

for n = [1 2 3 7]
    taylorSeries = 0;
    for k = 0:n
        taylorSeries = taylorSeries + (((-1)^k)/factorial(2*k))*x.^(2*k);
    end
    plot(x, taylorSeries, 'Linewidth', [2]);
end

legend('cos(x)', 'taylor series n=1', 'taylor series n=2', 'taylor series n=3', 'taylor series n=7', 'Location', 'south');
saveas(gcf, 'plot.jpg');    


