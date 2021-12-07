clear;clc

input = [16,1,2,0,4,2,7,1,2,14]; % test numbers
input = readmatrix('day7_data.csv');


positionMed = round(median(input));
positionStd = round(std(input));

startSearchPosition = positionMed;
searchRange = positionMed-positionStd:positionMed+positionStd; % search within 1 stdev bound


% example test
targetPosition = 2;
fuelUsed = fuelConsumed(input, targetPosition);


% range version
target = zeros(length(searchRange), 1);
fuel = target;
for i = 1:length(searchRange)
    target(i) = searchRange(i);
    fuel(i) = fuelConsumed(input, target(i));
end

plot(target, fuel, '-o')
xlabel('Target Position')
ylabel('Total Fuel Consumed')


function fuelConsumption = fuelConsumed(input, target)
    distanceFromTarget = abs(input - target);
    
    crabsFuel = (distanceFromTarget./2).*(1+distanceFromTarget);
    
    fuelConsumption = sum(crabsFuel);
end