%% Historical Data
% Get all closing stock prices
[dateRange, stockIndex, P] = DataProcessing(5);

% Historical return ratio between days
R = (P(2:end,:)-P(1:end-1,:))./P(1:end-1,:);

% average return over entire period for all stocks
r = mean(R);

% the covariance of all our return ratios
C = cov(R);

% number of stocks we are looking at
n = 20;

% From here, check various values of alpha,
% number of future points we would like to graph
numPoints = 50;

alphaOptions = linspace(0, 1, numPoints);

i = 1;
for alpha=alphaOptions
    % Use quadprog to get risk and return and then verify it is optimal for
    % alpha
    [w, ~] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), ones(n,1));
    expReturn = r * w;
    expRisk = w' * C * w;
    [~,I] = max(w);
    expReturnArr = zeros(n);
    expRiskArr = zeros(n);
    expReturnArr(I) = expReturn;
    expRiskArr(I) = expRisk;
    for j = 1:n-1
        if j == I
            j = j + 1;
        end
        wp = w;
        wp(I) = wp(I) - 0.1;
        wp(j) = wp(j) + 0.1;
        expReturnMod = r * wp;
        expReturnArr(j) = expReturnMod;
        expRiskMod = wp' * C * wp;
        expRiskArr(j) = expRiskMod;
        if expReturnMod > expReturn && expRiskMod < expRisk
            print('oh no\n');20
            break;
        end
    end

    %Test limited quadprog as well
    [w, ~] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), 0.2*ones(n,1)); % Max 20% investment into one stock
    expReturn = r * w;
    expRisk = w' * C * w;
    [~,I] = max(w);
    for j = 1:n-1
        if j == I
            j = j + 1;
        end
        wp = w;
        wp(I) = wp(I) - 0.1;
        wp(j) = wp(j) + 0.1;
        expReturnMod = r * wp;
        expRiskMod = wp' * C * wp;
        if expReturnMod > expReturn && expRiskMod < expRisk
            print('oh no\n');
            break;
        end
    end
    i = i + 1;
end
plot(expReturnArr)
title('Expected Return')
figure
plot(expRiskArr)
title('Expected Risk')