%filename = 'input_test.csv';
filename = 'input.csv';
dataText = readmatrix(filename, 'OutputType','char');
test = dataText(1,:);
data = zeros(height(dataText), length(test{:}));
for i = 1:height(dataText)
    for j = 1:length(test{:})
        extractNum = dataText(i,:);
        data(i,j) = str2num(extractNum{:}(j));
    end
end

minima = zeros(height(data), width(data));
for i = 1:height(data)
    for j = 1:width(data)
        % get south
        if i ~= height(data)
            south = data(i+1,j);
        else
            south = [];
        end

        % get north
        if i~= 1
            north = data(i-1, j);
        else
            north = [];
        end

        % get east
        if j~=width(data)
            east = data(i,j+1);
        else
            east = [];
        end

        % get west
        if j~=1
            west = data(i,j-1);
        else
            west = [];
        end

        if min([data(i,j), north, south, east, west])==data(i,j)
            if length(unique([data(i,j), north, south, east, west]))==1
            else
                minima(i,j) = 1;
            end
        end
    end
end

numLowPoints = sum(sum(minima));
riskLevel = (data + 1) .* minima;
riskTotal = sum(sum(riskLevel));
disp(['Risk Level: ', num2str(riskTotal)])

% part 2
dataIm = uint8(data~=9).*255; % BW image of places not 9 (basins)
regions = bwconncomp(dataIm, 4); % setting of 4 connectivity excludes diagonals

for i = 1:length(regions.PixelIdxList)
    regionSize(i) = length(regions.PixelIdxList{i});
end

regionSize = sort(regionSize, 'descend');

answer2 = prod(regionSize(1:3));
disp(['Multiplied size of 3 largest basins: ' num2str(answer2)])