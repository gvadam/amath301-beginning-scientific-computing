close all; clear all; clc
% Homework 7 Scorelator
% Problem 1
load('SeaPopData.mat');
dT = t(2) - t(1);
% 2nd order left endpoint forward difference
forward = (-3*P(1) + 4*P(1+dT) - 1*P(1 + 2*dT) )/(2*dT);
save('A1.dat', 'forward', '-ascii');

% 2nd order central difference
A = [];
for x = 2:length(t) - 1
    central = ( P(x + dT) - P(x - dT) )/(2*dT);
    A = [A central];
end
save('A2.dat', 'A', '-ascii');
% 2nd order right endpoint backward difference
backward = ( 3*P(end) - 4*P(end - dT) + P(end - 2*dT) )/(2*dT);
save('A3.dat', 'backward', '-ascii');

% Problem 2
mu = 3.39;
o = 0.55;
f = @(x) (1/sqrt(2*pi*o^2))*exp((-(x-mu).^2)/(2*o^2));
P_true = integral(f,2,4);
save('A4.dat', 'P_true', '-ascii');
h = [];
for k = 0:16
    n = 2^(-k);
    h = [h; n];
end
L = []; R = []; M = []; T = []; S = [];
for i = 1:length(h)
    v = [];
    m = [];
    for n = 2:h(i):4
        v = [v f(n)];
        if n ~= 4
            m = [m f((2*n + h(i))/2)];
        end
    end
    L(i) = h(i)*sum(v(1:end-1));
    R(i) = h(i)*sum(v(2:end));
    M(i) = h(i)*sum(m(1:end));
    T(i) = (h(i)/2)*(v(1) + v(end) + 2*sum(v(2:end-1)));
    S(i) = (h(i)/3)*[v(1) + v(end) + 2*sum(v(3:2:end-2)) + 4*sum(v(2:2:end-1))];
end
L = L.'; R = R.'; M = M.'; T = T.'; S = S.';
save('A5.dat', 'L', '-ascii');
save('A6.dat', 'R', '-ascii');
save('A7.dat', 'M', '-ascii');
save('A8.dat', 'T', '-ascii');
save('A9.dat', 'S', '-ascii');

% Problem 3 D,G
A10 = 'H'; 
save('A10.dat','A10','-ascii');

% Gradescope
errorL = [];errorR = [];errorM = [];errorT = [];errorS = [];
for k = 1:17
    errorL = [errorL abs(P_true - L(k))];
    errorR = [errorR abs(P_true - R(k))];
    errorM = [errorM abs(P_true - M(k))];
    errorT = [errorT abs(P_true - T(k))];
    errorS = [errorS abs(P_true - S(k))];
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



