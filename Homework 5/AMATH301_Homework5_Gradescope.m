%% Homework 5
clear all; close all; clc
%% Problem 1
% part a
f = @(x,y) (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
x_m = linspace(-5,5,20);
y_m = linspace(-5,5,20);
[X,Y] = meshgrid(x_m,y_m);
surf(X,Y,f(X,Y));
zlim([0,200]);
xlim([-5,5]);
ylim([-5,5]);
caxis([0,200]);
colorbar();
view(30,30);
daspect([1 1 70]);
colormap('jet');
shading INTERP;
xlabel('x-axis');
ylabel('y-axis');
zlabel('f(x,y) axis');
saveas(gcf, 'parta.jpg');

% part b
x_m2 = linspace(-5,5,100);
y_m2 = linspace(-5,5,100);
[X2, Y2] = meshgrid(x_m2, y_m2);
v = logspace(-1,3,22);
contourf(X2, Y2, f(X2, Y2),v);
caxis([0,200]);
colormap('jet');
xlabel('x-axis');
ylabel('y-axis');
% part c
f_p = @(p) f(p(1),p(2));
x1 = fminsearch(f_p, [-5,-4]);
x2 = fminsearch(f_p, [-3,0]);
x3 = fminsearch(f_p, [1,3]);
x4 = fminsearch(f_p, [4,5]);
% part d
hold on;
% i.
plot(3.0000181, 2.0000385, 'ro', 'MarkerSize', [15], 'Linewidth', [3]);
% ii.
plot(3,2.0000002, 'gs', 'MarkerSize', [15]);
% iii.
plot(x1(1),x1(2),'y*', 'MarkerSize', [15]);
plot(x2(1),x2(2),'y*', 'MarkerSize', [15]);
plot(x3(1),x3(2),'y*', 'MarkerSize', [15]);
plot(x4(1),x4(2),'y*', 'MarkerSize', [15]);
saveas(gcf, 'partb.jpg');

%% Problem 2
f_gradient = @(x,y) [4*x.^3 - 42.*x + 4*x.*y + 2*y.^2 - 14;
                     4*y.^3 - 26.*y + 4*x.*y + 2*x.^2 - 22];
fgrad = @(p) f_gradient(p(1), p(2));
f_p = @ (p) f(p(1),p(2));

p = [3;4];
tic  
for iter = 1:10000
    grad = fgrad(p); 
    phi = @ (t) p - t*grad; 
    f_of_phi = @ (t) f_p(phi(t));
    tmin = fminbnd(f_of_phi,0,1); 
    p = phi(tmin);
    if norm(grad,Inf)< 10^(-5)
        break;
    end
end
kf = iter;
fmin_t = toc;

p = [3; 4];
tic
tstep = 0.01;
for iter = 1:10000
    grad = fgrad(p); 
    p = p - tstep*grad;
    if norm(grad,Inf) < 10^(-5)
        break;
    end
end
k1 = iter;
step1_t = toc;

p = [3; 4];
tic
tstep = 0.02;
for iter2 = 1:10000
    grad = fgrad(p); 
    p = p - tstep*grad;
    if norm(grad,Inf) < 10^(-5)
        break;
    end
end
k2 = iter2;
step2_t = toc;


p = [3; 4];
tstep = 0.025;
tic
for iter3 = 1:10000
    grad = fgrad(p); 
    p = p - tstep*grad;
    if norm(grad,Inf) < 10^(-5)
        break;
    end
end
k3 = iter3;
step3_t = toc;

table = [k1, step1_t;
         k2, step2_t;
         k3, step3_t;
         kf, fmin_t];
