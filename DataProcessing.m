%% DataProcessing
% Computes stock prices into matrices given price points 
%
%% Inputs
% 
%   pricesUsed  :   (1x1 double) 2 for open, 3 for high, 4 for low, 5 for close
%
%% Outputs
%
%   dataRange   :   (nx1 datetime) all dates from matching stock prices
%   stockIndex  :   (1xn string) all stock trading symbols
%   dataOutput  :   (nxn double) all stock prices for all given dates

function [dateRange, stockIndex, dataOutput] = DataProcessing(pricesUsed)

    
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

    % Luke's Stock
    SNDK = readtable("StockData/SANDISK.csv");
    RVMD = readtable("StockData/RVMD.csv");
    RKLB = readtable("StockData/RKLB.csv");
    NVDA = readtable("StockData/NVIDIA.csv");
    LITE = readtable("StockData/LITE.csv");
    FIX = readtable("StockData/FIX.csv");
    CIEN = readtable("StockData/CIEN.csv");
    ASTS = readtable("StockData/ASTS.csv");
    AAPL = readtable("StockData/APPLE.csv");
    AMD = readtable("StockData/AMD.csv");

    % TODO: Remove these if not needed
    % GME(1,:);
    % GME.Properties.VariableNames;
    
    % Get it all preproccessed to the same date range
    % Note that for certain stocks, the date ranges are
    % different, so in order for them to align, we have to
    % index them through slightly different points
    dateRange = table2array(ADBE(1:248, 1));
    stockIndex = ["AAPL", "ADBE","ADSK", "AMD", "ASTS", ...
        "BIRD", "CIEN", "DVLT", "FIX", "FLUT","FDS","GME", ...
        "HMY", "LITE", "NFLX", "NVDA", "RDDT", "RKLB", "RVMD", "SNDK"];
    dataOutput = zeros(248,20);
    dataOutput(:,1) = table2array(AAPL(3:250, pricesUsed));
    dataOutput(:,2) = table2array(ADBE(1:248, pricesUsed));
    dataOutput(:,3) = table2array(ADSK(1:248, pricesUsed));
    dataOutput(:,4) = table2array(AMD(3:250, pricesUsed));
    dataOutput(:,5) = table2array(ASTS(3:250, pricesUsed));
    dataOutput(:,6) = table2array(BIRD(1:248, pricesUsed));
    dataOutput(:,7) = table2array(CIEN(3:250, pricesUsed));
    dataOutput(:,8) = table2array(DVLT(1:248, pricesUsed));
    dataOutput(:,9) = table2array(FIX(3:250, pricesUsed));
    dataOutput(:,10) = table2array(FLUT(1:248, pricesUsed));
    dataOutput(:,11) = table2array(FDS(1:248, pricesUsed));
    dataOutput(:,12) = table2array(GME(1:248, pricesUsed));
    dataOutput(:,13) = table2array(HMY(1:248, pricesUsed));
    dataOutput(:,14) = table2array(LITE(3:250, pricesUsed));
    dataOutput(:,15) = table2array(NFLX(1:248, pricesUsed));
    dataOutput(:,16) = table2array(NVDA(3:250, pricesUsed));
    dataOutput(:,17) = table2array(RDDT(1:248, pricesUsed));
    dataOutput(:,18) = table2array(RKLB(3:250, pricesUsed));
    dataOutput(:,19) = table2array(RVMD(3:250, pricesUsed));
    dataOutput(:,20) = table2array(SNDK(3:250, pricesUsed));
end