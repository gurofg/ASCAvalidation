%addpath(genpath('/mnt/work/RM_ASCA_LiMM_PCA_validation/'));

%% General settings
effectsize = 0:0.1:1
n_sim = 200;
iterations = 200;

% %% Low variance treatment effect, ncomp = 5.
% output_dir = './Script_2/';
% nrcomps = 5;
% expvar = 'low';
% center = 'off';
% 
% %powercurves_emb(output_dir, nrcomps, effectsize, expvar, n_sim, iterations, center)
% [VarLow5Comp1, VarLow5Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
% axis([effectsize(1:2) 0 1])
% saveas(gcf,'./VarLow5zoom');
% axis([effectsize([1 end]) 0 1])
% saveas(gcf,'./VarLow5');
% 
% %% Low variance treatment effect, ncomp = 50.
% output_dir = './Script_3/';
% nrcomps = 50;
% expvar = 'low';
% center = 'off';
% 
% %powercurves_emb(output_dir, nrcomps, effectsize, expvar, n_sim, iterations, center)
% [VarLow50Comp1, VarLow50Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
% axis([effectsize(1:2) 0 1])
% saveas(gcf,'./VarLow50zoom');
% axis([effectsize([1 end]) 0 1])
% saveas(gcf,'./VarLow50');
% 
%% High variance treatment effect, ncomp = 5.
output_dir = './Script_4/';
nrcomps = 5;
expvar = 'high';
center = 'off';

%powercurves_emb(output_dir, nrcomps, effectsize, expvar, n_sim, iterations, center)
[VarHigh5Comp1, VarHigh5Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
axis([effectsize(1:2) 0 1])
saveas(gcf,'./Figures/VarHigh5zoom');
axis([effectsize([1 end]) 0 1])
saveas(gcf,'./Figures/VarHigh5');

%% High variance treatment effect, ncomp = 50

effectsize = 0:0.1:0.3 % quitar
output_dir = './Script_6/';
nrcomps = 50;
expvar = 'high';
center = 'off';

%powercurves_emb(output_dir, nrcomps, effectsize, expvar, n_sim, iterations, center)
[VarHigh50Comp1, VarHigh50Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
axis([effectsize(1:2) 0 1])
saveas(gcf,'./Figures/VarHigh50zoom');
axis([effectsize([1 end]) 0 1])
saveas(gcf,'./Figures/VarHigh50');


%% Treatment effect in real data
effectsize = 0:0.025:0.25;
output_dir = './Script_1/';
nrcomps = 5;
center = 'off';

%powercurves_real(output_dir, nrcomps, effectsize, n_sim, iterations, center)
[VarLow5Comp1, VarLow5Comp2] = collect_results(output_dir, effectsize, n_sim, iterations)
axis([effectsize(1:2) 0 1])
saveas(gcf,'./Figures/VarRealzoom');
axis([effectsize([1 end]) 0 1])
saveas(gcf,'./Figures/VarReal');

% %% Figure
% 
% figure; hold on
% subplot(2,2,1)
% plot(VarLow5Comp1.effectsize, VarLow5Comp1.bootstrap_coverage_treatment', 'Color', 'b'); hold on
% plot(VarLow5Comp1.effectsize, VarLow5Comp1.GLLR_coverage_treatment', 'Color', 'r');
% plot(VarLow5Comp1.effectsize, VarLow5Comp1.perm_coverage_treatment', 'Color', 'g');
% plot(VarLow5Comp1.effectsize, VarLow5Comp1.perm_f_coverage_treatment', 'Color', 'y');
% 
% plot(VarLow5Comp2.effectsize, VarLow5Comp2.bootstrap_coverage_treatment', '--', 'Color', 'b'); hold on
% plot(VarLow5Comp2.effectsize, VarLow5Comp2.GLLR_coverage_treatment', '--', 'Color', 'r');
% plot(VarLow5Comp2.effectsize, VarLow5Comp2.perm_coverage_treatment', '--', 'Color', 'g');
% plot(VarLow5Comp2.effectsize, VarLow5Comp2.perm_f_coverage_treatment', '--', 'Color', 'y');
% ylabel('Coverage')
% title('VarLow/5 Comp')
% 
% subplot(2,2,2)
% plot(VarLow50Comp1.effectsize, VarLow50Comp1.bootstrap_coverage_treatment', 'Color', 'b'); hold on
% plot(VarLow50Comp1.effectsize, VarLow50Comp1.GLLR_coverage_treatment', 'Color', 'r');
% plot(VarLow50Comp1.effectsize, VarLow50Comp1.perm_coverage_treatment', 'Color', 'g');
% plot(VarLow50Comp1.effectsize, VarLow50Comp1.perm_f_coverage_treatment', 'Color', 'y');
% 
% plot(VarLow50Comp2.effectsize, VarLow50Comp2.bootstrap_coverage_treatment', '--', 'Color', 'b'); hold on
% plot(VarLow50Comp2.effectsize, VarLow50Comp2.GLLR_coverage_treatment', '--', 'Color', 'r');
% plot(VarLow50Comp2.effectsize, VarLow50Comp2.perm_coverage_treatment', '--', 'Color', 'g');
% plot(VarLow50Comp2.effectsize, VarLow50Comp2.perm_f_coverage_treatment', '--', 'Color', 'y');
% title('VarLow/50 Comp')
% 
% subplot(2,2,3)
% plot(VarHigh5Comp1.effectsize, VarHigh5Comp1.bootstrap_coverage_treatment', 'Color', 'b'); hold on
% plot(VarHigh5Comp1.effectsize, VarHigh5Comp1.GLLR_coverage_treatment', 'Color', 'r');
% plot(VarHigh5Comp1.effectsize, VarHigh5Comp1.perm_coverage_treatment', 'Color', 'g');
% plot(VarHigh5Comp1.effectsize, VarHigh5Comp1.perm_f_coverage_treatment', 'Color', 'y');
% 
% plot(VarHigh5Comp2.effectsize, VarHigh5Comp2.bootstrap_coverage_treatment', '--', 'Color', 'b'); hold on
% plot(VarHigh5Comp2.effectsize, VarHigh5Comp2.GLLR_coverage_treatment', '--', 'Color', 'r');
% plot(VarHigh5Comp2.effectsize, VarHigh5Comp2.perm_coverage_treatment', '--', 'Color', 'g');
% plot(VarHigh5Comp2.effectsize, VarHigh5Comp2.perm_f_coverage_treatment', '--', 'Color', 'y');
% ylabel('Coverage')
% xlabel('Effect size')
% title('VarHigh/5 Comp')
% 
% subplot(2,2,4)
% plot(VarHigh50Comp1.effectsize, VarHigh50Comp1.bootstrap_coverage_treatment', 'Color', 'b'); hold on
% plot(VarHigh50Comp1.effectsize, VarHigh50Comp1.GLLR_coverage_treatment', 'Color', 'r');
% plot(VarHigh50Comp1.effectsize, VarHigh50Comp1.perm_coverage_treatment', 'Color', 'g');
% plot(VarHigh50Comp1.effectsize, VarHigh50Comp1.perm_f_coverage_treatment', 'Color', 'y');
% 
% plot(VarHigh50Comp2.effectsize, VarHigh50Comp2.bootstrap_coverage_treatment', '--', 'Color', 'b'); hold on
% plot(VarHigh50Comp2.effectsize, VarHigh50Comp2.GLLR_coverage_treatment', '--', 'Color', 'r');
% plot(VarHigh50Comp2.effectsize, VarHigh50Comp2.perm_coverage_treatment', '--', 'Color', 'g');
% plot(VarHigh50Comp2.effectsize, VarHigh50Comp2.perm_f_coverage_treatment', '--', 'Color', 'y');
% xlabel('Effect size')
% legend(['NP bootstrap', 'GLLR', 'Perm','Perm F', 'NP bootstrap adj', 'GLLR adj', 'Perm adj', 'Perm F adj'], 'Location', 'SouthEast', 'FontSize',6)
% title('VarHigh/50 Comp')
% 
% export_fig('./figure_2', '-pdf');

