[direction, units] = importData('day2_data.csv');

% part 1

% count all forwards (no backwards)
countForward = find(contains(direction, 'forward'));

% count all downs and ups
countDown = find(contains(direction, 'down'));
countUp = find(contains(direction, 'up'));
% downs are +, ups are -
totalUp = sum(units(countUp));
totalDown = sum(units(countDown));
totalForward = sum(units(countForward));
depth = totalDown - totalUp;
horizontal = totalForward;




% part 2
% programming approach was wrong because of the new variable aim
aim = 0; % initialize
horizontal = 0; % initialize
depth = 0; % initialize


for i = 1:length(units)
switch direction{i}
case 'forward'
    horizontal = horizontal + units(i);
    depth = depth + (aim * units(i))
case 'up'
    aim = aim - units(i);
case 'down'
    aim = aim + units(i);
end
end


% calculating final answer
disp(['depth: ', num2str(depth)])
disp(['horizontal: ', num2str(horizontal)])
answer = depth * horizontal;
disp(['answer: ', num2str(answer)])






function [direction, units] = importData(filename)
    data = readtable(filename);
    direction = data.Var1;
    units = data.Var2;
end