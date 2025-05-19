This repository contains MATLAB scripts for minimizing Conditional Value at Risk (CVaR) using a smoothing sample average approximation approach. 

The main script **cvar_ssaa.m** implements the optimization routine and returns the optimal portfolio weights, the CVaR value, the elapsed computation time, and the number of solver iterations. The optimizer uses **psi_N**, where the smoothed CVaR objective is defined.
