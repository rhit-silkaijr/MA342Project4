[dateRange, stockIndex, P] = DataProcessing(5);
inputData = P(:,3);
test = zeros(11,10);
for i = 1:10
    test(:,i) = StockSimulation(inputData,10);
end
plot(test)