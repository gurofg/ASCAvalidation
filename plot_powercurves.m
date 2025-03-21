%% EXAMPLES of Madssen et al. "Statistical validation of multivariate 
% treatment effects in longitudinal study designs". Submitted to Journal of
% Chemometrics, 2025. This example generates relative population power
% curves (see Journal of Chemometrics, 2024, 38 (12): e3596
%
% coded by: Torfinn Støve Madssen (torfinn.s.madssen@ntnu.no)
%       Jose Camacho Paez (josecamacho@ugr.es)
% last modification: 20/March/2025
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
effectsize = 0:0.1:1
n_sim = 200;
iterations = 200;

%% High variance treatment effect, ncomp = 5.

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

effectsize = 0:0.1:0.3 % quitar
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

effectsize = 0:0.025:0.25;
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


