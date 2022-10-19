clear all; close all; clc;
% Homework 4
% Problem 1
%% part a
tol = 10^(-6);
maxIter = 50000;
guess = randn(90,1);
v1 = ones(1, 90);
v2 = [];
for i = 1:89
    v2 = [v2 -1/2];
end
x = diag(v1);
y = diag(v2,1);
z = diag(v2,-1);
A = x + y + z; % A matrix
c = zeros(89,1);
b = [1/2; c]; % B vector
p_exact = A\b; % Exact p value

% Jacobi method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p_j, M_j, k_j] = jacobiIter(A,b,guess,tol,maxIter);
error_j = abs(p_exact - p_j); % Error for Jacobi

% Gauss-Seidel method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[p_g, M_g, k_g] = gsIter(A,b,guess,tol,maxIter);
error_g = abs(p_exact - p_g); % Error for Gauss 

% SOR method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w = 1.94; % optimal w 
[p_s, M_s, k_s] = sorIter(A,b,w,guess,tol,maxIter);
error_s = abs(p_exact - p_s); % Error for SOE

%% part b
x = [1:90]; % horizontal axis 
sgtitle('Solution and Error of Jacobi, Gauss, and SOR Method');

subplot(3,1,1);
set(gca, 'Fontsize', [14]);
title('Method Solutions');
plot(x,p_exact,'-k.');
hold on;
plot(x,p_j,'ro');
plot(x,p_g,'gd');
plot(x,p_s,'bs');
xlabel('Vector Index (p_n)');
ylabel('Solution');

subplot(3,1,2); 
title('Errors in Method Solutions');
plot(x,error_j,'-ro');
hold on;
plot(x,error_g,'-gd');
plot(x,error_s,'-bs');
xlabel('Vector Index (p_n)');
ylabel('Error');  

subplot(3,1,3); 
title('Log Scale of Errors');
semilogy(x,error_j,'-ro');
hold on;
semilogy(x,error_g,'-gd');
semilogy(x,error_s,'-bs');
xlabel('Vector Index (p_n)');
ylabel('Error (Log Scale)');

saveas(gcf, 'partb.jpg');

%% part c
e_j = max(abs(eig(M_j)));
e_g = max(abs(eig(M_g)));
e_s = max(abs(eig(M_s)));

%% part e
lambda_j = e_j^(k_j);
lambda_g = e_g^(k_g);
lambda_s = e_s^(k_s);

%% part f
totalError_j = norm(p_exact - p_j);
totalError_g = norm(p_exact - p_g);
totalError_s = norm(p_exact - p_s);

%% part g
table_j = [e_j k_j lambda_j totalError_j];
table_g = [e_g k_g lambda_g totalError_g];
table_s = [e_s k_s lambda_s totalError_s];
table = [table_j; table_g; table_s];


