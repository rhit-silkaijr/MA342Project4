clear variables;
close all;
clc;

%% Historical Data
% Get all closing stock prices
[dateRange, stockIndex, P] = DataProcessing(5);

% Set alpha
alpha = 0.3;
numDays = 21;
numMonthsSimulated = 4;
numSimsPerMonth = 20;
expReturn = zeros(numMonthsSimulated,numSimsPerMonth); % all expected returns
n = 20; % number of stocks

for i=1:numMonthsSimulated

    % Historical return ratio between days
    R = (P(2:end,:)-P(1:end-1,:))./P(1:end-1,:);

    % average return over entire period for all stocks
    r = mean(R);

    % the covariance of all our return ratios
    C = cov(R);

    [w, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), ones(n,1));

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
end

figure
plot(P)