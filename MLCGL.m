function [Obj, Y, W, S, F] = MLCGL(X, c, dl, parameters, normData)
%% input:
% X{}: multi-view dataset, each cell is a view, each column is a data point
% c: cluster number
% dl: latent space dims
% lambda{1~3}: parameter (default 1)
% k: number of neighbors to determine the initial graph
%% output:
% W: the tansfrom cell of each view
% Y: the learned latent space matrix
% S: similarity-induced graph (SIG) matrix
% F: the embedding representation
%%
max_iter = 50; % iterator times
zr = 10e-11; 
pn = 15; % number of neighbours for constructS_PNG
if nargin < 4
    parameters = [1 1 1];
end;
if nargin < 5
    normData = 1;
end;
lambda1 = parameters(1);
lambda2 = parameters(2);
lambda3 = parameters(3);
n = size(X{1},2); % number of instances
V = length(X); % number of views
%% Normalization
if normData == 1
    for i = 1:V
        for  j = 1:n
            normItem = std(X{i}(:,j));
            if (0 == normItem)
                normItem = eps;
            end;
            X{i}(:,j) = (X{i}(:,j)-mean(X{i}(:,j)))/(normItem);
        end;
    end;
end;
%% initialize S: Constructing the SIG matrices
S0 = cell(1,V);
for i = 1:V
    [S0{i}, ~] = InitializeSIGs(X{i}, pn, 0);
end;
S = zeros(n);
for i = 1:V
    S = S + S0{i};
end;
S = S/V;
for j = 1:V
    S(j,:) = S(j,:)/sum(S(j,:));
end;
%% initialize F
[F, evs] = updateF(S,c);
%% initialize Y W
X_mat = cell2mat(X');
Y = rand(dl, n);
W = zeros(size(X_mat,1),dl);
%% Iterator updating variables...
iter = 1;
while ( iter<max_iter+1 )
    iter
    % update F
    [F, evs, L] = updateF(S,c);
    % update W 
    W=updateW(X_mat,Y);
    % update S
    S = updateS_original(S, F, Y, lambda1, lambda2, lambda3);
%     S = updateS(S, F, Y, lambda1, lambda2, lambda3);
    % update Y
    Y=updateY(X_mat, W, S, lambda1, lambda2);
    
    % check converge
    % Object function value
    Obj1(iter) = norm(X_mat - W*Y,'fro')^2;
    Obj2(iter) = lambda1*trace(Y*L*Y');
    Obj3(iter) = lambda2*norm(Y - Y*S,'fro')^2;
    Obj4(iter) = lambda3*trace(F'*L*F);
    
    Obj(iter) =Obj1(iter) +Obj2(iter)+ Obj3(iter) +lambda3*trace(F'*L*F);
    if (iter>1 && (abs(Obj(iter)-Obj(iter-1))/Obj(iter-1)) < 10^-2)
        break;
    end
    iter = iter + 1;
end
Lastiter = iter