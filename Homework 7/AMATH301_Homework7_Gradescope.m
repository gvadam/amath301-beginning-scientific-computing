close all; clear all; clc
% Homework 7 Gradescope
load('A5.dat'); load('A6.dat'); load('A7.dat');
load('A8.dat'); load('A9.dat'); load('A4.dat');
errorL = [];errorR = [];errorM = [];errorT = [];errorS = [];
for k = 1:17
    errorL = [errorL abs(A4 - A5(k))];
    errorR = [errorR abs(A4 - A6(k))];
    errorM = [errorM abs(A4 - A7(k))];
    errorT = [errorT abs(A4 - A8(k))];
    errorS = [errorS abs(A4 - A9(k))];
end
h = [];
for k = 0:16
    n = 2^(-k);
    h = [h; n];
end
loglog(h,errorL,'ro','Linewidth',[2]);
hold on;
loglog(h,errorR,'b.','Linewidth',[2]);
loglog(h,errorM,'gd','Linewidth',[2]);
loglog(h,errorT,'m+','Linewidth',[2]);
loglog(h,errorS,'cs','Linewidth',[2]);
C = 10^(-1);
loglog(h,C*h,'k:');
C = 10^(-1.5);
loglog(h,C.*(h.^2), 'k-.');
C = 10^(-1.7);
loglog(h,C.*(h.^4), 'k-');
yline(10^(-16),'r','Linewidth',[2]);
legend('Left', 'Right', 'Midpoint', 'Trapezoid', 'Simpsons', 'O(h)','O(h^2)','O(h^4)', 'Machine Prec.','Location', 'Best');
xlabel('Step sizes');
ylabel('Error');
title('Convergence of Numerical Integration Schemes');
saveas(gcf,'problem1.jpg');


