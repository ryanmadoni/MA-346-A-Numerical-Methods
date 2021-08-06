format long;

f = @(x, y) y * sin(x) + x * cos(y);
a = -1 * pi;
b = (3 * pi) / 2;
c = 0;
d = 2 * pi;

% f = @(x, y) 1 / (2 * pi * 0.1) * exp(-1 * (x^2 + y^2) / (2 * 0.1));
% a = -5;
% b = 5;
% c = -5;
% d = 5;

n = 42;
m = 42;
epsilon = 0.0095;

% Originally I tried timing these functions and the others
% but that is not really a good metric of how well the algorithm is
% implemented as I could have coded one with more/less efficient MATLAB
% code and cputime, tic/toc, and other timing functions are not the most
% accurate.

j = TrapezoidalDoubleIntegral(f, a, b, c, d, n, m, 0)
j = AdaptiveTrapezoidalDoubleIntegral(f, [a; b; c; d], epsilon)

function j = TrapezoidalDoubleIntegral(f, a, b, c, d, n, m, adaptive)   
    h = (b - a) / n;
    sum1 = 0;
    sum2 = 0;
    xs = [];
    ys = [];
    for i = 0 : n
        x = a + i * h;
        k = (d - c) / m;
        sum3 = 0;
        sum4 = 0;
        for j = 0 : m
            y = c + j * k;
            if j == 0 || j == m
                sum3 = sum3 + f(x, y);
            else
                sum4 = sum4 + f(x, y);
            end
            if adaptive == 0
                xs = [xs; x];
                ys = [ys; y];
            end
        end 
        sum4 = sum4 * 2;
        sum3 = sum3 + sum4;
        sum3 = sum3 * (k / 2);
 
        if i == 0 || i == n
            sum1 = sum1 + sum3;
        else
            sum2 = sum2 + sum3;
        end  
    end
    sum2 = sum2 * 2;
    sum1 = sum1 + sum2;
    sum1 = sum1 * (h / 2);
    j = sum1; 
    if adaptive == 0
        plot(xs, ys, '.');
        figure;
        xy = unique(horzcat(xs, ys), 'rows', 'stable');
        NumberOfPointsUsed = size(xy);
        NumberOfPointsUsed = NumberOfPointsUsed(1)  
    end
end

function I = AdaptiveTrapezoidalDoubleIntegral(f, lst, epsilon)
    I = 0;
    x = [];
    y = [];
    while ~isempty(lst)
        a = lst(1);
        b = lst(2);
        c = lst(3);
        d = lst(4);
        lst(1) = [];
        lst(1) = [];
        lst(1) = [];
        lst(1) = [];
        
        m = (a + b) / 2;
        k = (c + d) / 2;
        
        IC = TrapezoidalDoubleIntegral(f, a, b, c, d, 1, 1, 1);
        IF = TrapezoidalDoubleIntegral(f, a, b, c, d, 2, 2, 1);
        
        if abs(IC - IF) < epsilon
            I = I + IF;
            x = [x; [a; a; b; b; m; m; a; b; m]];
            y = [y; [c; d; c; d; c; d; k; k; k]];
        else
            lst = [lst; [a; m; c; k]; [m; b; c; k]; [a; m; k; d]; [m; b; k; d]];
        end   
    end
    plot(x, y, '.');
    xy = unique(horzcat(x, y), 'rows', 'stable');
    NumberOfPointsUsed = size(xy);
    NumberOfPointsUsed = NumberOfPointsUsed(1)
end





