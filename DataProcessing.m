pricesUsed = 5;
% 2 for open, 3 for high, 4 for low, 5 for close

ADBE = readtable("StockData/ADOBE INC (01-21-2025 _ 04-28-2026).csv");
ADSK = readtable("StockData/AUTODESK INC (05-02-2025 _ 04-28-2026).csv");
DVLT = readtable("StockData/DATAVAULT AI INC (01-29-2025 _ 04-28-2026).csv");
BIRD = readtable("StockData/ALLBIRDS INC (05-02-2025 _ 04-28-2026).csv");
FLUT = readtable("StockData/FLUTTER ENTMT PLC (05-02-2025 _ 04-28-2026).csv");
FDS = readtable("StockData/FACTSET RESH SYS INC (02-13-2025 _ 04-28-2026).csv");
GME = readtable("StockData/GAMESTOP CORP (05-02-2025 _ 04-28-2026).csv");
HMY = readtable("StockData/HARMONY GOLD MNG LTD (05-02-2025 _ 04-28-2026).csv");
NFLX = readtable("StockData/NETFLIX INC. (02-12-2025 _ 04-28-2026).csv");
RDDT = readtable("StockData/REDDIT INC (05-02-2025 _ 04-28-2026).csv");
GME(1,:);
GME.Properties.VariableNames;

% Get it all preproccessed to the same date range
dateRange = table2array(ADBE(1:248, 1));
stockIndex = ["ADBE","ADSK","DVLT","BIRD","FLUT","FDS","GME","HMY","NFLX","RDDT"];
dataOutput = zeros(248,10);
dataOutput(:,1) = table2array(ADBE(1:248, pricesUsed));
dataOutput(:,2) = table2array(ADSK(1:248, pricesUsed));
dataOutput(:,3) = table2array(DVLT(1:248, pricesUsed));
dataOutput(:,4) = table2array(BIRD(1:248, pricesUsed));
dataOutput(:,5) = table2array(FLUT(1:248, pricesUsed));
dataOutput(:,6) = table2array(FDS(1:248, pricesUsed));
dataOutput(:,7) = table2array(GME(1:248, pricesUsed));
dataOutput(:,8) = table2array(HMY(1:248, pricesUsed));
dataOutput(:,9) = table2array(NFLX(1:248, pricesUsed));
dataOutput(:,10) = table2array(RDDT(1:248, pricesUsed));

