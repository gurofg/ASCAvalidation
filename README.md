# ASCAvalidation
Matlab scripts for the manuscript "Statistical validation of multivariate treatment effects in longitudinal study designs" by Madssen et al.   

Reproduce Results:  
1 - Figure 2 can be reproduced with routine 1. Please, note computations are lengthy and were performed in a compunting server.  
2 - Figures 3 and 4, and Supplementary Figure 1, can be reproduced with routines 2 and 3.  
3 - Figure 5 can be reproduced with routine 4.  

Code Files:  

 1 - powercurves_script.m: Simulation script to generate power curves (routines 10 and 11) and to plot results (routine 12).   
    - The call to the powercurves (routines 10 and 11) is now commented to avoid this lengthy operation (which we performed in a server and stored in F2 to F4)  
 2 - pvalues_mvdata_real.m: Generates figures of the p-values in terms of the number of components from simulated data with effects in the measured data (calling routine 9) and the output is stored in D2. Calls routine 6 to fit LiMM_PCA models.
 3 - pvalues_mvdata_emb.m: Generates figures of the p-values in terms of the number of components from simulated data with effects embedded in a specific component (calling routine 8) and the output is stored in D1; Calls routine 6 to fit LiMM_PCA models   
 4 - NeoAva.m: calls routines 7 and 5 and generates the figure on NeoAva data  
    - Warning: It assumes access to a folder outside the repo, and actually duplicates the addition of the path in the previous routine    
 5 - RM_LiMM_PCA_sim.m: Function for doing repeated measures-LiMM_PCA.  
 6 - RM_LiMM_PCA_sim_Pepe.m: Function for doing repeated measures-LiMM_PCA with permutations with Pepe's approach
    - Maybe replace the previous with this??? -- All routines but NeoAva call sim_Pepe.    
 7 - import_neoava_geneex.m: Imports NeoAva gene expression data.  
    - Warning: It assumes access to a folder outside the repo  
 8 - simulate_mvdata_emb.m: Simulates effects embedded in a specific component  
 9 - simulate_mvdata_real.m: Simulates effects in the measured data  
10 - powercurves_emb.m: Generates power curves from simulated data with effects embedded in a specific component (calling routine 8). Calls routine 6 to fit LiMM_PCA models.  
11 - powercurves_real.m: Generates power curves from simulated data with effects in the measured data (calling routine 9). Calls routine 6 to fit LiMM_PCA models.  
12 - collect_results.m: Reads data from simulated results   

Data:  

D1 - pepe_sim_emb.mat: data simulated with effects embedded in a specific component  
D2 - pepe_sim.mat: data simulated with effects in the measured data   

Folders:  

F1 - Figures: figures obtained from routines 5 and 7  
F2 - Script1: data generated for power curves VarReal  
F3 - Script4: data generated for power curves VarHigh5  
F4 - Script6: data generated fro power curves VarHigh50  
