close all; clc; clear all;
% Homework 8 Scorelator
g = 9.8; L = 15; sigma = 0.15;
d0dt = @(theta,v) v;
dvdt = @(theta,v) -(g/L)*sin(theta) - sigma*v;

tspan = 0:0.02:60;
N = length(tspan);
theta = zeros(1,N);  
theta(1) = pi/4;
v = zeros(1,N);  
v(1) = -0.75;
theta0 = theta(1); 
v0 = v(1);

z0 = [theta0;v0];
odefun = @(t,z) [d0dt(z(1), z(2))
                 dvdt(z(1), z(2))];
[t_sol,y_sol] = ode45(odefun,tspan,z0);
vectorTheta = y_sol(:,1);
save('A1.dat', 'vectorTheta','-ascii');
vectorV = y_sol(:,2);
save('A2.dat', 'vectorV','-ascii');

x(:,1) = z0;    
dt = 0.02;
for k = 1:60/0.02        
       theta(:,k+1) = theta(:,k) + dt*v(:,k); 
       v(:,k+1) = v(:,k) + dt*(-(g/L)*sin(theta(k))-sigma*v(k));
end

first = abs(vectorTheta(end) - theta(end));
second = abs(vectorV(end) - v(end));
ans3 = [first; second];
save('A3.dat', 'ans3', '-ascii');

%% Problem 2
d0dt = @(theta,v) v;
dvdt = @(theta,v) -(g/L)*theta - sigma*v;
A = [ 0     ,    1   ;
      -g/L  , -sigma ];
x = zeros(length(z0),length(tspan));    
x(:,1) = z0;    
dt = 0.02;
for k = 1:60/0.02        
       x(:,k+1) = x(:,k) + dt*A*x(:,k);    
end
x = x.';
ans4 = [x(end,1); x(end,2)];
save('A4.dat','ans4', '-ascii');
    
I = eye(2);
[L,U,P] = lu(I-(dt*A));
ans5 = L*U*P;
save('A5.dat','ans5', '-ascii');

x = zeros(length(z0),length(tspan));    
x(:,1) = [pi/4; -0.75];
for k = 1:60/0.02
    b = P\x(:,k);
    y = L\b;
    x(:,k+1) = U\y;
end
ans6 = [x(1,end);x(2,end)];
save('A6.dat','ans6', '-ascii');

x = zeros(length(z0),length(tspan));    
x(:,1) = z0;    
dt = 0.02;

e = max(abs(eig(I+(0.02*A))));
fe = max(abs(eig(inv(I-(0.02*A)))));
ans7 = [e, fe];
save('A7.dat','ans7', '-ascii');

x = zeros(length(z0),length(tspan));    
x(:,1) = [pi/4; -0.75];
for k = 1:60/0.02
    if k == 1
        x(:,k+1) = (I + dt*A)*x(:,k);
    else
        x(:,k+1) = x(:,k-1) + 2*dt*A*x(:,k);
    end
end
ans8 = [x(1,end);x(2,end)];
save('A8.dat','ans8', '-ascii');

odefun = @(t,z) [d0dt(z(1), z(2))
                 dvdt(z(1), z(2))];
[t_sol,y_sol] = ode45(odefun,tspan,z0);
ans9 = [y_sol(end,1);y_sol(end,2)];
save('A9.dat','ans9','-ascii');

ans10 = 'D';
save('A10.dat','ans10', '-ascii');

%%
function [t,y] = forward_euler(odefun,tspan,y0)
    tspan = reshape(tspan,[length(tspan) 1]);    
    y0 = reshape(y0,[length(y0) 1]);    
    dt = tspan(2)-tspan(1);    
    y = zeros(length(y0),length(tspan));    
    y(:,1) = y0;    
    for k = 1:length(y)-1        
           y(:,k+1) = y(:,k) + dt*odefun(tspan(k),y(:,k));    
    end
    t = tspan;    
    y = y.';
end
