function varargout = collect_results(output_dir, effectsize, n_sim, iterations)

warning('off', 'MATLAB:table:RowsAddedExistingVars');

for m = 1:length(effectsize)

    options.directory = output_dir;
    
    for s = 1:n_sim
        result_CI_treatment = load([options.directory  'CI_treatment'  num2str(s)  '_'  num2str(effectsize(m))   '_unconstrained'  '.txt']);
        result_pval_treatment = load([options.directory  'pval_treatment' num2str(s)  '_'  num2str(effectsize(m))  '_unconstrained'  '.txt']);
        result_pval_treatment_perm = load([options.directory  'pval_treatment_perm'  num2str(s)  '_'  num2str(effectsize(m))  '_unconstrained'  '.txt']);
        result_pval_treatment_perm_f = load([options.directory  'pval_treatment_perm_f'  num2str(s)  '_'  num2str(effectsize(m))   '_unconstrained'  '.txt']);

        coverage.CI_treatment(m,s) = result_CI_treatment;
        coverage.pval_treatment(m,s) = result_pval_treatment;
        coverage.pval_treatment_perm(m,s) = result_pval_treatment_perm;
        coverage.pval_treatment_perm_f(m,s) = result_pval_treatment_perm_f;

        result2_CI_treatment = load([options.directory  'CI_treatment' num2str(s)  '_'  num2str(effectsize(m))   '_constrained'  '.txt']);
        result2_pval_treatment = load([options.directory  'pval_treatment'  num2str(s)  '_'  num2str(effectsize(m))  '_constrained'  '.txt']);
        result2_pval_treatment_perm = load([options.directory  'pval_treatment_perm' num2str(s)  '_'  num2str(effectsize(m))  '_constrained'  '.txt']);
        result2_pval_treatment_perm_f = load([options.directory  'pval_treatment_perm_f' num2str(s)  '_'  num2str(effectsize(m))   '_constrained'  '.txt']);

        coverage2.CI_treatment(m,s) = result2_CI_treatment;
        coverage2.pval_treatment(m,s) = result2_pval_treatment;
        coverage2.pval_treatment_perm(m,s) = result2_pval_treatment_perm;
        coverage2.pval_treatment_perm_f(m,s) = result2_pval_treatment_perm_f;
    end
end

% Final coverage results
varargout{1} = table();
varargout{2} = table();

for m = 1:length(effectsize)
    varargout{1}.effectsize(m) = effectsize(m);
    varargout{1}.bootstrap_coverage_treatment(m) = 1-(sum(coverage.CI_treatment(m,:))/(n_sim));
    varargout{1}.GLLR_coverage_treatment(m) = sum(coverage.pval_treatment(m,:) < 0.05)/n_sim;
    varargout{1}.perm_coverage_treatment(m) = sum(coverage.pval_treatment_perm(m,:) < 0.05)/n_sim;
    varargout{1}.perm_f_coverage_treatment(m) = sum(coverage.pval_treatment_perm_f(m,:) < 0.05)/n_sim;

    varargout{2}.effectsize(m) = effectsize(m);
    varargout{2}.bootstrap_coverage_treatment(m) = 1-(sum(coverage2.CI_treatment(m,:))/(n_sim));
    varargout{2}.GLLR_coverage_treatment(m) = sum(coverage2.pval_treatment(m,:) < 0.05)/n_sim;
    varargout{2}.perm_coverage_treatment(m) = sum(coverage2.pval_treatment_perm(m,:) < 0.05)/n_sim;
    varargout{2}.perm_f_coverage_treatment(m) = sum(coverage2.pval_treatment_perm_f(m,:) < 0.05)/n_sim;
end

% Power curves
figure
plot(varargout{1}.effectsize, varargout{1}.bootstrap_coverage_treatment', 'Color', 'b'); hold on
plot(varargout{1}.effectsize, varargout{1}.GLLR_coverage_treatment', 'Color', 'r');
plot(varargout{1}.effectsize, varargout{1}.perm_coverage_treatment', 'Color', 'g');
plot(varargout{1}.effectsize, varargout{1}.perm_f_coverage_treatment', 'Color', 'y');

plot(varargout{2}.effectsize, varargout{2}.bootstrap_coverage_treatment', '--', 'Color', 'b'); hold on
plot(varargout{2}.effectsize, varargout{2}.GLLR_coverage_treatment', '--', 'Color', 'r');
plot(varargout{2}.effectsize, varargout{2}.perm_coverage_treatment', '--', 'Color', 'g');
plot(varargout{2}.effectsize, varargout{2}.perm_f_coverage_treatment', '--', 'Color', 'y');
xlabel('Effect size')
ylabel('Coverage')
legend('NP bootstrap', 'GLLR', 'perm','perm f', 'NP bootstrap adj', 'GLLR adj', 'perm adj', 'perm f adj', 'Location', 'SouthEast')
