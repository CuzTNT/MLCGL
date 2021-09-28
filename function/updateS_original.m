function S = updateS(S, F, Y, lambda1, lambda2, lambda3)
K = Y'*Y;
n = size(F,1);
for ij=1:n
    for ji=1:n
        y(ji) = (norm(F(ij,:)-F(ji,:)))^2;
        f(ji)=(norm(F(ij,:)-F(ji,:)))^2;
        b(ji) = lambda1*y(ji)+lambda3*f(ji);
    end
%     H=2*lambda2*eye(n)+K;
    H=K;
    H=(H+H')/2;
    ff=b'-2*lambda2*K(:,ij);
    
% we use the free package to solve quadratic equation: http://sigpromu.org/quadprog/index.html
    
    [Z(:,ij),err,lm] = qpas(H,ff,[],[],ones(1,n),1,zeros(n,1),ones(n,1));
    %Z(:,ij)=quadprog(H,(beta/2*all'-2*K(:,ij))',[],[],ones(1,n),1,zeros(n,1),ones(n,1),Z(:,ij),options);
    
end
S = (S+S')/2;