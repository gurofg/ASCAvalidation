%% EXAMPLES of Madssen et al. "Statistical validation of multivariate 
% treatment effects in longitudinal study designs". Submitted to Journal of
% Chemometrics, 2025. This example generates relative population power
% curves (see Journal of Chemometrics, 2024, 38 (12): e3596
%
% coded by: Torfinn Støve Madssen (torfinn.s.madssen@ntnu.no)
%       Jose Camacho Paez (josecamacho@ugr.es)
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

%% General settings

n_sim = 200;
iterations = 200;

%% High variance treatment effect, ncomp = 5.

effectsize = 0:0.4:2;
output_dir = './Script_5/';
nrcomps = 5;
expvar = 'high';
center = 'off';

[VarHigh5Comp1, VarHigh5Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
axis([effectsize(1:2) 0 1])
saveas(gcf,'./Figures/VarHigh5zoom');
saveas(gcf,'./Figures/VarHigh5zoom','epsc');
axis([effectsize([1 end]) 0 1])
saveas(gcf,'./Figures/VarHigh5');
saveas(gcf,'./Figures/VarHigh5','epsc');


%% High variance treatment effect, ncomp = 50

effectsize = 0:0.4:2;
output_dir = './Script_50/';
nrcomps = 50;
expvar = 'high';
center = 'off';

[VarHigh50Comp1, VarHigh50Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
axis([effectsize(1:2) 0 1])
saveas(gcf,'./Figures/VarHigh50zoom');
saveas(gcf,'./Figures/VarHigh50zoom','epsc');
axis([effectsize([1 end]) 0 1])
saveas(gcf,'./Figures/VarHigh50');
saveas(gcf,'./Figures/VarHigh50','epsc');


%% Treatment effect in real data

effectsize = 0:0.04:0.2;
output_dir = './Script_Real/';
nrcomps = 5;
center = 'off';

[VarLow5Comp1, VarLow5Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
axis([effectsize(1:2) 0 1])
saveas(gcf,'./Figures/VarRealzoom');
saveas(gcf,'./Figures/VarRealzoom','epsc');
axis([effectsize([1 end]) 0 1])
saveas(gcf,'./Figures/VarReal');
saveas(gcf,'./Figures/VarReal','epsc');


%% P-values in terms of the number of components  from simulated data with effects in a 
% specific component

load sim_emb
for iii = 1:2 % 2 replicates
    for ii = 1:length(effectsize)
        % Plot p-values
        figure;
        ylabel('P-value'); xlabel('Number of components'); title(sprintf('Effect Size %d',effectsize(ii))); hold on
        plot(ncomp_values, pval_GLLR(:,ii,iii), 'red');
        plot(ncomp_values, pval_perm(:,ii,iii), 'green');
        plot(ncomp_values, pval_perm3(:,ii,iii), 'blue');
        plot(ncomp_values, pval_perm1p(:,ii,iii), 'cyan');
        plot(ncomp_values, pval_perm3p(:,ii,iii), 'magenta');
        legend('GLLR', 'perm', 'perm-f', 'perm_P', 'perm-f_P')
        saveas(gcf,sprintf('./Figures/pvalues_emb_%d_%d',iii,ii));
        saveas(gcf,sprintf('./Figures/pvalues_emd_%d_%d',iii,ii),'epsc');
    end
end

%% P-values in terms of the number of components in real data

load sim_real
for iii = 1:2 % 2 replicates
    for ii = 1:length(effectsize)
        % Plot p-values
        figure;
        ylabel('P-value'); xlabel('Number of components'); title(sprintf('Effect Size %d',effectsize(ii))); hold on
        plot(ncomp_values, pval_GLLR(:,ii,iii), 'red');
        plot(ncomp_values, pval_perm1(:,ii,iii), 'green');
        plot(ncomp_values, pval_perm3(:,ii,iii), 'blue');
        plot(ncomp_values, pval_perm1p(:,ii,iii), 'cyan');
        plot(ncomp_values, pval_perm3p(:,ii,iii), 'magenta');
        legend('GLLR', 'perm', 'perm-f', 'perm_P', 'perm-f_P')
        saveas(gcf,sprintf('./Figures/pvalues_real_%d_%d',iii,ii));
        saveas(gcf,sprintf('./Figures/pvalues_real_%d_%d',iii,ii),'epsc');
    end
end


