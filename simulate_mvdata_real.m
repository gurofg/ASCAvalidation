% simulate_mvdata_real: simulate effect on the measured data
% samplesize: Number of patients within each cell
% j: Total number of variables
% A: Number of significant variables (the first ones)
% effecsize: [0, 1] 

function [data] = simulate(samplesize, j, A, effectsize)

effect = [.5,.5,2,1]; % large individual effect, small interaction
n_timepoints = 2;
n_groups = 2;
n_subjects = samplesize;

NP = n_subjects/n_groups; % Number of patients within each cell
NT = n_timepoints; % Number of repeated measures
NTr = n_groups; % Number of treatments
NV = j; % Total number of variables
NSV = A; % Number of significant variables

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

Y = (1-effectsize)*Xnoise;
Y(:,1:NSV) = Y(:,1:NSV) + effectsize*Xstruct;
        
Y = array2table(Y);
data = [data2, Y];