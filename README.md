# ASCAvalidation
Matlab scripts for the manuscript "Statistical validation of multivariate treatment effects in longitudinal study designs" by Madssen et al.   

Reproduce Results:  
1 - Figure 2 can be reproduced with routine 11. Please, note computations are lengthy and were performed in a compunting server.  
2 - Figure 3 and 4, and Supplementary Figure 1, can be reproduced with routines 5 and 6.  
3 - Figure 5 can be reproduced with routine 4.  

Code Files:  

 1 - RM_LiMM_PCA_sim.m: Function for doing repeated measures-LiMM_PCA.  
 2 - RM_LiMM_PCA_sim_Pepe.m: Function for doing repeated measures-LiMM_PCA with permutations with Pepe's approach
    - Maybe replace the previous with this??? -- All routines but NeoAva call sim_Pepe.    
 3 - import_neoava_geneex.m: Imports NeoAva gene expression data.  
    - Warning: It assumes access to a folder outside the repo  
 4 - NeoAva.m: calls routines 3 and 1 nad generates the figure on NeoAva data  
    - Warning: It assumes access to a folder outside the repo, and actually duplicates the addition of the path in the previous routine  
 5 - pvalues_mvdata_emb.m: Generates figures of the p-values in terms of the number of components from simulated data with effects embedded in a specific component (calling routine 7) and the output is stored in D1; Calls routine 2 to fit LiMM_PCA models   
 6 - pvalues_mvdata_real.m: Generates figures of the p-values in terms of the number of components from simulated data with effects in the measured data (calling routine 8) and the output is stored in D2. Calls routine 2 to fit LiMM_PCA models.  
 7 - simulate_mvdata_emb.m: Simulates effects embedded in a specific component  
 8 - simulate_mvdata_real.m: Simulates effects in the measured data  
 9 - powercurves_emb.m: Generates power curves from simulated data with effects embedded in a specific component (calling routine 7). Calls routine 2 to fit LiMM_PCA models.  
10 - powercurves_real.m: Generates power curves from simulated data with effects in the measured data (calling routine 8). Calls routine 2 to fit LiMM_PCA models.  
11 - powercurves_script.m: Simulation script to generate power curves and to plot results using routine 12.   
    - The call to the powercurves (routines 9 and 10) is now commented to avoid this lengthy operation (which we performed in a server and stored in F2 to F4)  
12 - collect_results.m: Reads data from simulated results   

Data:  

D1 - pepe_sim_emb.mat: data simulated with effects embedded in a specific component  
D2 - pepe_sim.mat: data simulated with effects in the measured data   

Folders:  

F1 - Figures: figures obtained from routines 5 and 7  
F2 - Script1: data generated for power curves VarReal  
F3 - Script4: data generated for power curves VarHigh5  
F4 - Script6: data generated fro power curves VarHigh50  
