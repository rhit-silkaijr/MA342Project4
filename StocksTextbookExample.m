%% MA342 Project 4 Textbook Example
clear variables;
close all;
clc;

% Pull at opening prices
[dateRange, stockIndex, P] = DataProcessing(5);

n = size(P, 2);

% Get stock returns
R = (P(2:end, :) - P(1:(end-1), :)) ./ P(1:(end-1), :);

% Mean returns
r = mean(R);

% Covariance matrix
C = cov(R);

% Risk factor
alpha = 0.5;

% optimization, no more investment than 20% into any stock
inv_limit = 0.20;
[w, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), inv_limit*ones(n,1));

Dt = 21;

P_pred = StockSimulation(P, Dt);


