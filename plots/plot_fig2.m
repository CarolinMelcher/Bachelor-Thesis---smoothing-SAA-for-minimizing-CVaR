% Code for Figure 1: CVaR values as the smoothing parameter is driven to zero
% Number of smoothing parameters to evaluate
e = 50;

% Logarithmically spaced ε values from 10^(-1) down to 10^(-6)
epsilon = logspace(-1, -6, e);

% Preallocate vector for CVaR results
c = zeros(e,1);

% Compute CVaR for each ε
for i = 1:e
    [~, cvar, ~, ~] = cvar_ssaa(0.99, epsilon(i), 10^6);
    c(i) = cvar;
end

% Plot
figure;
plot(epsilon, c, 'k-');            
set(gca, 'XScale', 'log');        
set(gca, 'XDir', 'reverse');      
set(gca, 'XGrid', 'off');          
set(gca, 'TickLength', [0 0]);     

% Label axes 
xlabel('Smoothing Parameter $\varepsilon$', 'Interpreter', 'latex');
ylabel('CVaR', 'Interpreter', 'latex');

% Add horizontal reference line at CVaR = 0.153
yline(0.153, 'k:', 'LineWidth', 1);

grid off;
