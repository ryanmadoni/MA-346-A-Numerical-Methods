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

n = 43;
m = 43;
epsilon = 1.2;

j = SimpsonsDoubleIntegral(f, a, b, c, d, n, m, 0)
j = AdaptiveSimpsonsDoubleIntegral(f, [a; b; c; d], epsilon)

function j = SimpsonsDoubleIntegral(f, a, b, c, d, n, m, adaptive)
    h = (b - a) / n;
    j1 = 0;
    j2 = 0;
    j3 = 0;
    xs = [];
    ys = [];
    
    for i = 0 : n
        x = a + i * h;
        hx = (d - c) / m;
        k1 = f(x, c) + f(x, d);
        k2 = 0;
        k3 = 0;
        
        for j = 1 : m - 1
            y = c + j * hx;
            q = f(x, y);
            if mod(j, 2) == 0
                k2 = k2 + q;
            else
                k3 = k3 + q;
            end
            if adaptive == 0
                xs = [xs; x];
                ys = [ys; y];
            end
        end
        
        l = (k1 + 2 * k2 + 4 * k3) * hx / 3;
        
        if i == 0 || i == n
            j1 = j1 + l;
        elseif mod(i, 2) == 0
            j2 = j2 + l;
        else
            j3 = j3 + l;
        end
    end
    j = h * (j1 + 2 * j2 + 4 * j3) / 3;
    if adaptive == 0
        plot(xs, ys, '.');
        figure;
        xy = unique(horzcat(xs, ys), 'rows', 'stable');
        NumberOfPointsUsed = size(xy);
        NumberOfPointsUsed = NumberOfPointsUsed(1)
    end
end

function I = AdaptiveSimpsonsDoubleIntegral(f, lst, epsilon)

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
        
        m2 = (a + m) / 2;
        k2 = (c + k) / 2;
        
        m3 = m + (m - m2);
        k3 = k + (k - k2);
        
        IC = SimpsonsDoubleIntegral(f, a, b, c, d, 1, 1, 1);
        IF1 = SimpsonsDoubleIntegral(f, a, m, c, k, 2, 2, 1);
        IF2 = SimpsonsDoubleIntegral(f, a, m, k, d, 2, 2, 1);
        IF3 = SimpsonsDoubleIntegral(f, m, b, c, k, 2, 2, 1);
        IF4 = SimpsonsDoubleIntegral(f, m, b, k, d, 2, 2, 1);
        
        
        if abs(IC - IF1 - IF2 - IF3 - IF4) < epsilon
            I = I + IF1 + IF2 + IF3 + IF4;   
            x = [x; [a; a; a; a; a; m2; m2; m2; m2; m2; m; m; m; m; m; m3; m3; m3; m3; m3; b; b; b; b; b]];
            y = [y; [c; k2; k; k3; d; c; k2; k; k3; d; c; k2; k; k3; d; c; k2; k; k3; d; c; k2; k; k3; d]];
        else
            lst = [lst; [a; m; c; k]; [m; b; c; k]; [a; m; k; d]; [m; b; k; d]];
        end   
    end
    plot(x, y, '.');  
    xy = unique(horzcat(x, y), 'rows', 'stable');
    NumberOfPointsUsed = size(xy);
    NumberOfPointsUsed = NumberOfPointsUsed(1)
end