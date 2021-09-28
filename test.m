%% MSRC-v1
clear;
addpath(genpath(cd))
load('MSRC-v1.mat');
gt = Y;
for i=1:4
    temp = X{i};  %Xv(dv*n)
    X{i} = temp';
end
%% Caltech101-10
clear;
addpath(genpath(cd))
load('Caltech101-10.mat');
gt = truth;
%% uci-digit
clear;
addpath(genpath(cd))
load uci-digit
X{1} = mfeat_fac';
X{2} = mfeat_fou';
X{3} = mfeat_kar';
gt = truth;
%% ORL
clear;
addpath(genpath(cd))

load ORL
X{1} = orl_face';
X{2} = orl_face_HOG';
X{3} = orl_face_LBF';
gt = truth;
%% WebKB
clear;
addpath(genpath(cd))
load WebKB
X = data;
gt = truelabel{1}';
%% BBCSport
clear;
addpath(genpath(cd))
load BBCSport
X = data;
gt = truelabel{1}';
c = length(unique(gt));
%% Caltech101-7
clear;
addpath(genpath(cd))
load Caltech101-10
for i=1:3
    temp = X{i}(:,1:2763);  %Xv(dv*n)
    X{i} = temp;
end
gt = truth(1:2763,:);
c = length(unique(gt));
%% prokaryotic
clear;
addpath(genpath(cd))

load prokaryotic

X{1} = text';
X{2} = proteome_comp';
X{3} = gene_repert';
y0 = truth;
gt = truth;
c = length(unique(truth));
%% reuters
clear;
addpath(genpath(cd))

load reuters

X{1} = spconvert(EN_EN_sample)';
X{2} = spconvert(EN_FR_sample)';
X{3} = spconvert(EN_GR_sample)';
X{4} = spconvert(EN_IT_sample)';
X{5} = spconvert(EN_SP_sample)';
y0 = truth;
c = length(unique(y0));
%% Coil20Data
% clear;
% addpath(genpath(cd))

load Coil20Data
X{1} = DATA';
X{2} = double(Coil_HOG)';
X{3} = Coil_LBF';
gt = truth;
 %% Run MLCGL 
 tic
 c = size(unique(gt), 1);
normData = 1;
dl = 40;
best.dl = dl;
lambda = [0.01, 20, 0.05];
[W, latentY, S, F] = MLCGL(X, c, dl, lambda, normData);
% [best.CA best.F best.P best.R best.nmi best.AR] = performance_kmeans(F, c, gt)
[best.CA best.F best.P best.R best.nmi best.AR] = performance_calculate(S, gt);
best
%  writetable(struct2table(temp(:)), 'LSSIG-Coil20.txt')
toc
%%
MAXiter = 1000;
REPlic = 20;
l = kmeans(F,c,'maxiter',MAXiter,'replicates',REPlic,'EmptyAction','singleton');
[ACC, NMI, PUR] = ClusteringMeasure_MCLES(gt,l)
%%
[best.CA best.F best.P best.R best.nmi best.AR] = performance_kmeans(F, c, gt)
best
%%
[clusternum, y]=graphconncomp(sparse(S)); y = y';
image(S*200);
%%
[CA F P R nmi AR] = performance_calculate(S, truth)