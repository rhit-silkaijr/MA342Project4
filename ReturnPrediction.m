clear variables;
close all;
clc;

%% Historical Data
% Get all closing stock prices
[dateRange, stockIndex, P] = DataProcessing(5);

% Set alpha
alpha = 0.3;
expReturn = zeros(1,20); % all expected returns
numDays = 21;

% Repeatedly simulate future stock prices and assess performance
for j=1:20

    % generate future prices
    Po = StockSimulation(P,numDays);

    % add new prices to old data
    Po = [P(numDays:length(P),:)' Po']';

    % Historical return ratio between days
    R = (Po(2:end,:)-Po(1:end-1,:))./Po(1:end-1,:);
    
    % average return over entire period for all stocks
    r = mean(R);
    
    % the covariance of all our return ratios
    C = cov(R);
    
    % number of stocks we are looking at
    n = 20;
    
    [w, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), ones(n,1));
    expReturn(j) = r * w;
end

Po = StockSimulation(P,numDays);
P = [P(numDays:length(P),:)' Po']';