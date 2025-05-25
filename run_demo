% A simple demonstration script for the cvar_ssaa and cvar_lpa optimizer 

% SSAA Example: optimize CVaR at 95% confidence with smoothing ε=10^-5 over 10^6 samples
[z, cvar, time, iterations] = cvar_ssaa(0.95, 10^-5, 10^6);

% LPA Example: optimize CVaR at 95% confidence over 10^4 samples
[z, cvar, time, iterations] = cvar_lpa(0.95, 10^4);

% Display results
fprintf("Portfolio weights: [%.4f, %.4f, %.4f]\n", z(1), z(2), z(3));
fprintf("Optimal CVaR:        %.4f\n", cvar);
fprintf("Elapsed time:       %.2f seconds\n", time);
fprintf("Iterations:         %d\n", iterations);
