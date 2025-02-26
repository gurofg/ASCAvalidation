# ASCAvalidation
Matlab scripts for the manuscript "Statistical validation of multivariate treatment effects in longitudinal study designs" by Madssen et al. 

Code Files:

 1 - RM_LiMM_PCA_sim.m: Function for doing repeated measures-LiMM_PCA.
 2 - RM_LiMM_PCA_sim_Pepe.m: Function for doing repeated measures-LiMM_PCA with permutations with Pepe's approach
    - Maybe replace the previous with this??? -- All routines but NeoAva call sim_Pepe
 3 - import_neoava_geneex.m: Imports NeoAva gene expression data
    - Warning: It assumes access to a folder outside the repo
 4 - NeoAva.m: calls routines 3 and 1
    - Warning: It assumes access to a folder outside the repo, and actually duplicates the addition of the path in the previous routine
 5 - emulate_neoava_emb.m: Generates figures of the p-values in terms of the number of components from simulated data with effects embedded in a specific component (calling routine 6) and the output is stored in D1.  Calls routine 2 to fit LiMM_PCA models. 
 6 - simulate_mvdata_emb.m: Simulates effects embedded in a specific component
 7 - emulate_neoava.m: Generates figures of the p-values in terms of the number of components from simulated data with effects in the measured data (calling routine 8) and the output is stored in D2. Calls routine 2 to fit LiMM_PCA models.
 8 - simulate_mvdata_real.m: Simulates effects in the measured data
 9 - powercurves_emb.m: Generates power curves from simulated data with effects embedded in a specific component (calling routine 6). Calls routine 2 to fit LiMM_PCA models.
10 - powercurves_real.m: Generates power curves from simulated data with effects in the measured data (calling routine 8). Calls routine 2 to fit LiMM_PCA models.
11 - simulation_script_codaslab.m: Simulation script to generate power curves and to plot results using routine 12
    - The call to the powercurves is now commented to avoid this lengthy operation (which we performed in a server and stored in F2 to F4)
12 - collect_results.m: Reads data from simulated results 

Data:

D1 - pepe_sim_emb.mat: data simulated with effects embedded in a specific component
D2 - pepe_sim.mat: data simulated with effects in the measured data 

Folders:

F1 - Figures: figures obtained from routines 5 and 7
F2 - Script1: data generated for power curves VarReal
F3 - Script4: data generated for power curves VarHigh5
F4 - Script6: data generated fro power curves VarHigh50