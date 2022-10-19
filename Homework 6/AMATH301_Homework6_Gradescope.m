close all; clear all; clc;
% Homework 6 Gradescope
% Problem 1
load('salmon_data.mat');
p1 = polyfit(year, salmon, 1);
p3 = polyfit(year, salmon, 3);
p5 = polyfit(year, salmon, 5);
p8 = polyfit(year, salmon, 8);
plot(year, salmon, 'ko');
hold on;
plot(year,polyval(p1,year),'b','Linewidth',[2]);
plot(year,polyval(p3,year),'r','Linewidth',[2]);
plot(year,polyval(p5,year),'g','Linewidth',[2]);
plot(year,polyval(p8,year),'m','Linewidth',[2]);
legend('Salmon data', 'p1', 'p3', 'p5', 'p8', 'Location', 'Best');
xlabel('Year');
ylabel('Salmon');
xlim([1930 2020]);
ylim([150000 1500000]);
saveas(gcf,'problem1.jpg');
hold off;
%% Problem 2
load('CO2_data.mat');
load('A9.dat');
a = A9(1);
r = A9(2);
b = A9(3);
c = A9(4);
d = A9(5);
e = A9(6);
f1 = @(t) a*exp(r*t) + b;
f2 = @(t) a*exp(r*t) + b + c*sin(d*(t-e));
plot(t,CO2,'-k.');
hold on;
plot(t,f1(t),'r','Linewidth',[2]);
plot(t,f2(t),'b','Linewidth',[2]);
xlabel('Years since January 1958');
ylabel('Atmospheric CO2');
xlim([0 65]);
legend('CO2 data','exponential fit', 'exponential + sinusoidal fit', 'Location', 'Best');
saveas(gcf,'problem2.jpg');






