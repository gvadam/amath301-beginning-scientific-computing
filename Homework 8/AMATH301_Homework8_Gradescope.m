close all; clc; clear all;
% Homework 9 Gradescope
%% Problem 1
g = 9.8; L = 15; sigma = 0.15;
d0dt = @(theta,v) v;
dvdt = @(theta,v) -(g/L)*sin(theta) - sigma*v;

tspan = 0:0.02:60;
N = length(tspan);
theta = zeros(1,N);  
theta(1) = pi/4;
v = zeros(1,N);  
v(1) = -0.75;
z0 = [theta(1);v(1)];
odefun = @(t,z) [d0dt(z(1), z(2))
                 dvdt(z(1), z(2))];
[t_sol,y_sol] = ode45(odefun,tspan,z0);
theta = y_sol(:,1);
v = y_sol(:,1);

x = linspace(-3*pi,3*pi,25);
y = linspace(-3,3,25);
[X,Y] = meshgrid(x,y);

quiver(X,Y, d0dt(X,Y), dvdt(X,Y));
hold on

xlabel('\theta');
ylabel('velocity');

z1 = [pi;0.1];
[t_sol1,y_sol1] = ode45(odefun,tspan,z1);
plot(y_sol1(:,1),y_sol1(:,2));
z2 = [pi;-0.1];
[t_sol2,y_sol2] = ode45(odefun,tspan,z2);
plot(y_sol2(:,1),y_sol2(:,2));
z3 = [2*pi;-3];
[t_sol3,y_sol3] = ode45(odefun,tspan,z3);
plot(y_sol3(:,1),y_sol3(:,2));
z4 = [-2*pi;3];
[t_sol4,y_sol4] = ode45(odefun,tspan,z4);
plot(y_sol4(:,1),y_sol4(:,2));

xlim([-3*pi 3*pi]);
ylim([-3 3]);

saveas(gcf,'problem1.jpg');
hold off

%% Problem 2
d0dt = @(theta,v) v;
dvdt = @(theta,v) -(g/L)*theta - sigma*v;
A = [ 0     ,    1   ;
      -g/L  , -sigma ];
x = zeros(length(z0),length(tspan));    
x(:,1) = z0;

xvec = linspace(-pi/3,pi/3,25);
yvec = linspace(-pi/3,pi/3,25);

[X,Y] = meshgrid(xvec,yvec);

quiver(X,Y, d0dt(X,Y), dvdt(X,Y));
hold on

xlabel('\theta');
ylabel('velocity');

[t_sol5,y_sol5] = ode45(odefun,tspan,z0);
p1 = plot(y_sol5(:,1),y_sol5(:,2),'y:','Linewidth',[2]);
A = [ 0     ,    1   ;
      -g/L  , -sigma ];
% Forward
x = zeros(length(z0),length(tspan));    
x(:,1) = z0;    
dt = 0.02;
for k = 1:60/0.02        
       x(:,k+1) = x(:,k) + dt*A*x(:,k);    
end
x = x.';
p2 = plot(x(:,1),x(:,2),'c','Linewidth',[2]);

I = eye(2);
[L,U,P] = lu(I-(dt*A));

% Backward
x = zeros(length(z0),length(tspan));    
x(:,1) = z0;
for k = 1:60/0.02
    b = P\x(:,k);
    y = L\b;
    x(:,k+1) = U\y;
end
x = x.';
p3 = plot(x(:,1),x(:,2),'m','Linewidth',[2]);

% Leap frog
x = zeros(length(z0),length(tspan));    
x(:,1) = z0;
for k = 1:60/0.02
    if k == 1
        x(:,k+1) = (I + dt*A)*x(:,k);
    else
        x(:,k+1) = x(:,k-1) + 2*dt*A*x(:,k);
    end
end
x = x.';
p4 = plot(x(:,1),x(:,2),'r','Linewidth',[2]);

legend([p1 p2 p3 p4],'Ode45','Forward','Backward','Leapfrog');

saveas(gcf,'problem2.jpg');
