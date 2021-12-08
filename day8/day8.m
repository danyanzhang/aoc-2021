filename = 'input.csv';
data = readtable(filename,'Delimiter', {' '}, 'ReadVariableNames', false);
%data = renamevars(data, ["Var1", "Var2", "Var3", "Var4"], ["x1", "y1", "x2", "y2"]);
numEntries = height(data);
lenEntries = zeros(height(data), width(data));

for i = 1:numEntries
    for j = 1:width(data)
        lenEntries(i,j) = length(data{i,j}{:});
    end
end

outputMatrix = lenEntries(:, 12:15);
length2 = outputMatrix==2;
length4 = outputMatrix==4;
length3 = outputMatrix==3;
length7 = outputMatrix==7;

% part 1
answer = sum(sum(length2+length4+length3+length7))


% number of segments per number
% 0: 6
% 1: 2 <-
% 2: 5
% 3: 5
% 4: 4 <-
% 5: 5
% 6: 6
% 7: 3 <-
% 8: 7 <-
% 9: 6
% unique entries are 1, 4, 7, 8, with lengths 2, 4, 3, 7




finalNumber = zeros(height(data), 1);
for i = 1:height(data)
    finalNumber(i) = solveRow(data, i);
end

answer2 = sum(finalNumber)

function finalNumber = solveRow(data, rowNum)

% need a decoder script
% rows = numbers, starting from 0 (0->10)
% col = segment digits, starting a->g (1->7)
decoder = [1 1 1 0 1 1 1; ...
           0 0 1 0 0 1 0; ...
           1 0 1 1 1 0 1; ...
           1 0 1 1 0 1 1; ...
           0 1 1 1 0 1 0; ...
           1 1 0 1 0 1 1; ...
           1 1 0 1 1 1 1; ...
           1 0 1 0 0 1 0; ...
           1 1 1 1 1 1 1; ...
           1 1 1 1 0 1 1];

decoderUnique = decoder([2 5 8 9], :);



% get all the things in a row
for i = [1 2 3 4 5 6 7 8 9 10 12 13 14 15]
    rowResult(i, :) = code2Vec(data{rowNum,i}{:});
end
unsortedValues = unique(rowResult,'rows');
unsortedValues = unsortedValues(2:end, :); % get rid of first row, corresponds to '|'

uniqueUnsorted = sum(unsortedValues,2); % add the rows, unique values are 2, 3, 4, 7
uniqueMatrix = unsortedValues(find(uniqueUnsorted==2 | uniqueUnsorted==3 | uniqueUnsorted==4 | uniqueUnsorted==7), :);

% the counted pairs are unique

for i = 1:length(sum(uniqueMatrix))
    A = sum(unsortedValues);
    B = sum(uniqueMatrix);
    a = A(i);
    b = B(i);
if a==8 && b==2
    ordering(i) = 1; % letter a
elseif a==6 && b==2
    ordering(i) = 2; % letter b
elseif a==8 && b==4
    ordering(i) = 3; % letter c
elseif a==7 && b==2
    ordering(i) = 4; % letter d
elseif a==4 && b==1
    ordering(i) = 5; % letter e
elseif a==9 && b==4
    ordering(i) = 6; % letter f
elseif a==7 && b==1
    ordering(i) = 7; % letter g
end
end

% sort rowResult by ordering
[test, sortOrder] = sort(ordering);
sortedResults = rowResult(:, sortOrder);

%ndx = ismember(decoder,[0 0 1 0 0 1 0],'rows'); % find within rows

% remove row 11 because it is not part of it
finalOutput = sortedResults(12:15, :); % grab only the output

for i = 1:height(finalOutput)
    ndx = ismember(decoder, finalOutput(i,:), 'rows');
    ndx2(i) = find(ndx==1);
end
numberOutput = ndx2 - 1;

% assemble numberOutput into final number
    d1 = num2str(numberOutput(1));
    d2 = num2str(numberOutput(2));
    d3 = num2str(numberOutput(3));
    d4 = num2str(numberOutput(4));
    finalNumber = str2num(strcat(d1, d2, d3, d4));


end % end of function