function [P] = StockSimulation(Po, t)
%Po is the history of a specific stock
%t is how long you want to predict out (ex. 21 for a month barring weekends)

    change_periods = size(Po, 1)-1;
    n = size(Po, 2);

    PoDiff = zeros(change_periods, n);

    for i=1:change_periods
        for j = 1:n
            PoDiff(i, j) = Po(i+1, j)-Po(i, j);
        end
    end

    mu = mean(PoDiff, 1);
    sigma = std(PoDiff, 1);

    % Use a random value for phi
    % for every single day
    phi = randn(1,t);

    P = zeros(t,n);
    for to = 1:t
            Pt = Po(length(Po), :);
            P(to, :) = Pt.*exp((mu - (sigma.^2)./2).*to + sigma.*sqrt(to).*phi(to));
            %P(to) = Pt + mu * Pt * to + sigma * Pt * sqrt(to) + phi(to);
    end
    % Append the initial value to the beginning
    P = [Po(length(Po), :); P];

end