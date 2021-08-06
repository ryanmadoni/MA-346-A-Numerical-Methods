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

m = 43;
n = 43;
epsilon = 0.1;

[rn, cn] = legendreRC(n);
[rm, cm] = legendreRC(m);

J = GaussDoubleIntegral(f, a, b, c, d, m, n, rn, cn, rm, cm, 0)
J = AdaptiveGaussDoubleIntegral(f, [a; b; c; d], epsilon)


function J = GaussDoubleIntegral(f, a, b, c, d, n, m, rn, cn, rm, cm, adaptive)
    h1 = (b - a) / 2;
    h2 = (b + a) / 2;
    J = 0;   
    xs =[];
    ys = [];
    for i = 1 : n
        jx = 0;
        x = h1 * rn(i) + h2;
        k1 = (d - c) / 2;
        k2 = (d + c) / 2;   
        for j = 1 : m
            y = k1 * rm(j) + k2;
            jx = jx + cm(j, 1) * f(x, y);
            if adaptive == 0
                xs = [xs; x];
                ys = [ys; y];
            end
        end
        J = J + cn(i, 1) * k1 * jx;
    end
    J = h1 * J;
    if adaptive == 0
        plot(xs, ys, '.');
        figure;
        xy = unique(horzcat(xs, ys), 'rows', 'stable');
        NumberOfPointsUsed = size(xy);
        NumberOfPointsUsed = NumberOfPointsUsed(1)
    end
end



function [rs, coeff] = legendreRC(n)
    syms x;
    p = legendreP(n, x);
    rs = sort(roots(sym2poly(p)), 'descend');

    coeff = zeros(n, 1);
    syms curr(x);
    for i = 1 : n
        curr(x) = 1;
        for j = 1 : n
            if i ~= j
                den = rs(i) - rs(j);
                curr(x) = curr(x) * ((x / den) - (rs(j) / den));
            end
            curr(x);
        end
        coeff(i, 1) = int(curr, x, -1, 1);
    end
end

function I = AdaptiveGaussDoubleIntegral(f, lst, epsilon)

    I = 0;
    x = [];
    y = [];
    
    [rm, cm] = legendreRC(1);
    [rn, cn] = legendreRC(2);
    
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
        
        IC = GaussDoubleIntegral(f, a, b, c, d, 1, 1, rm, cm, rm, cm, 1);
        IF1 = GaussDoubleIntegral(f, a, m, c, k, 2, 2, rn, cn, rn, cn, 1);
        IF2 = GaussDoubleIntegral(f, a, m, k, d, 2, 2, rn, cn, rn, cn, 1);
        IF3 = GaussDoubleIntegral(f, m, b, c, k, 2, 2, rn, cn, rn, cn, 1);
        IF4 = GaussDoubleIntegral(f, m, b, k, d, 2, 2, rn, cn, rn, cn, 1);
        
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