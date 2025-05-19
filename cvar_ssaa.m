function [z_optimal, cvar, time, iterations] = cvar_ssaa(alpha, eps, N)
    % CVaR_SSAA finds the portfolio weights that minimize Conditional Value at Risk (CVaR)
    % Inputs:
    %   alpha - confidence level for CVaR (e.g., 0.95)
    %   eps   - smoothing parameter for CVaR approximation
    %   N     - number of Monte Carlo samples
    % Outputs:
    %   z_optimal  - optimal vector [weights; threshold u]
    %   cvar       - minimized CVaR value
    %   time       - elapsed computation time in seconds
    %   iterations - number of iterations by the optimizer

    tic;  % start timer

    % Initial guess: equal weights for 3 assets, and threshold u = 0
    z0 = [1/3; 1/3; 1/3; 0];

    % Define expected returns and covariance matrix of the assets
    mean_return = [0.0101110, 0.0043532, 0.0137058];
    covariance_matrix = [0.00324625, 0.00022983, 0.00420395;
                         0.00022983, 0.00049937, 0.00019247;
                         0.00420395, 0.00019247, 0.00764097];

    % Generate N samples of asset returns from a multivariate normal distribution
    y = mvnrnd(mean_return, covariance_matrix, N);

    % Objective function handle for CVaR (uses external psi_N)
    objective = @(z) psi_N(z, y, eps, alpha, N);

    % Constraints: sum(weights) = 1
    Aeq = [ones(1, 3), 0]; beq = 1;
    % Bounds: weights >= 0, threshold u unbounded
    lb = [zeros(3, 1); -Inf];
    % Minimum return constraint: -mean_return * x >= -0.011 
    A = [-mean_return, 0]; b = -0.011;

    % Set up optimizer options and use SQP
    options = optimoptions('fmincon', 'Display', 'off', 'MaxIterations', 2000, 'Algorithm', 'sqp');

    % Run optimization 
    [z_optimal, cvar, ~, output] = fmincon(objective, z0, A, b, Aeq, beq, lb, [], [], options);
    iterations = output.iterations;

    % Stop timer
    time = toc;
end