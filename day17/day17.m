clear;clc

input_test = "target area: x=20..30, y=-10..-5";
input = "target area: x=206..250, y=-105..-57";

% I could write a script that models the behavior
% but perhaps it is better to do something using math
% can't do differential equations, discrete

%n = 10;
%[x, y] = probe(7, 2, n);

success = zeros(1000, 1);
for j = 1:10000

    y0 = j;
    ymax = -57;
    ymin = -105;
    maxSteps = 10000;
    y = zeros(maxSteps, 1); % initialize matrix
    for i = 1:maxSteps
        y(i) = probeMath(y0,i);
    end
    if sum(y>=ymin & y<=ymax)>0
        success(j) = sum(y>=ymin & y<=ymax);
    else
        success(j) = 0;
    end

end % end of j loop

initialVelocity = max(find(success>0));
maxSteps = 10000;
y = zeros(maxSteps, 1); % initialize matrix
for i = 1:maxSteps
    y(i) = probeMath(initialVelocity,i);
end

answer = max(y)

function [x, y] = probe(x0,y0, n)
    u = x0; v = y0; % initial velocity
    x = 0; y = 0 % position
    figure
    hold on
    plot(x,y,'ok')
    for i = 1:n
        x = x + u; % increment x and y positions by velocity
        y = y + v
        
        % normalize x direction velocity
        if u > 0
            u = u - 1;
        elseif u < 0
            u = u + 1;
        elseif u==0
        else
            error('bad u case')
        end

        % y direction case, add for gravity
        v = v - 1;

        % plotting
        plot(x, y, 'ok')
    end
    hold off
end % end of function