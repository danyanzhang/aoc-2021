[dataRaw, data] = importData('day3_data.csv');

% part 1
gammaBit = zeros(1, width(data));
epsilonBit = zeros(1, width(data));
for i = 1:width(data) % for each column
    zeroSum = sum(data(:,i)==0);
    onesSum = sum(data(:,i)==1);
    if onesSum > zeroSum
        gammaBit(i) = 1;
        epsilonBit(i) = 0;
    elseif onesSum < zeroSum
        gammaBit(i) = 0;
        epsilonBit(i) = 1;
    else
        disp('Error')
    end
end

gamma = bin2dec(strjoin(string(gammaBit)));
epsilon = bin2dec(strjoin(string(epsilonBit)));

answer = gamma * epsilon;
disp(answer)


% part 2: need to iterate through
% while loop
data2 = data;
while height(data2) > 1
    for i = 1:width(data2) % for each column
        zeroSum = sum(data2(:,i)==0);
        zeroIdx = find(data2(:,i)==0);
        onesSum = sum(data2(:,i)==1);
        onesIdx = find(data2(:,i)==1);
        if onesSum > zeroSum
            % more 1s than 0s
            data2(zeroIdx,:) = []; % delete rows with zeros
        elseif onesSum < zeroSum
            % more 0s than 1s
            data2(onesIdx,:) = []; % delete rows with ones
        elseif onesSum == zeroSum
            % if same number, pick the one with one
            data2(zeroIdx,:) = []; % delete the row with zero
        else    
            disp('Error')
        end

        if height(data2) == 1
            break
        end
    end
    data2;
end
oxygenGeneratorRating = bin2dec(strjoin(string(data2)));



data3 = data;
while height(data3) > 1
    for i = 1:width(data3) % for each column
        zeroSum = sum(data3(:,i)==0);
        zeroIdx = find(data3(:,i)==0);
        onesSum = sum(data3(:,i)==1);
        onesIdx = find(data3(:,i)==1);
        if onesSum > zeroSum
            % more 1s than 0s
            data3(onesIdx,:) = []; % delete rows with ones
        elseif onesSum < zeroSum
            % more 0s than 1s
            data3(zeroIdx,:) = []; % delete rows with zero
        elseif onesSum == zeroSum
            % if same number, pick the one with zero
            data3(onesIdx,:) = []; % delete the row with one
        else    
            disp('Error')
        end

        if height(data3) == 1
            break
        end
    end
    data3;
end
co2ScrubberRating = bin2dec(strjoin(string(data3)));

answer2 = oxygenGeneratorRating * co2ScrubberRating;


function [data, matrixOutput] = importData(filename)
    data = readtable(filename, 'ReadVariableNames', false);
    matrixOutput = dec2base(data.Var1,10)-'0'; % why does this subtracting '0' work?
end
%Explanation for - '0'
%https://www.mathworks.com/matlabcentral/answers/399557-explanation-of-num2str-x-0