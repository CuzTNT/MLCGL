function Y=updateY(X, W, S, lambda1, lambda2)
n = size(S,1);
S_nor = (S+S')/2;
D = diag(sum(S_nor));
L_S = D - S_nor;
% A = W'*W;
d = size(W,2);
A = eye(d);
B = 2*lambda1*L_S+lambda2*(eye(n)-S)*(eye(n)-S)';
C = W' * X;
Y = sylvester(A,B,C);