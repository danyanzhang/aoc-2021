% part 1
input = readtable('day1_data.csv');
depth = input.Var1;

testData = [199; 200; 208; 210; 200; 207; 240; 269; 260; 263];
testAnswer = sum(diff(testData) > 0); % take the first derivative

answer = sum(diff(depth) > 0);

% part 2
windowSize = 3;

slidingTest = zeros(length(testData)-windowSize+1, 1);
for i = 1:length(slidingTest)
    slidingTest(i) = testData(i) + testData(i+1) + testData(i+2);
end

testFilter = movingSum(testData, 3); % make sure the new function works

filteredData = movingSum(depth, 3);
answer2 = sum(diff(filteredData) > 0);


function filteredData = movingSum(data, windowSize)
    filteredData = zeros(length(data)-windowSize+1, 1);
    for i = 1:length(filteredData)
        filteredData(i) = data(i) + data(i+1) + data(i+2);
    end
end