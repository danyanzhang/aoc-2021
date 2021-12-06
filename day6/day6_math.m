% Fish aggregation model
clear;clc
data = importData('day6_data.csv');
tic;

% initialize
dayBins = [0 0 0 0 0 0 0 0 0];

for i = 1:8
    dayBins(i+1) = sum(data==i);
end


% days simulator
days = 256;
for j = 1:days
    dayBins = day6_simulator(dayBins);
end

numFish = sum(dayBins);
disp(['Lanternfish Population: ', num2str(numFish)])

function [data] = importData(filename)
    data = readmatrix(filename);
end


function dayBins = day6_simulator(dayBins)
    newFish = dayBins(1);
    dayBins = [dayBins(2:end), 0];
    dayBins(7) = dayBins(7) + newFish;
    dayBins(9) = dayBins(9) + newFish;
end