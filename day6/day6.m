clear;clc
data = importData('day6_test.csv');
tic;
%{
seed = data;

days = 256;
% rules
% work in current time
fish = seed;

for i = 1:days

    % check if any new fish
    newFish = find(fish(i,:) == -1);
    fish(i,newFish) = 6;
    fish = [fish, ones(height(fish), length(newFish)) * 8];

    newDay = fish(i,:) - 1;
    fish = [fish; newDay];
end


% correct the -1 to 6
% check if any new fish

newFish = find(fish(end,:) == -1);
fish(end,newFish) = 6;
fish = [fish, ones(height(fish), length(newFish)) * 8];
%{
for j = 1:width(fish)
    % add new fish to the end if they exist
    if fish(end,j) == -1;
        fish(end,j) = 6;
        fish = [fish, ones(height(fish),1)*8];
    end
end
%}

totalFish = width(fish);
disp(['Lanternfish Population: ', num2str(totalFish)])
toc;
%disp(['Simulation Time: ', num2str(toc)])
%}


%{
% new algorithm assuming not needing to keep history of fish
seed = data; % starting data

days = 256;
fish = seed;

for i = 1:days
    % check if any new fish
    newFish = find(fish == -1);
    fish(newFish) = 6;
    fish = [fish, ones(1, length(newFish)) * 8];

    newDay = fish - 1;
    fish = newDay;
end
newFish = find(fish == -1);
fish(newFish) = 6;
fish = [fish, ones(1, length(newFish)) * 8];
%}

% new algorithm assuming not needing to keep history of fish
% use columns instead of rows
seed = data'; % starting data, transpose to column

days = 200;

% preallocate regression matrix
x = 1:days;
x = x';
y = zeros(length(days), 1);

% preallocate fish matrix
fish = ones([10000000000, 1], 'int8');
fish = fish * 8;

% perform operations on a subset of the fish matrix
numFish = length(seed);
fish(1:length(seed)) = seed;

for i = 1:days
    % check if any new fish
    newFish = find(fish(1:numFish) == -1);
    fish(newFish) = 6;
    numFish = numFish + length(newFish);

    %disp(fish(1:20)') % for troublshooting
    % new day operations
    fish(1:numFish) = fish(1:numFish) - 1;
    y(i) = numFish;
end

% last operation for newest generation
newFish = find(fish(1:numFish) == -1);
fish(newFish) = 6;
numFish = numFish + length(newFish);

y(end) = numFish;


disp(['Lanternfish Population: ', num2str(numFish)])
toc;



function [data] = importData(filename)
    data = readmatrix(filename);
end