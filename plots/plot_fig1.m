% Comparison of three smoothing functions for the plus function

epsilon = 0.5;                 % smoothing parameter
t = linspace(-2, 2, 1000);     % grid for t


phi_piecewise = zeros(size(t));
phi_nn        = zeros(size(t));
phi_chks      = zeros(size(t));
phi_max       = max(t,0);     

for i = 1:length(t)
    ti = t(i);
    
    % Uniform / piecewise smoothing
    if ti <= -epsilon/2
        phi_piecewise(i) = 0;
    elseif abs(ti) < epsilon/2
        phi_piecewise(i) = (1/(2*epsilon)) * (ti + epsilon/2)^2;
    else
        phi_piecewise(i) = ti;
    end
    
    % Neural‐network smoothing
    phi_nn(i) = ti + epsilon * log(1 + exp(-ti/epsilon));
    
    % CHKS smoothing
    phi_chks(i) = ( sqrt(4*epsilon^2 + ti^2) + ti ) / 2;
end

grey1 = [0.1, 0.1, 0.1]; 
grey2 = [0.3, 0.3, 0.3]; 
grey3 = [0.5, 0.5, 0.5];  

% Plot 
figure; hold on;
plot(t, phi_max,       'LineStyle', '-', 'LineWidth', 2, 'Color', [0 0 0]);
plot(t, phi_nn,        'LineStyle', '--', 'LineWidth', 1.5, 'Color', grey1);
plot(t, phi_chks,      'LineStyle', '-.',  'LineWidth', 1.5, 'Color', grey2);
plot(t, phi_piecewise, 'LineStyle', ':',  'LineWidth', 1.5, 'Color', grey3);

ylim([-0.2, 2.2]);
xlim([-2 2]);
grid on;
legend('$(t)^+$','Neural network','CHKS','Uniform','Location','NorthWest', 'Interpreter', 'latex');


