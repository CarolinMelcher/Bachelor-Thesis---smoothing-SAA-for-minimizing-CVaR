function psi = psi_N(z, y, eps, alpha, N)
    % psi_N computes the smoothed CVaR objective for a given decision vector z
    % Inputs:
    %   z     - vector [weights; threshold u]
    %   y     - matrix of simulated returns (N x assets)
    %   eps   - smoothing parameter
    %   alpha - confidence level
    %   N     - number of samples

    % Extract weights and threshold
    x = z(1:3)';  % row vector of weights
    u = z(4);     % threshold

    % Loss function: Portfolio losses for each sample
    f_xy = -sum(y .* repmat(x, N, 1), 2);

    % Smoothed max{0, f_xy - u} calculation: (sqrt(4*eps^2 + (f_xy - u)^2) + (f_xy - u)) / 2
    phi_terms = (sqrt(4 * eps^2 + (f_xy - u).^2) + (f_xy - u)) / 2;
    Phi = sum(phi_terms);

    % Compute CVaR approximation: u + (1/((1-alpha)*N)) * Phi
    psi = u + (1 / (N * (1 - alpha))) * Phi;
end