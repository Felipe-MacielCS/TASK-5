%% Task 5: Simulation Script for Custom Probabilities
% Parameters:
% - Ks: Array of different values of K (number of packets) to test
% - p_range: Range of values for the varying link failure probabilities (either p1, p2, or p3)
% - N: Number of simulations to run per configuration

% Parameters
Ks = [1, 5, 10];   % Different values of K to test 
p_range = linspace(0.01, 0.99, 50);  % Range of values for the failure probabilities
N = 1000;  % Number of simulations per configuration

% Define configurations for p1, p2, p3 for each figure
% NaN indicates the link probability that will vary for each configuration
configs = [
    0.1, 0.6, NaN;  % Figure 1: p1=10%, p2=60%, p3 varies
    0.6, 0.1, NaN;  % Figure 2: p1=60%, p2=10%, p3 varies
    0.1, NaN, 0.6;  % Figure 3: p1=10%, p2 varies, p3=60%
    0.6, NaN, 0.1;  % Figure 4: p1=60%, p2 varies, p3=10%
    NaN, 0.1, 0.6;  % Figure 5: p1 varies, p2=10%, p3=60%
    NaN, 0.6, 0.1;  % Figure 6: p1 varies, p2=60%, p3=10%
];

% Loop through each configuration
for figIdx = 1:size(configs, 1)
    p1_fixed = configs(figIdx, 1); % Fixed value of p1 for this figure (or NaN if varying)
    p2_fixed = configs(figIdx, 2); % Fixed value of p2 for this figure (or NaN if varying)
    p3_fixed = configs(figIdx, 3); % Fixed value of p3 for this figure (or NaN if varying)

    % Initialize a matrix to store results for each combination of (p, K)
    avgTransmissions = zeros(length(p_range), length(Ks));

    % Loop over the range of probabilities (p_range) and each value of K
    for kIdx = 1:length(Ks)
        K = Ks(kIdx); % Current value of K (number of packets to simulate)
        
        % Loop through each value of the varying probability in p_range
        for pIdx = 1:length(p_range)
            % Determine which link probability (p1, p2, or p3) is varying in this configuration
            if isnan(p1_fixed)
                p1 = p_range(pIdx); % p1 varies, p2 and p3 are fixed
                p2 = p2_fixed;
                p3 = p3_fixed;
            elseif isnan(p2_fixed)
                p1 = p1_fixed; % p2 varies, p1 and p3 are fixed
                p2 = p_range(pIdx);
                p3 = p3_fixed;
            else
                p1 = p1_fixed; % p3 varies, p1 and p2 are fixed
                p2 = p2_fixed;
                p3 = p_range(pIdx);
            end
            
            % Call the function to simulate the network for this configuration (K, p1, p2, p3)
            avgTransmissions(pIdx, kIdx) = runCustomCompoundNetworkSim(K, p1, p2, p3, N);
        end
    end

    %% Plot the results for this figure
    figure;  % Create a new figure
    hold on; % Allow multiple plots on the same figure
    
    % Loop through each K value and plot the results
    for kIdx = 1:length(Ks)
        semilogy(p_range, avgTransmissions(:, kIdx), 'o-', 'DisplayName', ['K = ' num2str(Ks(kIdx))]);
        % Plot the average number of transmissions on a logarithmic scale (y-axis)
    end
    
    % Add labels and title to the plot
    xlabel('Varying Link Failure Probability'); % x-axis label
    ylabel('Average Number of Transmissions');  % y-axis label
    title(['Figure ' num2str(figIdx) ': Average Transmissions vs. Probability']);  % Title
    
    % Display the legend (showing different K values)
    legend show;
    
    % Enable grid lines for better readability
    grid on;
    
    hold off; % Stop adding to this figure
end
