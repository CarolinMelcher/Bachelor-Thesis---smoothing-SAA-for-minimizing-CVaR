% Code for Figure 3: CVaR as sample size N grows

n_evaluations = 250;                               % Number of evaluations
n = round(logspace(2, 7, n_evaluations));          % Generate 50 sample sizes logarithmically spaced between 10^2 and 10^7

% Preallocation of arrays for the results
t = zeros(length(n), 1);              % Execution times
iterations = zeros(length(n), 1);     % Iteration counts
c = zeros(length(n), 1);              % CVaR values

% Loop over each sample size to compute CVaR, execution time, and iterations
for i = 1:n_evaluations
    [~, cvar, time, iter] = cvar_optimized(0.99, 10^-4, n(i));  % Call optimizer at 99% confidence, ε=10^-4, N=n(i)
    c(i)   = cvar;   
    t(i)  = time;    
    iterations(i) = iter;      
end

% Plot 
figure;
plot(n, c, 'k-', 'MarkerSize', 8);   
set(gca, 'XScale', 'log');            
xlabel('Sample Size N', 'Interpreter', 'latex');
ylabel('CVaR', 'Interpreter', 'latex');
set(gca, 'TickLength', [0 0]);       
grid off;                            
