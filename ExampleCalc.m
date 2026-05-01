[dateRange, stockIndex, P] = DataProcessing(5);
R = (P(2:end,:)-P(1:end-1,:))./P(1:end-1,:);
r = mean(R);
C = cov(R);
n = 20;
numPoints = 50;
alphaOptions = linspace(0, 1, numPoints);
expReturn = linspace(0, 1, numPoints);
expRisk = linspace(0, 1, numPoints);
expReturnLimited = linspace(0, 1, numPoints);
expRiskLimited = linspace(0, 1, numPoints);
i = 1;
for alpha=alphaOptions
    [w, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), ones(n,1));
    expReturn(i) = r * w;
    expRisk(i) = w' * C * w;
    [wLim, optVal] = quadprog((1-alpha)*2*C, -alpha*r, [], [], ones(1,n), [1], zeros(n,1), 0.2*ones(n,1)); % Max 20% investment into one stock
    expReturnLimited(i) = r * wLim;
    expRiskLimited(i) = wLim' * C * wLim;
    i = i + 1;
end
plot(expRisk, expReturn, expRiskLimited, expReturnLimited);
xlabel('Expected Risk');
ylabel('Expected Return');
legend('unrestricted','restricted')