clear all; close all; clc;
%% Problem 1
% part a - root finding problem
f = @(x)  x.*exp(6 - 3*x.*(1+exp(3*(1-x)))) - x;
x = linspace(0,5,1000);
y = f(x);
% part b - plot function
plot(x, y);
hold on;
saveas(gcf, 'parta.jpg');
hold off;
% part c - exact solution for x1 using fzero and guess
x1 = fzero(f,0.2);
% part d - exact solution for x2 
x2 = fzero(f,2);

% Bisection method for x1
% part e - interval for x1 [0.1,0.2]
left = 0.1;
right = 0.2;
% part f - root for x1, tolerance 10^-12, vector of midpoints and errors
tol = 10^(-12);
v1_Bisection_midpoints = [];
v1_Bisection_errors = [];
for k = 1:1000
    mid = (left + right)/2;
    f_mid = f(mid);
    v1_Bisection_midpoints = [v1_Bisection_midpoints mid];
    v1_Bisection_errors = [v1_Bisection_errors abs(x1 - mid)];
    if abs(f_mid) < tol
        disp('Using bisection, x1 root = ')
        disp(mid)
        break;
    elseif f_mid*f(left) < 0
        right = mid;
    elseif f_mid*f(right) < 0
        left = mid;
    else 
        disp('zero not found')
        break
    end
end

% Bisection method for x2
% part e - interval for x2 [1.5,2]
left = 1.5;
right = 2;
% part f - root for x1, tolerance 10^-12, vector of midpoints and errors
v2_Bisection_midpoints = [];
v2_Bisection_errors = [];
for k = 1:1000
    mid = (left + right)/2;
    f_mid = f(mid);
    v2_Bisection_midpoints = [v2_Bisection_midpoints mid];
    v2_Bisection_errors = [v2_Bisection_errors abs(x2 - mid)];
    if abs(f_mid) < tol
        disp('Using bisection, x2 root = ')
        disp(mid)
        break;
    elseif f_mid*f(left) < 0
        right = mid;
    elseif f_mid*f(right) < 0
        left = mid;
    else 
        disp('zero not found')
        break
    end
end    

% part h - Find root for x1 using Newton's method, vector of guesses and errors
f_dev = @(x) exp(6-3*x.*(exp(3*(1-x))+1)).*x.*(9*exp(3.*(1-x)).*x-3*(exp(3.*(1-x))+1))+exp(6-3.*x.*(exp(3.*(1-x))+1))-1;
tol = 10^(-12);
% part g - Initial guess for x1
x = 0.1;
v1_Newton_guesses = [x];
v1_Newton_errors = [abs(x1-x)];
for k = 1:60
    x = x - (f(x)/f_dev(x));
    v1_Newton_guesses = [v1_Newton_guesses x];
    v1_Newton_errors = [v1_Newton_errors abs(x1 - x)];
    if abs(f(x)) < tol
       disp('Using Newton, x1 root = ')
       disp(x)
       break;
    end  
end

% part h - Find root for x2 using Newton's method, vector of guesses and errors
% part g - initial guess for x2
x = 1.8;
v2_Newton_guesses = [x];
v2_Newton_errors = [abs(x2-x)];
for k = 1:60
    x = x - (f(x)/f_dev(x));
    v2_Newton_guesses = [v2_Newton_guesses x];
    v2_Newton_errors = [v2_Newton_errors abs(x2 - x)];
    if abs(f(x)) < tol
       disp('Using Newton, x2 root = ')
       disp(x)
       break;
    end  
end
    
% part i - plot error vectors from bisection method vs # midpoints 
% plot bisection x1 with black +
midpoints1 = [1:length(v1_Bisection_midpoints)];
plot(midpoints1, v1_Bisection_errors, 'k+');
hold on;
% plot bisection x2 with blue +
midpoints2 = [1:length(v2_Bisection_midpoints)];
plot(midpoints2, v2_Bisection_errors, 'b+');

% part j - plot error vectors from Newton's method vs # of steps
% plot newton x1 with green *
plot((1:length(v1_Newton_guesses)), v1_Newton_errors, 'g*');
% plot newton x2 with red *
plot((1:length(v2_Newton_guesses)), v2_Newton_errors, 'r*');

% part k - legend
legend('Bisection error x1', 'Bisection error x2', 'Newton error x1', 'Newton error x2', 'Location', 'Best');

% part l & m - Title, axis labels, fontsize 15
title('Bisection and Newton Method Errors', 'Fontsize', [15]);
xlabel('# ofMidpoints/Steps');
ylabel('Error Values');
set(gca, 'Fontsize', [15]);
saveas(gcf, 'BisectionAndNewton.jpg');

%% Problem 2
hold off;
semilogy(midpoints1, v1_Bisection_errors, 'k+');
hold on;
semilogy(midpoints2, v2_Bisection_errors, 'b+');
semilogy((1:length(v1_Newton_guesses)), v1_Newton_errors, 'g*');
semilogy((1:length(v2_Newton_guesses)), v2_Newton_errors, 'r*');
title('Bisection and Newton Method Errors', 'Fontsize', [15]);
xlabel('# of Midpoints/Steps');
ylabel('Error Values');
legend('Bisection error x1', 'Bisection error x2', 'Newton error x1', 'Newton error x2', 'Location', 'Best');
set(gca, 'Fontsize', [15]);
saveas(gcf, 'BisectionAndNewtonLogScale.jpg');
hold off;
%% Problem 3
f = @(x) x.*sin(x);
f_der = @(x) (sin(x) + x.*cos(x));
tol = 10^(-10);
% part a - Newton's method with initial guess 1.8
x = 1.8;
for k = 1:50
    x = x - (f(x)/f_der(x));
    if abs(f(x)) < tol
        disp('guess 1.8, error = ')
        error1 = abs(x - 0);
        disp(error1)
        break;
    end
end

% part b - Newton's method for initial guess 1.9
x = 1.9;
for k = 1:50
    x = x - (f(x)/f_der(x));
    if abs(f(x)) < tol
        disp('guess 1.9, error = ')
        error2 = abs(x - 0);
        disp(error2)
        break;
    end
end
x = -pi:pi/100:pi;
y = x.*sin(x);
plot(x, y);
hold on;
saveas(gcf, 'xsinx.jpg');
    