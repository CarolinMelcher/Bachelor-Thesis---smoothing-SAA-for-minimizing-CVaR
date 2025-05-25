This repository contains MATLAB scripts for minimizing Conditional Value at Risk (CVaR) using a smoothing sample average approximation approach. 

The main script **cvar_ssaa.m** implements the optimization routine: it generates Monte Carlo samples, smooths the CVaR objective via **psi_N.m**, and then calls fmincon to return the optimal portfolio weights, the CVaR value, the elapsed computation time, and the number of solver iterations. 

The helper function **psi_N.m** defines the smoothed CVaR objective used by cvar_ssaa. 

In addition, the script **cvar_lpa.m** solves the same CVaR problem via a linear programming approximation by introducing auxiliary variables and calling linprog, again returning portfolio weights, CVaR, runtime, and simplex iterations.

You can run a quick demo for both optimization methods by executing **run_example.m** in the MATLAB command window; it calls cvar_ssaa / cvar_lpa with preset parameters and prints the resulting weights, CVaR, time, and iterations. For more extensive parameter sweeps, use experiments.m, which loops over different sample sizes and confidence levels and assembles the results into a MATLAB table.

All plotting scripts and exported figures live in the plots folder. 
