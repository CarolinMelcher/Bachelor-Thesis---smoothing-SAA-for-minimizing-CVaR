% Code for comparison of SSAA vs. LPA (Section 6.2.1)
% CVaR optimization over different sample sizes and confidence levels.
% This example demonstrates the SSAA. Results for the LPA are easily obtained by switching the optimizer to cvar_lpa and omiting the smoothing parameter.

% Define parameter grids
Nval = [5000, 10000, 25000, 45000];   % Monte Carlo sample counts
alphas = [0.90, 0.95, 0.99];               % CVaR confidence levels
eps = 10^-5;                               % Smoothing parameter ε

% Preallocate result matrix 
results = zeros(length(alphas)*length(Nval), 9);

index = 1;
for i = 1:length(alphas)
    for k = 1:length(Nval)

        % Run the CVaR optimizer
        [x, cvarVal, iterCount, elapsedTime] = cvar_ssaa(alphas(i), eps, Nval(k));

        results(index,1) = round(alphas(i), 5);
        results(index,2) = round(Nval(k), 5);
        results(index,3:5) = round(100*x(1:end-1)', 5);
        results(index,6) = round(100*cvarVal, 5);
        results(index,7) = round(100*x(end), 5);
        results(index,8) = round(iterCount, 5);
        results(index,9) = round(elapsedTime, 5);
        index = index + 1;
    end
end

% Convert to table 
T = array2table(results, 'VariableNames', ...
    {'Alpha','N','x1','x2','x3','CVaR','VaR','Time_s','Iterations'});


