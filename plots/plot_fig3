% Code for Figure 3: Computational time as epsilon goes to zero

% Parameters
e       = 100;                   % number of ε values
epsilon = logspace(-2, -6, e);   % smoothing parameters from 1e-2 to 1e-6
M       = 10;                    % repetitions per ε

% Preallocate timing matrix
times = zeros(e, M);

% Measure runtimes
for i = 1:e
    for j = 1:M
        [~, ~, t, ~] = cvar_ssaa(0.99, epsilon(i), 1e5);
        times(i, j) = t;
    end
end

% Compute mean runtimes
mean_times = mean(times, 2);

% Plot mean runtime vs. ε
figure;
plot(epsilon, mean_times, 'k-', 'LineWidth', 1.5);
hold on;
set(gca, 'XScale', 'log', 'XDir', 'reverse');
xlim([1e-6, 1e-2]);
grid off;
set(gca, 'TickLength', [0 0]);
xlabel('Smoothing Parameter $\varepsilon$', 'Interpreter', 'latex');
ylabel('Time (s)',                    'Interpreter', 'latex');
hold off;
