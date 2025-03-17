%% EXAMPLES of Madssen et al. "Statistical validation of multivariate 
% treatment effects in longitudinal study designs". Submitted to Journal of
% Chemometrics, 2025. This example simulates effects on measured data.
%
% coded by: Jose Camacho Paez (josecamacho@ugr.es)
%       Torfinn Støve Madssen (torfinn.s.madssen@ntnu.no)
% last modification: 17/March/2025
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
% samplesize: Number of patients within each cell
% j: Total number of variables
% A: Number of significant variables (the first ones)
% effecsize: [0, 1] 
% effect: standard deviation coefficients

function [data] = simulate(samplesize, j, A, effectsize, effect)

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

% Xpac = randn(NP*NT,NSV); % NP*NT to make patient nested in treatment
% Xpac = Xpac/norm(Xpac);
% Xtime = randn(NT,NSV);
% Xtime = Xtime/norm(Xtime);
% Xtreat =  randn(NTr,NSV);
% Xtreat  = Xtreat/norm(Xtreat);
% Xinter =  randn(NTr*NT,NSV);
% Xinter  = Xinter/norm(Xinter);
% for i = 1:size(F,1)
%     Xstruct(i,:) = effect(1)*Xtreat(F(i,1),:) + effect(2)*Xtime(F(i,2),:) + effect(3)*Xpac(F(i,1)*(NT-1) + F(i,3),:) + effect(4)*Xinter(F(i,1)*(NT-1) + F(i,2),:);
% end
% 
% Xnoise = randn(size(F,1),NV);
% %Xnoise = exprnd(1,length(obs_l),length(var_l)).^3; % This is the only change in this branch (same in all subfolders)
% Xnoise = Xnoise/norm(Xnoise);
% 
% Y = (1-effectsize)*Xnoise;
% Y(:,1:NSV) = Y(:,1:NSV) + effectsize*Xstruct;

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

Y = Xnoise; 
Y(:,1:NSV) = Y(:,1:NSV) + effectsize*Xstruct;
        
Y = array2table(Y);
data = [data2, Y];