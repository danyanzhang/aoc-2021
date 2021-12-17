function [x, y] = probeMath(x0, y0, n)
    x = -y0;
    y = ((x*n) + ((n-1)/2*(1+n-1)))*-1;

    u = x0;
    x = 0;
    for i = 1:n
        x = x + u; % increment x
        
        % normalize x direction velocity
        if u > 0
            u = u - 1;
        elseif u < 0
            u = u + 1;
        elseif u==0
        else
            error('bad u case')
        end
    end

end