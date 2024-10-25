%% Function: runCustomCompoundNetworkSim
% Parameters:
% - K: Number of packets to transmit
% - p1: Probability of failure for Parallel Link 1
% - p2: Probability of failure for Parallel Link 2
% - p3: Probability of failure for both Series Links
% - N: Number of simulations to run
%
% Returns:
% - result: Average number of transmission attempts required to transmit all K packets

function result = runCustomCompoundNetworkSim(K, p1, p2, p3, N)
    simResults = ones(1, N); % Store results for each simulation

    % Run N simulations
    for i = 1:N
        txAttemptCount = 0;  % Counter for total number of transmission attempts
        pktSuccessCount = 0; % Counter for successfully transmitted packets

        % Simulate until all K packets are successfully transmitted
        while pktSuccessCount < K
            % Simulate the two series links with failure probability p3
            seriesSuccess = false;  % Reset success flag for series links
            while ~seriesSuccess
                r1 = rand; % Random value for Series Link 1
                r2 = rand; % Random value for Series Link 2
                txAttemptCount = txAttemptCount + 1; % Increment transmission attempt count

                % Both series links must succeed for transmission to proceed
                if r1 > p3 && r2 > p3
                    seriesSuccess = true;  % Mark series link transmission as successful
                end
            end

            % Simulate the two parallel links with failure probabilities p1 and p2
            parallelSuccess = false;  % Reset success flag for parallel links
            while ~parallelSuccess
                r3 = rand; % Random value for Parallel Link 1
                r4 = rand; % Random value for Parallel Link 2
                txAttemptCount = txAttemptCount + 1; % Increment transmission attempt count

                % Only one of the parallel links must succeed for transmission to proceed
                if r3 > p1 || r4 > p2
                    parallelSuccess = true;  % Mark parallel link transmission as successful
                end
            end

            % Successfully transmitted one packet through the compound network
            pktSuccessCount = pktSuccessCount + 1;  
        end

        % Store the total number of attempts for this simulation
        simResults(i) = txAttemptCount;  
    end

    % Return the average number of transmissions over N simulations
    result = mean(simResults);
end
