%% Function runCompoundNetworkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure for each link
% N - the number of simulations to run
%
% Returns: the average number of transmissions required across the compound network

function result = runCompoundNetworkSim(K, p, N)
    simResults = ones(1, N); % Store results for each simulation

    for i = 1:N
        txAttemptCount = 0; % total number of transmission attempts
        pktSuccessCount = 0; % number of packets that successfully made it through the compound network

        while pktSuccessCount < K
            % Simulate the two series links
            seriesSuccess = false;
            while ~seriesSuccess
                r1 = rand; % Random value for Series Link 1
                r2 = rand; % Random value for Series Link 2
                txAttemptCount = txAttemptCount + 1; % Count transmission attempt
                if r1 > p && r2 > p % Both series links must succeed
                    seriesSuccess = true;
                end
            end

            % Simulate the two parallel links
            parallelSuccess = false;
            while ~parallelSuccess
                r3 = rand; % Random value for Parallel Link 1
                r4 = rand; % Random value for Parallel Link 2
                txAttemptCount = txAttemptCount + 1; % Count transmission attempt
                if r3 > p || r4 > p % Only one of the parallel links must succeed
                    parallelSuccess = true;
                end
            end

            pktSuccessCount = pktSuccessCount + 1; % Successfully transmitted one packet through compound network
        end

        simResults(i) = txAttemptCount; % Store the total number of attempts for this simulation
    end

    result = mean(simResults); % Return the average number of transmissions over N simulations
end
