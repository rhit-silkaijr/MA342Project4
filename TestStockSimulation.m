[dateRange, stockIndex, P] = DataProcessing(5);
inputData = P(:,2);
numRuns = 5;
numDaysPredicted = 10;
test = zeros(numDaysPredicted+1,numRuns);
for i = 1:numRuns
    test(:,i) = StockSimulation(inputData,numDaysPredicted);
end
plot(test)