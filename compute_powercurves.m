%% EXAMPLES of Madssen et al. "Statistical validation of multivariate 
% treatment effects in longitudinal study designs". Submitted to Journal of
% Chemometrics, 2025. This example generates relative population power
% curves (see Journal of Chemometrics, 2024, 38 (12): e3596
%
% coded by: Torfinn Støve Madssen (torfinn.s.madssen@ntnu.no)
%       Jose Camacho Paez (josecamacho@ugr.es)
% last modification: 31/March/2025
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

% n_sim = 200;
% iterations = 200;
% 
% %% High variance treatment effect, ncomp = 5.
% 
% effect = [0,.5,1,1] % zero treatment effect, small time effect, moderate individual effect, moderate interaction
% effectsize = 0:0.1:1
% output_dir = './Script_Emb/';
% nrcomps = 5;
% expvar = 'high';
% center = 'off';
% 
% powercurves_emb(output_dir, nrcomps, effectsize, expvar, n_sim, iterations, center, effect)


%% Treatment effect in real data

effect = [0,.5,2,1] % zero treatment effect, small time effect, large individual effect, moderate interaction
effectsize = 0:0.04:0.4;
output_dir = './Script_Real/';
nrcomps = 5;
center = 'off';

powercurves_real(output_dir, nrcomps, effectsize, n_sim, iterations, center, effect)


