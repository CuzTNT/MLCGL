function [F, evs, L] = updateF(S,c)
S_nor = (S+S')/2;
D = diag(sum(S_nor));
L = D - S_nor;
[F, ~, evs]=eig1(L, c, 0);