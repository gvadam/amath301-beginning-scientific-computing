close all; clear all; clc;
% Homework 6 Scorelator
%% Problem 1
load('salmon_data.mat');
A = [ sum(year.^2, 'all') , sum(year, 'all');
      sum(year, 'all')    , sum(size(year))-1];
b = [ sum(year.*salmon); 
      sum(salmon) ];
save('A1.dat', 'A', '-ascii');
save('A2.dat', 'b', '-ascii');

x = A\b;
save('A3.dat', 'x', '-ascii');

p1 = polyfit(year, salmon, 1);
p3 = polyfit(year, salmon, 3);
save('A4.dat', 'p3', '-ascii');
p5 = polyfit(year, salmon, 5);
save('A5.dat', 'p5', '-ascii');
p8 = polyfit(year, salmon, 8);
save('A6.dat', 'p8', '-ascii');

err1 = abs(polyval(p1,2018) - 336030);
err2 = abs(polyval(p3,2018) - 336030);
err3 = abs(polyval(p5,2018) - 336030);
err4 = abs(polyval(p8,2018) - 336030);

errV = [ err1, err2, err3, err4 ];
save('A7.dat', 'errV', '-ascii');

%% Problem 2
load('CO2_data.mat');

adapter = @(p) sumSquaresError(p(1),p(2),p(3));
p = [30;0.03;300];
[squaredVals,squaredErr] = fminsearch(adapter, p);
A8 = squaredVals.';
save('A8.dat','A8','-ascii');

adapter2 = @(p) sumSquaresError2(p(1), p(2), p(3), p(4),p(5),p(6));
p_2 = [A8(1),A8(2),A8(3),-5,4,0];
[squaredVals2,squaredErr2] = fminsearch(adapter2, p_2);
A9 = [squaredVals2];
save('A9.dat','A9','-ascii');

%% Problem 3
z = polyval(p1,2045);
y = polyval(p3,2045);
x = polyval(p5,2045);
w = polyval(p8,2045);

A10 = 'A';
save('A10.dat', 'A10', '-ascii');

function error = sumSquaresError2(a, r, b, c, d, e)
    load('CO2_data.mat');
    y = @(t) (a*exp(r*t)) + b + (c*sin(d*(t-e)));
    error = sum(abs(y(t)-CO2).^2);
end

function error = sumSquaresError(a,r,b)
    load('CO2_data.mat');
    y = @(t) a*exp(r*t) + b;
    error = sum(abs(y(t)-CO2).^2);
end


