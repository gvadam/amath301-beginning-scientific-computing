function[x,M,numIter] = jacobiIter(A,b,x0,tol,maxIter)
% First, I want to check that we have a problem that can be solved with
% Jacobi
if size(A,1)~=size(A,2) %check that A is a square matrix
    error('A must be a square matrix.')
end
if size(A,1)~=size(b,1) %check that the outer dimensions of the system Ax = b make sense
    error('b must be a column vector with the same number of rows as rows in A')
end

% Second, break A down into A = D + T
D = diag(diag(A)); %D will now be a diagonal matrix with the same dimensions as A
T = A - D;

% Third, do the iteration step:
x_current = x0; %set the current guess to be the initial guess outside the loop!
M = -D\T; %define the iteration matrix outside the loop, so you only invert D once
B = D\b; %similarly, define the vector to add in each step
for k=1:maxIter
    x_next = M*x_current + B; %using the current guess for x, create a new guess for x
    if norm(x_next - x_current,Inf) < tol %if the difference between x_k and x_{k+1} is very small, then break the loop
        break %in this case, I took the Inf-norm. You could also look at the 2 norm.
    else %Because x is a vector, don't just take the absolute value of the difference between x_k and x_{k-1}
        x_current = x_next; %if it hasn't converged, set the new guess as the current guess and iterate again.
    end
end
if k==maxIter %consider including some warning so you know whether you converged or just ran out of steps
    warning('Maximum number of steps reached before convergence; try increasing maxIter');
end

numIter = k;
x = x_next; %set x to be our best guess, which should be the last one computed

end