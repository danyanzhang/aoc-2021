clear;clc

%input = "target area: x=20..30, y=-10..-5";
%input = "target area: x=206..250, y=-105..-57";

target = [20 30 -10 -5];
target2 = [206 250 -105 -57];


searchRange = [1 1000 -200 106];
xrange = searchRange(1):1:searchRange(2);
yrange = searchRange(3):1:searchRange(4);

hitMatrix = zeros(length(xrange), length(yrange));
for i = 1:length(xrange)
    for j = 1:length(yrange)
        u = xrange(i);
        v = yrange(j);
        hitMatrix(i,j) = fire(u, v, target2);
    end
end

sum(sum(hitMatrix))





function hit = fire(x0, y0, target)
    % hit is boolean

    hit = -1;
    n = 1;
    while hit == -1
        [x,y] = probeMath2(x0, y0, n);

        % check if in target
        if x>=target(1) && x<=target(2) && y>=target(3) && y<=target(4)
            hit = 1;
        elseif x>target(2) || y<target(3)
            hit = 0;
        end
        n = n+1; % increment
    end

    % iterate for a few steps
    % check if overshot
    % if overshot, close out loop
end