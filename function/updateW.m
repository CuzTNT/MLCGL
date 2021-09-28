function W=updateW(X,Y)
% 
G = Y';
Q = X';
P = G'*Q;
[U,~,V] = svd (P,'econ'); 

WT = U*V';
W = WT';
