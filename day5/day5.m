% only consider horizontal or vertical lines
% x1 = x2 or y1 = y2

filename = 'input.csv';
data = readtable(filename,'Delimiter', {'->', ','}, 'ReadVariableNames', false);
data = renamevars(data, ["Var1", "Var2", "Var3", "Var4"], ["x1", "y1", "x2", "y2"]);

% determine size of map
xmax = max([max(data.x1), max(data.x2)]);
ymax = max([max(data.y1), max(data.y2)]);
map = zeros(ymax+1, xmax+1); % 10x10 grid as the base map for example
% plus one for the indexing

for i = 1:height(data)

    if isValidLine(data.x1(i), data.y1(i), data.x2(i), data.y2(i)) == 0
        continue
    end

    [x,y] = points2Fill(data.x1(i), data.y1(i), data.x2(i), data.y2(i));
    x = x+1; y = y+1; % increase by 1 for indexing purposes

    for j = 1:length(x)
        map(y(j),x(j)) = map(y(j),x(j)) + 1;
    end

end

disp(map)
answer = sum(sum(map>=2));
disp(['Answer: ', num2str(answer)])


function validity = isValidLine(x1,y1,x2,y2)
    % check if x1 and x2 are the same
    if x1==x2 % horizontal line
        validity = 1;
    elseif y1==y2 % vertical line
        validity = 1;
    elseif(abs(x1-x2)==abs(y1-y2)) % diagonal line
        validity = 1;
    else
        validity = 0;
    end
end


function [x,y] = points2Fill(x1,y1,x2,y2)
    if isValidLine(x1,y1,x2,y2) == 1
    else
        error('Not a valid horizontal or vertical line segment')
    end

    if x1==x2 % horizontal line
        y = min([y1, y2]):max([y1,y2]);
        x = repmat(x1, 1, length(y));
    elseif y1==y2 % vertical line
        x = min([x1, x2]):max([x1,x2]);
        y = repmat(y1, 1, length(x));
    elseif abs(x1-x2) == abs(y1-y2)
        x = linspace(x1, x2, abs(x1-x2)+1);
        y = linspace(y1, y2, abs(y1-y2)+1);
    end
end