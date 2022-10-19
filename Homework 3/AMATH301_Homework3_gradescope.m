clear all; close all; clc;
%% Homework 3 Gradescope
%% Problem 1
% part a & b
t_backslash = [0,0,0,0,0]; 
i = 1;
for n = [700, 1200, 2400, 6000, 9000]
    A = rand(n);
    b = rand(n,1);
    tic
    x = A\b;
    t_backslash(i) = toc;
    i = i + 1;
end
% part c
t_LU = [0,0,0,0,0]; 
i = 1;
for n = [700, 1200, 2400, 6000, 9000]
    A = rand(n);
    b = rand(n,1);
    tic
    [L,U,P] = lu(A);
    y = L \ (P*b);
    x = U \ y;
    t_LU(i) = toc;
    i = i + 1;
end
% part d
t_inverse = [0,0,0,0,0]; 
i = 1;
for n = [700, 1200, 2400, 6000, 9000]
    A = rand(n);
    b = rand(n,1);
    tic
    x = inv(A)*b;
    t_inverse(i) = toc;
    i = i + 1;
end
% part e
n = [700, 1200, 2400, 6000, 9000];
loglog(n, t_backslash, '-bo');
hold on;
% part f
loglog(n, t_LU, '-rd');
% part g
loglog(n, t_inverse, '-gs');
% part h
xlabel('n');
ylabel('time');
title('Time to solve Ax=b');
legend('Backslash', 'LU Decomposition', 'Inverse', 'Location', 'Best');
saveas(gcf, 'problem1.jpg');
hold off;
%% Problem 2
% part a
A = vander(1:20);
warning('off','all');
% part b
t_b = [0,0];
tic
for n = 1:100
    b = rand(20,1);
    x = A\b;    
end
t_b(1) = toc;

% part c
t_l = [0,0];
[L,U,P] = lu(A);
tic
for n = 1:100
    b = rand(20,1);
    y = L \ (P*b);
    x = U \ y;
end
t_l(1) = toc;

% part d
t_i = [0,0];
A_i = inv(A);
tic
for n = 1:100
    b = rand(20,1);
    x = A_i*b; 
end
t_i(1) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% part e
tic
for n = 1:10000
    b = rand(20,1);
    x = A\b;    
end
t_b(2) = toc;
%%%%%%%%%%%%%%%%%%%%%
[L,U,P] = lu(A);
tic
for n = 1:10000
    b = rand(20,1);
    y = L \ (P*b);
    x = U \ y;
end
t_l(2) = toc;
%%%%%%%%%%%%%%%%
A_i = inv(A);
tic
for n = 1:10000
    b = rand(20,1);
    x = A_i*b; 
end
t_i(2) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% part g
b = rand(20,1);
t_b_r = [0,0,0];
tic
for n = 1:100 
    x = A\b;
end
t_b_r(1) = toc;
tic
for n= 1:10000
    x = A\b;
end
t_b_r(2) = toc;
b_r = A*x-b;
t_b_r(3) = norm(b_r);
%%%%%%%%%%%%%%%%%%%%%
[L,U,P] = lu(A);
t_lu_r = [0,0,0];
tic
for n = 1:100 
    x = A\b;
end
t_lu_r(1) = toc;
tic
for n = 1:10000
    y = L \ (P*b);
    x = U \ y;
end
t_lu_r(2) = toc;
lu_r = A*x-b;
t_lu_r(3) = norm(lu_r);
%%%%%%%%%%%%%%%%%%%%%
A_i = inv(A);
t_in_r = [0,0,0];
tic
for n = 1:100    
    x = A_i*b;
end
t_in_r(1) = toc;
tic
for n = 1:10000
    x = A_i*b;
end
t_in_r(2) = toc;
in_r = A*x-b;
t_in_r(3) = norm(in_r);









