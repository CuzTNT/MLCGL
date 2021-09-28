 %% select dl
tic
 c = size(unique(gt), 1);
normData = 1;
d = 10;
parameters = [0.01, 1, 0];
p3 = [ 0.005, 0.01 0.5 1 10];
times = 0;
for i = 1:1
        parameters(3) = p3(i);
for j = 1 : 1
    times = times+1
best.p3 = p3(i);
[Obj, LatentY, W, S, F] = MLCGL(X, c, d, parameters, normData);
[best.CA best.F best.P best.R best.nmi best.AR] = performance_kmeans(LatentY', c, gt);

temp1(i, j) = best;
end
%  writetable(struct2table(temp1(:)), 'prokaryotic-p3.txt')
end
toc
%% select parameters
tic
 c = size(unique(gt), 1);
normData = 1;
d = 10;
p1 = [0.005 0.01 0.5 1 10];
p2 = [ 0.01 0.5 1 10];
p3 = [ 0.01 0.5];
parameters = [0, 0, 10];
times = 0;
for i = 1 : 4
    for j = 1 : 4
        for k = 1 : 2
            times = times + 1
    parameters(1) = p1(i);
    parameters(2) = p2(j);
    parameters(3) = p3(k);
    best.p1 = p1(i);
    best.p2 = p2(j);
    best.p3 = p3(k);
[Obj, LatentY, W, S, F] = GPSIG(X, c, d, parameters, normData);
[best.CA best.F best.P best.R best.nmi best.AR] = performance_kmeans(LatentY', c, gt);
temp1(i,j,k) = best;
 writetable(struct2table(temp1(:)), 'MVSC-parameters.txt')
        end
    end
end
toc
