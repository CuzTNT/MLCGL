function [CA F P R nmi AR] = performance_calculate(S, truth)
if (min(truth)==0)
    truth = truth+1;
end
for i=1:20
	[~, idx]=graphconncomp(sparse(S)); idx = idx';	
    CAi(i) = 1-compute_CE(idx, truth); % clustering accuracy
    [Fi(i),Pi(i),Ri(i)] = compute_f(truth,idx); % F1, precision, recall
    nmii(i) = compute_nmi(truth,idx);
    ARi(i) = rand_index(truth,idx);
end
CA(1) = mean(CAi); CA(2) = std(CAi);
F(1) = mean(Fi); F(2) = std(Fi);
P(1) = mean(Pi); P(2) = std(Pi);
R(1) = mean(Ri); R(2) = std(Ri);
nmi(1) = mean(nmii); nmi(2) = std(nmii);
AR(1) = mean(ARi); AR(2) = std(ARi);

end