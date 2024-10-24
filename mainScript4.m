%% Main Script to simulate compound network and plot results
%
%
% Parameters:
% Ks - array of values representing the number of packets (K) in the application message
% N - the number of simulations for each value of K and p
% p_vals - array of probabilities of failure for each transmission
% colors - array of colors used to differentiate K values in the combined plot
%
% Output: 
% Plots (Graphs) showing the simulated number of transmissions for different values of K and p:
% - Individual plots for each K
% - Combined plot for all K values

% Values of K (number of packets)
Ks = [1, 5, 15, 50, 100];

% Number of simulations
N = 1000;

% Range of probability of failure (p)
p_vals = linspace(0.01, 0.99, 50); % Simulate across 50 values of p between 0.01 and 0.99

% Preallocate space for simulated results
simulatedResults = zeros(length(Ks), length(p_vals));

% Loop over each value of K
for kIdx = 1:length(Ks)
    K = Ks(kIdx);

    % Loop over each value of p
    for pIdx = 1:length(p_vals)
        p = p_vals(pIdx);

        % Simulated result using the function runCompoundNetworkSim()
        simulatedResults(kIdx, pIdx) = runCompoundNetworkSim(K, p, N);
    end

    % Plot results for each K
    figure;
    hold on;
    plot(p_vals, simulatedResults(kIdx, :), 'ro', 'MarkerSize', 5, 'DisplayName', 'Simulated');
    hold off;

    % Add labels and title
    xlabel('Probability of Failure (p)');
    ylabel('Average Number of Transmissions');
    title(['Compound Network - K = ', num2str(K)]);
    legend show;
    set(gca, 'YScale', 'log'); % Logarithmic scale for Y-axis for readability

    % Save figure (optional)
    saveas(gcf, ['CompoundNetwork_K_', num2str(K), '.png']);
end

% Combined plot for all K values
figure;
hold on;
colors = {'b', 'g', 'r', 'c', 'm'}; % Different colors for each K

for kIdx = 1:length(Ks)
    K = Ks(kIdx);
    plot(p_vals, simulatedResults(kIdx, :), 'o', 'MarkerSize', 5, 'Color', colors{kIdx}, 'DisplayName', ['Simulated K = ', num2str(K)]);
end

hold off;
xlabel('Probability of Failure (p)');
ylabel('Average Number of Transmissions');
title('Compound Network - All K Values');
legend show;
set(gca, 'YScale', 'log'); % Logarithmic scale for Y-axis

% Save combined plot (optional)
saveas(gcf, 'CompoundNetwork_AllK.png');
