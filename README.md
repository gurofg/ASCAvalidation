# ASCAvalidation
Matlab scripts for the manuscript "Statistical validation of multivariate treatment effects in longitudinal study designs" by Madssen et al.   

Reproduce Results:  
1 - Figure 2 can be reproduced with routine 1. Please, note computations are lengthy and were performed in a computing server.  
2 - Figures 3 and 4, and Supplementary Figure 1, can be reproduced with routines 2 and 3.  
3 - Figure 5 can be reproduced with routine 4.  

Code Files:  

 1 - powercurves_script.m: Simulation script to generate power curves (routines 9 and 10) and to plot results (routine 11).   
    - The call to the powercurves (routines 9 and 10) is now commented to avoid this lengthy operation (which we performed in a server and stored in F2 to F4)  
 2 - pvalues_mvdata_real.m: Generates figures of the p-values in terms of the number of components from simulated data with effects in the measured data (calling routine 7) and the output is stored in D1. Calls routine 5 to fit LiMM_PCA models.
 3 - pvalues_mvdata_emb.m: Generates figures of the p-values in terms of the number of components from simulated data with effects embedded in a specific component (calling routine 8) and the output is stored in D2. Calls routine 5 to fit LiMM_PCA models.  
 4 - NeoAva.m: calls routines 5 and 6 and generates the figure on NeoAva data  
    - Warning: It assumes access to a folder outside the repo, and actually duplicates the addition of the path in the previous routine    
 5 - RM_LiMM_PCA_sim.m: Function for doing repeated measures-LiMM_PCA.     
 6 - import_neoava_geneex.m: Imports NeoAva gene expression data.  
    - Warning: It assumes access to a folder outside the repo  
 7 - simulate_mvdata_real.m: Simulates effects in the measured data  
 8 - simulate_mvdata_emb.m: Simulates effects embedded in a specific component  
 9 - powercurves_real.m: Generates power curves from simulated data with effects in the measured data (calling routine 7). Calls routine 5 to fit LiMM_PCA models.  
10 - powercurves_emb.m: Generates power curves from simulated data with effects embedded in a specific component (calling routine 8). Calls routine 5 to fit LiMM_PCA models.  
11 - collect_results.m: Reads data from simulated results   

Data:  

D1 - sim_real.mat: data simulated with effects in the measured data   
D2 - sim_emb.mat: data simulated with effects embedded in a specific component  

Folders:  

F1 - Figures: figures obtained from routines 5 and 7  
F2 - Script1: data generated for power curves VarReal  
F3 - Script4: data generated for power curves VarHigh5  
F4 - Script6: data generated fro power curves VarHigh50  
