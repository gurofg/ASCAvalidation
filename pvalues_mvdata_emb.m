%% EXAMPLES of Madssen et al. "Statistical validation of multivariate 
% treatment effects in longitudinal study designs". Submitted to Journal of
% Chemometrics, 2025. This example generates figures of the p-values in 
% terms of the number of components from simulated data with effects in a 
% specific component.
%
% coded by: Torfinn St�ve Madssen (torfinn.s.madssen@ntnu.no)
%       Jose Camacho Paez (josecamacho@ugr.es)
% last modification: 19/March/2025
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

clear
close all
clc

% Specify simulation settings
j = 200; % number of manifest variables to simulate in Y
A = 100; % number of latent variables (principal components) to simulate
d = 3; % which component should contain the design effects
samplesize =  50;

ncomp_values = [1:2:10,20:10:40]

options.plot = 'off';
options.CI = 'off';
options.iterations = 500;
options.directory = 'emul_neoava';

options.iterations = 500;
options.baseline = 'cLDA'; % Constrain the baseline means
options.coding = 'PRC'; % Use reference coding for the treatment factor
options.ncomp = 5;
options.GLLR = 'yes';
options.permute = 'yes';
options.newID = 'false';
options.center = 'off';

effectsize = 0:0.12:0.6
expvar = 'high';
effect = [.5,0,2,1] % small time effect, zero treatment effect, large individual effect, moderate interaction
for iii = 1:2 % 2 replicates
    for ii = 1:length(effectsize)
        effectsize(ii)
        
        rng(iii) % seed for the replicate
        
        data = simulate_mvdata_emb(samplesize, j, A, d, effectsize(ii), expvar, effect); % function for simulating multivariate data
        options.Y_vars = data.Properties.VariableNames(30:end);
        
        parfor i = 1:length(ncomp_values)
            i
            options2 = options;
            options2.ncomp = ncomp_values(i);
            
            [~, M_B, ~] = RM_LiMM_PCA_sim(data, options2);
            
            pval_GLLR(i,ii) = M_B.pval;
            pval_perm(i,ii) = M_B.pval_perm1;
            pval_perm3(i,ii) = M_B.pval_perm3;
        end
        
        % Plot p-values
        
        figure;
        ylabel('P-value'); xlabel('Number of components'); title(sprintf('Effect Size %d',effectsize(ii))); hold on
        plot(ncomp_values, pval_GLLR(:,ii), 'red');
        plot(ncomp_values, pval_perm(:,ii), 'green');
        plot(ncomp_values, pval_perm3(:,ii), 'blue');
        legend('GLLR', 'perm', 'perm-f')
        saveas(gcf,sprintf('./Figures/pvalues_emb_%d_%d',iii,ii));
        saveas(gcf,sprintf('./Figures/pvalues_emd_%d_%d',iii,ii),'epsc');
        
        save sim_emb
        
    end
end


