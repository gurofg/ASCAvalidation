% simulate_mvdata_emb: simulate effect embeded in a specific component
% samplesize: Number of patients within each cell
% j: Total number of variables
% A: Number of components
% d: affect component
% effecsize: [0, 1] 
% expvar: amount of explained variance

function [data] = simulate(samplesize, j, A, d, effectsize, expvar)

effect = [.5,.5,2,1]; % large individual effect, small interaction
n_timepoints = 2;
n_groups = 2;
n_subjects = samplesize;

NP = n_subjects/n_groups; % Number of patients within each cell
NT = n_timepoints; % Number of repeated measures
NTr = n_groups; % Number of treatments
NV = 1; % Total number of variables
NSV = 1; % Number of significant variables

levels = {1:NTr,1:NT,1:NP};
F = create_design(levels);

data2 = table();
data2.ID = F(:,3);
data2.ID(size(F,1)/2+1:end)=data2.ID(size(F,1)/2+1:end)+NP;
data2.timepoint = F(:,2);
data2.treatment = F(:,1);

Xpac = randn(NP*NT,NSV); % NP*NT to make patient nested in treatment
Xpac = Xpac/norm(Xpac);
Xtime = randn(NT,NSV);
Xtime = Xtime/norm(Xtime);
Xtreat =  randn(NTr,NSV);
Xtreat  = Xtreat/norm(Xtreat);
Xinter =  randn(NTr*NT,NSV);
Xinter  = Xinter/norm(Xinter);
for i = 1:size(F,1)
    Xstruct(i,:) = effect(1)*Xtreat(F(i,1),:) + effect(2)*Xtime(F(i,2),:) + effect(3)*Xpac(F(i,1)*(NT-1) + F(i,3),:) + effect(4)*Xinter(F(i,1)*(NT-1) + F(i,2),:);
end
        
Xnoise = randn(size(F,1),NV);
%Xnoise = exprnd(1,length(obs_l),length(var_l)).^3; % This is the only change in this branch (same in all subfolders)
Xnoise = Xnoise/norm(Xnoise);

y = (1-effectsize)*Xnoise;
y(:,1:NSV) = y(:,1:NSV) + effectsize*Xstruct;

y = preprocess2D(y,2);
        
if isequal(expvar,'high')
    columnweights1 = (abs(-d:-1));
    columnweights2 = linspace(0.1,0.01,(A-d));
    columnweights = [columnweights1, columnweights2];
elseif isequal(expvar,'low')
    columnweights1 = (abs(-d:-1)).^2;
    columnweights2 = linspace(0.8,0.2,(A-d));
    columnweights = [columnweights1, columnweights2];
end


% Make orthogonal scores for components < d
clear T
T = zeros(size(y,1), A);
T(:,d) = y - mean(y);
I = eye(n_subjects*n_timepoints);

for i = 1:(d-1);
    Q_T = (I-(T(:,find(mean(T)~=0))*(T(:,find(mean(T)~=0))'*T(:,find(mean(T)~=0)))^-1)*T(:,find(mean(T)~=0))');
    w = normrnd(0, columnweights(i), size(F,1), 1);
    T(:,i) = Q_T*w;
end

% make orthogonal scores for components > d
for i = 1:(A-d);
    Q_T = (I-(T(:,find(mean(T)~=0))*(T(:,find(mean(T)~=0))'*T(:,find(mean(T)~=0)))^-1)*T(:,find(mean(T)~=0))');
    w = normrnd(0, columnweights(d+i), size(F,1), 1);
    T(:,d+i) = Q_T*w;
end

for i = 1:size(T,2)
    T(:,i) = T(:,i) - mean(T(:,i));
end

% Make orthogonal loadings such that P'P = I
mat = rand(j, A);
P = orth(mat-(ones(j,1)*mean(mat)));

Y = T*P'; %+ rand(size(T,1),j); % generating response matrix
% E = randn(size(Y,1), size(Y,2));
% Y = Y + E;

% Verify that the design is correctly simulated
% [loadings, scores, eigen] = pca(Y);
%         figure;
%         for e = 1:9
%             subplot(3,3,e); hold on
%             yplot = scores(:,e);
%             for i = 1:n_subjects
%                 if unique(data2.treatment(data2.ID == subjects(i))) == 1
%                     colorvec = 'b';
%                 else colorvec = 'r';
%                 end
%                 plot(yplot(data2.ID == subjects(i)), 'color', colorvec)
%             end
%         end

Y = array2table(Y);
data = [data2, Y];