clear variables;
close all;
clc;

%% Historical Data
% Get all closing stock prices
[dateRange, stockIndex, P] = DataProcessing(5);
Pinit = P;

% Model parameters
numDays = 21;
numMonthsSimulated = 4;
numSimsPerMonth = 20;
numSims = 100;
investments = 0;

options = optimoptions('quadprog', 'Display', 'off');

n = 20; % number of stocks
for k=1:numSims
    P = Pinit;
    % Set initial arbitrary alpha
    alpha = 0.5;
    %alpha = rand;

    % Set initial investment value
    investment = 10000;
    expReturn = zeros(numMonthsSimulated,numSimsPerMonth); % all expected simulated returns
    for i=1:numMonthsSimulated
    
        % Historical return ratio between days
        R = (P(2:end,:)-P(1:end-1,:))./P(1:end-1,:);
    
        % average return over entire period for all stocks
        r = mean(R);
    
        % the covariance of all our return ratios
        C = cov(R);

        if i ~= 1
            wOld = w;
        end
        
        % Unlimited optimization
        % [w, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), ones(n,1), [], options);
    
        % Limited optimization
        [w, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), 0.2*ones(n,1), [], options);
    
        % 5% cost on trades
        if i ~= 1
            deltaW = w - wOld;
            investment = investment - sum(abs(deltaW) * 0.05 * investment);
        end

        % Repeatedly simulate future stock prices and assess performance
        for j=1:numSimsPerMonth
    
            % generate future prices
            Po = StockSimulation(P,numDays);
    
            % Historical return ratio between days
            R = (Po(2:end,:)-Po(1:end-1,:))./Po(1:end-1,:);
    
            % average return over entire period for all stocks
            r = mean(R);
    
            expReturn(i,j) = r * w;
    
        end
        
        % "Real" next month stock prices
        Po = StockSimulation(P,numDays);
        P = [P(numDays+1:length(P),:)' flip(Po(2:numDays+1,:))' ]';
    
        % Actual return based on simulated price
    
        R = (Po(2:end,:)-Po(1:end-1,:))./Po(1:end-1,:);
    
        r = mean(R);
         
        %Assess performance based on multiple simulations
        simReturn = mean(expReturn(1,i));
    
        % Options:
        % Don't change alpha
        % alpha = alpha;
        % Increase alpha if profit, decrease if loss
        if simReturn > 0
            alpha = min(1, alpha + 0.1);
        elseif simReturn < 0
            alpha = max(0, alpha - 0.1);
        end
        % Randomize alpha every month
        % alpha = rand;
    
        % Update investment
    
        actualReturn = r * w;
        investment = investment * (1 + actualReturn);
    end
    
    %figure
    %plot(P)
    investments = investments + investment;
    %fprintf("After %d months, $10000 has been transformed into $%f\n", numMonthsSimulated, investment);
end
investments = investments / numSims;
fprintf("With %d months and %d runs, \n$10000 is on average transformed into $%f\n", numMonthsSimulated, numSims, mean(investments));