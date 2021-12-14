filename = 'input.csv';
data = readtable(filename, 'ReadVariableNames', false);
data = dec2base(data.Var1,10)-'0'; % why does this subtracting '0' work?
%data = [1 1 1 1 1; 1 9 9 9 1; 1 9 1 9 1; 1 9 9 9 1; 1 1 1 1 1];


%[data, flashCount] = octoStep(data)

[data, steps] = octopus(data, 1000);
totalSteps = sum(steps)

% for part 2, just simulated 1000 and saw which one was the first to have n=100

%{
    Octopus algorithm
    For each step
    Energy level of all octopii increase by 1
    Any octopus > 9 flashes
        increases energy level of all adjacent octopuses by 1 (including diagonal)
        An octopus flashes only once per step
        After flashing, octopus goes to 0
%}
% set flashTracker to 0 when octopus has flashed (can't flash anymore this step)


function [data, steps] = octopus(data, n)
    numFlashes = zeros(n, 1);
    for i = 1:n
        [data, numFlashes(i)] = octoStep(data);
    end
    steps = numFlashes;
end


function [data, stepFlashes] = octoStep(data)
    data = data + 1;
    flashTracker = ones(height(data), width(data));
    flashOff = 0;
    while flashOff==0
        newFlashes = (data>9) .* flashTracker;
        if sum(sum(newFlashes))==0
            flashOff=1;
        end
        [idx jdx] = find(newFlashes==1); % get index of flashes
        for k = 1:length(idx)
            data = flash(data, idx(k), jdx(k));
            flashTracker(idx(k), jdx(k)) = 0;
        end
    end
    stepFlashes = sum(sum(flashTracker==0));
    data(data>9) = 0;
end



function data = flash(data, i, j)
    % up left
    try
        data(i-1, j-1) = data(i-1, j-1) + 1;
    end
    % up
    try
        data(i-1, j) = data(i-1, j) + 1;
    end
    % up right
    try
        data(i-1, j+1) = data(i-1, j+1) + 1;
    end
    % left
    try
        data(i, j-1) = data(i, j-1) + 1;
    end
    % right
    try
        data(i, j+1) = data(i, j+1) + 1;
    end
    % down left
    try
        data(i+1, j-1) = data(i+1, j-1) + 1;
    end
    % down
    try
        data(i+1, j) = data(i+1, j) + 1;
    end
    % down right
    try
        data(i+1, j+1) = data(i+1, j+1) + 1;
    end
end