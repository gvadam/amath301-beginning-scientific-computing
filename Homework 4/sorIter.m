function[x,M,numIter] = sorIter(A,b,w,x0,tol,maxIter)
if size(A,1)~=size(A,2)
    error('A must be a square matrix.')
end
if size(A,1)~=size(b,1)
    error('b must be a column vector with the same number of rows as rows in A')
end
D = diag(diag(A));
U = triu(A) - D;
L = tril(A) - D;

P = (1/w)*D + L;
T = ((w - 1)/w)*D + U;
M = -P\T;
B = P\b;

x_current = x0; 
for k=1:maxIter
    x_next = M*x_current + B; 
    if norm(x_next - x_current,Inf) < tol 
        break 
    else 
        x_current = x_next;
    end
end
if k==maxIter 
    warning('Maximum number of steps reached before convergence; try increasing maxIter');
end

numIter = k;
x = x_next; 

end