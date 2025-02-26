function powercurves_real(output_dir, nrcomps, effectsize, n_sim, iterations, center)

% Specify simulation settings
j = 200; % number of manifest variables to simulate in Y
A = 100; % number of significant variables
samplesize =  50;

% Specify RM-LiMM-PCA modeling options
options.iterations = iterations;
options.baseline = 'ucLDA'; % Constrain the baseline means
options.coding = 'PRC'; % Use reference coding for the treatment factor
options.ncomp = nrcomps;
options.GLLR = 'yes';
options.permute = 'yes';
options.CI = 'yes';
options.newID = 'false';
options.plot = 'yes'; % Turn off automatic plotting
options.directory = output_dir; 
options.center = center;

% fprintf('running powercurves with the following settings:\nncores:%d\noutput_dir:%s\nnrcomps:%d\n,effectsize:%d\n',ncores,output_dir,nrcomps,effectsize);

data = simulate_mvdata_real(samplesize, j, A, effectsize(1)); % function for simulating multivariate data
options.Y_vars = data.Properties.VariableNames(4:end);

options2 = options;
options2.baseline = 'cLDA';

%% Simulation loop

for m = 1:length(effectsize)

    parfor s = 1:n_sim
    
        data = simulate_mvdata_real(samplesize, j, A, effectsize(m));
        
        tic
        [~, M_B, ~] = RM_LiMM_PCA_sim_Pepe(data, options);
        toc
        tic
        [~, M_B2, ~] = RM_LiMM_PCA_sim(data, options);
        toc
        
%         CI_treatment = fixed.Interval(prctile(M_B.scores_boot{1,2}, [2.5]), prctile(M_B.scores_boot{1,2}, [97.5]));
%         CI_control = fixed.Interval(prctile(M_B.scores_boot{1,1}, [2.5]), prctile(M_B.scores_boot{1,1}, [97.5]));
%     
%         coverage_B = overlaps(CI_treatment(2), CI_control(2));  
        
        CI_treatment = [prctile(M_B.scores_boot{1,2}, [2.5]), prctile(M_B.scores_boot{1,2}, [97.5])];
        CI_control = [prctile(M_B.scores_boot{1,1}, [2.5]), prctile(M_B.scores_boot{1,1}, [97.5])];
        coverage_B = ~((CI_treatment(4) < CI_control(2)) || (CI_treatment(2) > CI_control(4)));      
     
        p_B = M_B.pval;
        p_B_perm = M_B.pval_perm;
        p_B_perm_f = M_B.pval_perm3;
    
        writematrix(coverage_B,[options.directory 'CI_treatment'  num2str(s)  '_'  num2str(effectsize(m))  '_unconstrained'  '.txt']);
        writematrix(p_B,[options.directory 'pval_treatment'  num2str(s)  '_'  num2str(effectsize(m))  '_unconstrained'  '.txt']);
        writematrix(p_B_perm,[options.directory 'pval_treatment_perm'  num2str(s)  '_'  num2str(effectsize(m))  '_unconstrained'  '.txt']);
        writematrix(p_B_perm_f,[options.directory 'pval_treatment_perm_f'  num2str(s)  '_'  num2str(effectsize(m))  '_unconstrained'  '.txt']);
    
        [~, M_B2, ~] = RM_LiMM_PCA_sim_Pepe(data, options2);
    
%         CI_treatment2 = fixed.Interval(prctile(M_B2.scores_boot{1,2}, [2.5]), prctile(M_B2.scores_boot{1,2}, [97.5]));
%         CI_control2 = fixed.Interval(prctile(M_B2.scores_boot{1,1}, [2.5]), prctile(M_B2.scores_boot{1,1}, [97.5]));
%     
%         coverage_B2 = overlaps(CI_treatment2(2), CI_control2(2));

        CI_treatment2 = [prctile(M_B2.scores_boot{1,2}, [2.5]), prctile(M_B2.scores_boot{1,2}, [97.5])];
        CI_control2 = [prctile(M_B2.scores_boot{1,1}, [2.5]), prctile(M_B2.scores_boot{1,1}, [97.5])];
        coverage_B2 = ~((CI_treatment2(4) < CI_control2(2)) || (CI_treatment2(2) > CI_control2(4))); 
        
        p_B2 = M_B2.pval;
        p_B2_perm = M_B2.pval_perm;
        p_B2_perm_f = M_B2.pval_perm3;
    
        writematrix(coverage_B2,[options.directory 'CI_treatment'  num2str(s)  '_'  num2str(effectsize(m))  '_constrained'  '.txt']);
        writematrix(p_B2,[options.directory 'pval_treatment'  num2str(s)  '_'  num2str(effectsize(m))  '_constrained'  '.txt']);
        writematrix(p_B2_perm,[options.directory 'pval_treatment_perm'  num2str(s)  '_'  num2str(effectsize(m))  '_constrained'  '.txt']);
        writematrix(p_B2_perm_f,[options.directory 'pval_treatment_perm_f'  num2str(s)  '_'  num2str(effectsize(m))  '_constrained'  '.txt']);
        
%         writematrix(coverage_B2, options.directory + 'CI_treatment' + s + '_' + effectsize(m) + '_constrained' + '.txt');
%         writematrix(p_B2, options.directory + 'pval_treatment' + s + '_' + effectsize(m) + '_constrained' + '.txt');
%         writematrix(p_B2_perm, options.directory + 'pval_treatment_perm' + s + '_' + effectsize(m) + '_constrained' + '.txt');
%         writematrix(p_B2_perm_f, options.directory + 'pval_treatment_perm_f' + s + '_' + effectsize(m) + '_constrained' + '.txt');
        
    end
end

