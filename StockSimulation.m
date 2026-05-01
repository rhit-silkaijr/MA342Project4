function [P] = StockSimulation(Po, t)
%Po is the history of a specific stock
%t is how long you want to predict out (ex. 21 for a month barring weekends)

    PoDiff = zeros(1,length(Po)-1);

    for i=1:length(Po)-1
        PoDiff(i) = Po(i+1)-Po(i);
    end

    mu = mean(PoDiff);
    sigma = std(PoDiff);

    phi = randn(1,t);

    P = zeros(1,t);
    for to = 1:t
        Pt = Po(length(Po));
        P(to) = Pt*exp((mu - (sigma^2)/2)*to + sigma*sqrt(to)*phi(to));
        %P(to) = Pt + mu * Pt * to + sigma * Pt * sqrt(to) + phi(to);
    end
    % Append the initial value to the beginning
    P = [Po(length(Po)) P];

end