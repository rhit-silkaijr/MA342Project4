[dateRange, stockIndex, P] = DataProcessing(5);
numRuns = 5;
numDaysPredicted = 21;
numMonthsSimulated = 6;
realData = P;
SSE = zeros(numRuns, numMonthsSimulated);

test = zeros(numDaysPredicted+1,numRuns);
for i = 1:numRuns
    P = realData(1:length(realData)-126,:);
    for j=1:numMonthsSimulated
        % "Real" next month stock prices
        Po = StockSimulation(P,numDaysPredicted);
        P = [P' flip(Po(2:numDaysPredicted+1,:))' ]';
        currMonth = realData(length(realData)-126+(j-1)*21:length(realData)-126+j*21,:);
        SSEtemp = sum(sum(sqrt((Po - currMonth).^2)));
        SSE(i,j) = SSEtemp;
        fprintf("SSE of run %d in month %d is equal to %f\n", i, j, SSEtemp);
    end
end

plot(SSE');
figure
plot(P);
figure
plot(realData);