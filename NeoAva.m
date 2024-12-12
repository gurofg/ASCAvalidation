%% NeoAva gene expression analysis
addpath(genpath('/mnt/work/RM_ASCA_LiMM_PCA_validation/New_analysis'));

% Import data
import_neoava_geneex

% Specify RM-LiMM-PCA modeling options
options.iterations = 500;
options.baseline = "cLDA"; % Constrain the baseline means
options.coding = "PRC"; % Use reference coding for the treatment factor
options.ncomp = 258;
options.GLLR = "yes";
options.permute = "yes";
options.newID = "false";
options.CI = "yes";
options.center = "off";
options.Y_vars = data.Properties.VariableNames(30:end);

% Main analysis
[M_A, M_B, M_C, ZU, E, Y_model] = RM_LiMM_PCA_sim(data, options);

%% Figure
figure
subplot(1,2,1)
timepoints = unique(data.timepoint);
treatments = unique(data.treatment);

%  Plotting Time scores
for i = 1:length(unique(timepoints))
    id(i) = find(data.timepoint==timepoints(i), 1, 'first');
end

hold on 
errorbar([0:length(timepoints)-1], M_A.scores(id,1)', M_A.scores(id,1)'-prctile(M_A.scores_boot{1}, 2.5), prctile(M_A.scores_boot{1}, 97.5) - M_A.scores(id,1)')
set(gca,'XTick',[0:length(timepoints)-1]);
ylabel("PC1 (" + num2str((M_A.eigen(1)/sum(M_A.eigen))*100, '%.2f') + "%)", "FontSize",8)
xlabel("Timepoint", "FontSize", 8)
title("Time factor", 'FontSize',8)
grid on
hold off

% Plotting Time*Treatment scores
subplot(1,2,2)
hold on 
set(gca, 'xtick', []);
grid on
title("Time*Treatment interaction", "FontSize", 8)
ylabel("PC1 (" + num2str((M_B.eigen(1)/sum(M_B.eigen))*100, '%.2f') + " %)", 'FontSize', 8);
xlabel("Timepoint", "FontSize", 8)
for d = 1:length(treatments)
    for k = 1:length(timepoints)
        id(k) = find(data.timepoint == timepoints(k) & data.treatment == treatments(d), 1, 'first');
    end
    errorbar([0:length(unique(timepoints))-1], M_B.scores(id,1)', M_B.scores(id,1)' - prctile(M_B.scores_boot{1,d}, 2.5), prctile(M_B.scores_boot{1,d}, 97.5) - M_B.scores(id,1)')
end
set(gca,'XTick',[0:length(timepoints)-1]);
legend({'CTX', 'CTX + Bev'}, 'FontSize', 4, 'Location', 'NorthWest') %, 'FontSize', 4, 'Position', [0.5,2,1,1])
grid on
hold off

export_fig('/mnt/work/RM_ASCA_LiMM_PCA_validation/New_analysis/Figures/figure_NeoAva', '-pdf');

%% Check how p-value changes with increasing component number

ncomp_values = [1:2:10,20:10:260];
options.plot = "off";
options.CI = "off";
options.iterations = 500;
options.directory = "/mnt/work/RM_ASCA_LiMM_PCA_validation/New_analysis/temporary/pvalues_NeoAva/";

parfor i = 1:length(ncomp_values)
    options2 = options;
    options2.ncomp = ncomp_values(i);
    [~, M_B, ~] = RM_LiMM_PCA_sim(data, options2);
    writematrix(M_B.pval, options.directory + "pval_GLLR" + ncomp_values(i) + ".txt");
    writematrix(M_B.pval_perm1, options.directory + "pval_perm1_" + ncomp_values(i) + ".txt");
    writematrix(M_B.pval_perm2, options.directory + "pval_perm2_" + ncomp_values(i) + ".txt");
    writematrix(M_B.pval_perm3, options.directory + "pval_perm3_" + ncomp_values(i) + ".txt");
end

% Plot p-values

for i = 1:length(ncomp_values)
    pval_GLLR(i) = readmatrix(options.directory + "pval_GLLR" + ncomp_values(i) + ".txt");
    pval_perm1(i) = readmatrix(options.directory + "pval_perm1_" + ncomp_values(i) + ".txt");    pval_perm(i) = readmatrix(options.directory + "pval_perm1_" + ncomp_values(i) + ".txt");
    % pval_perm2(i) = readmatrix(options.directory + "pval_perm2_" + ncomp_values(i) + ".txt");
    pval_perm3(i) = readmatrix(options.directory + "pval_perm3_" + ncomp_values(i) + ".txt");
end

figure;
ylabel("P-value"); xlabel("Number of components"); hold on
plot(ncomp_values, pval_GLLR, 'red');
plot(ncomp_values, pval_perm1, 'green');
% plot(ncomp_values, pval_perm2, 'black');
plot(ncomp_values, pval_perm3, 'black');

legend(["GLLR-test", "Permutation test (SSQ)", "Permutation test (F-ratio)"])
export_fig('/mnt/work/RM_ASCA_LiMM_PCA_validation/New_analysis/Figures/figure_pvalcurve', '-pdf');
