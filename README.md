# ASCAvalidation
Matlab scripts for the manuscript "Statistical validation of multivariate treatment effects in longitudinal study designs" by Madssen et al.   

Reproduce Results:  
1 - Figure 2 can be reproduced with routine 1 (computations are lengthy and were performed in a computing server) and visualizations with routine 2.  
2 - Figures 3 and 4, and Supplementary Figure 1, can be reproduced with routines 3 and 4  (computations are lengthy and were performed in a computing server) and visualizations with routine 2.  
3 - Figure 5 can be reproduced with routine 5.  

Code Files:  

 1 - compute_powercurves.m: Simulation script to generate power curves (using routines 10 and 11). 
 2 - plot_powercurves.m: Script to plot power curves (using routine 12)  
 3 - pvalues_mvdata_real.m: Generates figures of the p-values in terms of the number of components from simulated data with effects in the measured data (calling routine 8) and the output is stored in D1. Calls routine 6 to fit LiMM_PCA models.
 4 - pvalues_mvdata_emb.m: Generates figures of the p-values in terms of the number of components from simulated data with effects embedded in a specific component (calling routine 9) and the output is stored in D2. Calls routine 6 to fit LiMM_PCA models.  
 5 - NeoAva.m: calls routines 5 and 6 and generates the figure on NeoAva data  
    - Warning: It assumes access to a folder outside the repo, and actually duplicates the addition of the path in the previous routine    
 6 - RM_LiMM_PCA_sim.m: Function for doing repeated measures-LiMM_PCA.     
 7 - import_neoava_geneex.m: Imports NeoAva gene expression data.  
    - Warning: It assumes access to a folder outside the repo  
 8 - simulate_mvdata_real.m: Simulates effects in the measured data  
 9 - simulate_mvdata_emb.m: Simulates effects embedded in a specific component  
10 - powercurves_real.m: Generates power curves from simulated data with effects in the measured data (calling routine 7). Calls routine 6 to fit LiMM_PCA models.  
11 - powercurves_emb.m: Generates power curves from simulated data with effects embedded in a specific component (calling routine 8). Calls routine 6 to fit LiMM_PCA models.  
12 - collect_results.m: Reads data from simulated results  
13 - preprocess2D.m: auxiliary fuction taken from the MEDA Toolbox v1.3  
14 - create_design.m: auxiliary fuction taken from the MEDA Toolbox v1.3  

Data:  

D1 - sim_real.mat: data simulated with effects in the measured data   
D2 - sim_emb.mat: data simulated with effects embedded in a specific component  

Folders:  

F1 - Figures: figures obtained from routines 5 and 7  
F2 - Script_Real: data generated for power curves VarReal  
F3 - Script_5: data generated for power curves VarHigh5  
F4 - Script_50: data generated fro power curves VarHigh50  
