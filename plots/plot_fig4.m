% Code for Figure 3: CVaR as sample size N grows

n_evaluations = 250;                               % Number of evaluations
n = round(logspace(2, 7, n_evaluations));          % Generate 250 sample sizes logarithmically spaced between 10^2 and 10^7

% Preallocation of array for the results
t = zeros(length(n), 1);              % Execution times

% Loop over each sample size to compute execution time
for i = 1:n_evaluations
    [~, ~, time, ~] = cvar_ssaa(0.99, 10^-4, n(i));  % Call optimizer at 99% confidence, ε=10^-4, N=n(i)
    t(i)   = time;         
end

% Plot
figure;
plot(n, t, 'k-', 'MarkerSize', 8); % Blau für Zeit
set(gca, 'XScale', 'log'); % Logarithmische Skala für x-Achse
xlabel('Sample Size N', 'Interpreter','latex');
ylabel('Time (s)', 'Interpreter','latex');
set(gca, 'XTick', get(gca, 'XTick')); 
set(gca, 'YTick', get(gca, 'YTick')); 
set(gca, 'TickLength', [0 0]); 
grid off;
