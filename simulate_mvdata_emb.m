%% EXAMPLES of Madssen et al. "Statistical validation of multivariate 
% treatment effects in longitudinal study designs". Submitted to Journal of
% Chemometrics, 2025. This example simulate effects embedded in a specific 
% component.
%
% coded by: Jose Camacho Paez (josecamacho@ugr.es)
%       Torfinn St�ve Madssen (torfinn.s.madssen@ntnu.no)
% last modification: 26/March/2025
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%% Relative Population Curves from variance coefficients. 
% simulate_mvdata_emb: simulate effect embeded in a specific component
% samplesize: Number of patients within each cell
% j: Total number of variables
% A: Number of components
% d: affect component
% effecsize: [0, 1] 
% expvar: amount of explained variance
% effect: standard deviation coefficients

function [data] = simulate(samplesize, j, A, d, effectsize, expvar, effect)

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

% Following Camacho and Armstrong. "Population Power Curves in ASCA With Permutation Testing." Journal of Chemometrics 38, no. 12 (2024): e3596.

Xpac = randn(NP*NT,NSV); 
Xpac = sqrt(NP*NT)*Xpac/norm(Xpac,'fro'); 
Xtime = randn(NT,NSV);
Xtime = sqrt(NT)*Xtime/norm(Xtime,'fro'); 
Xtreat =  randn(NTr,NSV);
Xtreat = sqrt(NTr)*Xtreat/norm(Xtreat,'fro'); 
Xinter =  randn(NTr*NT,NSV);
Xinter = sqrt(NTr*NT)*Xinter/norm(Xinter,'fro');
for i = 1:size(F,1)
    Xstruct(i,:) = effect(1)*Xtreat(F(i,1),:) + effect(2)*Xtime(F(i,2),:) + effect(3)*Xpac(F(i,1)*(NT-1) + F(i,3),:) + effect(4)*Xinter(F(i,1)*(NT-1) + F(i,2),:);
end

Xnoise = randn(size(F,1),NV);
Xnoise = sqrt(size(F,1))*Xnoise/norm(Xnoise,'fro');

y = (1-effectsize)*Xnoise; % (1-effectsize)*Xnoise; % for the embeded simulation, we make sure that the noise within the pc can cancel out, so that the unisterested variance is represented by the variance in the other components
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

Y = T*P'; 

Y = array2table(Y);
data = [data2, Y];