function [x, cvar, time, iterations] = cvar_lpa(alpha, N)
% cvar_lpa  Solves the CVaR optimization problem via an LP approximation.
%
%   [x, cvar, time, iterations] = cvar_lpa(alpha, N)
%
%   Inputs:
%     alpha       – confidence level in (0,1)
%     N           – number of Monte-Carlo samples 
%
%   Outputs:
%     (x,u)       – optimal portfolio weights (n+1×1)
%     cvar        – optimal CVaR value (objective function)
%     time        – elapsed solution time in seconds
%     iterations  – number of simplex iterations used

    %% 1) problem data 
    R                   = 0.011;                        % target minimum return
    mean_return         = [0.0101110; 0.0043532; 0.0137058];
    covariance_matrix   = [0.00324625, 0.00022983, 0.00420395;
                           0.00022983, 0.00049937, 0.00019247;
                           0.00420395, 0.00019247, 0.00764097];
    n = numel(mean_return);                            % number of assets

    % Generate N scenarios of asset returns
    Y = mvnrnd(mean_return, covariance_matrix, N);

    %% 2) LP in standard form
    nv = n + 1 + N;                                     % decision variables: x (n), u (1), v (N)
    f  = zeros(nv, 1);
    f(n+1)       = 1;                                   % coefficient for u (VaR)
    f(n+2:end)   = 1/(N*(1-alpha));                     % coefficients for v_j

    % Inequality constraints A*x <= b
    %   - for each sample j:  -Y(j,:)*x - u - v_j <= 0
    A1 = zeros(N, nv); b1 = zeros(N,1);
    for j = 1:N
        A1(j,1:n)     = -Y(j,:);      % - x' * Y(j,:)
        A1(j,n+1)     = -1;           % - u
        A1(j,n+1+j)   = -1;           % - v_j
    end

    %   - portfolio return constraint:  -mean_return'*x <= -R
    A2 = zeros(1, nv);
    A2(1,1:n) = -mean_return';
    b2 = -R;

    A = [A1; A2];
    b = [b1; b2];

    % Equality constraint Aeq*x = beq: weights sum to 1
    Aeq = [ones(1,n), zeros(1,1+N)];
    beq = 1;

    % Variable bounds
    lb = [ zeros(n,1);   % x_i >= 0
           -Inf;         % u free (unbounded below)
           zeros(N,1) ]; % v_j >= 0
    ub = [];              % no upper bounds

    % Solver options: dual‐simplex algorithm, no display
    options = optimoptions('linprog', ...
                           'Algorithm','dual-simplex', ...
                           'Display','off');

    %% 3) solve the LP and measure time
    tic;
    [xuv, fval, exitflag, output] = linprog(f, A, b, Aeq, beq, lb, ub, options);
    time = toc;

    if exitflag <= 0
        warning('linprog did not return an optimal solution (exitflag = %d).', exitflag);
    end

    %% 4) unpack results
    x          = xuv(1:n+1);      % portfolio weights and VaR
    cvar       = fval;            % optimal CVaR
    iterations = output.iterations;
end
