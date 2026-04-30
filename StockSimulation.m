function [P] = StockSimulation(Po, t)
%Po is history of a 
%t is how long you want to predict out (ex. 21 for a month barring weekends)

    % TODO: do these
    mu = .03; % Are these derived or assumed?
    sigma = .15; % Are these derived or assumed?
    phi = zeros(t); % Need this to be a random sequential sampling of Po
    % Is Po(0) supposed to be the first or last value of Po?

    P = zeros(t);
    for to = t
        P(to) = Po(0)*exp((mu - (sigma^2)/2)*to + sigma*sqrt(to)*phi(to));
    end

end

