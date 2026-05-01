function [P] = StockSimulation(Po, t)
%Po is the history of a specific stock
%t is how long you want to predict out (ex. 21 for a month barring weekends)

    % TODO: do these
    mu = .03; % Are these derived or assumed?
    sigma = .15; % Are these derived or assumed?
    % Is Po(0) supposed to be the first or last value of Po?

    phi = normalize(Po); % randn

    phiIndx = rand(1,t) * (length(Po)-1);
    phiIndx = round(sort(phiIndx))+1;
    phi = phi(phiIndx);

    %phi = randn(1,t);

    P = zeros(1,t);
    for to = 1:t
        P(to) = Po(length(Po))*exp((mu - (sigma^2)/2)*to + sigma*sqrt(to)*phi(to));
    end
    % Append the initial value to the beginning
    P = [Po(length(Po)) P];

end

