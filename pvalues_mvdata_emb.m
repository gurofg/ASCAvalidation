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

effectsize = 0:0.06:0.3
expvar = 'high';
for iii = 1:2 % 2 replicates
    for ii = 1:length(effectsize)
        ii
        
        rng(iii) % seed for the replicate
        
        data = simulate_mvdata_emb(samplesize, j, A, d, effectsize(ii), expvar); % function for simulating multivariate data
        options.Y_vars = data.Properties.VariableNames(30:end);
        
        parfor i = 1:length(ncomp_values)
            i
            options2 = options;
            options2.ncomp = ncomp_values(i);
            %         [~, M_B, ~] = RM_LiMM_PCA_sim(data, options2);
            %         pval_GLLR(i,ii) = M_B.pval;
            %         pval_perm(i,ii) = M_B.pval_perm;
            %         pval_perm3(i,ii) = M_B.pval_perm3;
            [~, M_B, ~] = RM_LiMM_PCA_sim_Pepe(data, options2);
            pval_GLLR_Pepe_emb(i,ii,iii) = M_B.pval;
            pval_perm_Pepe_emb(i,ii,iii) = M_B.pval_perm;
            pval_perm3_Pepe_emb(i,ii,iii) = M_B.pval_perm3;
        end
        
        % Plot p-values
        
        %     figure;
        %     ylabel('P-value'); xlabel('Number of components'); title(sprintf('Effect Size %d',effectsize(ii))); hold on
        %     plot(ncomp_values, pval_GLLR(:,ii), 'red');
        %     plot(ncomp_values, pval_perm(:,ii), 'green');
        %     plot(ncomp_values, pval_perm3(:,ii), 'blue');
        %     legend('GLLR', 'perm', 'perm-f')
        
        figure;
        ylabel('P-value'); xlabel('Number of components'); title(sprintf('Effect Size %d',effectsize(ii))); hold on
        plot(ncomp_values, pval_GLLR_Pepe_emb(:,ii,iii), 'red');
        plot(ncomp_values, pval_perm_Pepe_emb(:,ii,iii), 'green');
        plot(ncomp_values, pval_perm3_Pepe_emb(:,ii,iii), 'blue');
        legend('GLLR', 'perm', 'perm-f')
        
        save sim_emb
        
    end
end


