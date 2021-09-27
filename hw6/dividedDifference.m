format long;
% x = [1 1.3 1.6 1.9 2.2];
% y = [0.7651977 0.6200860 0.4554022 0.2818186 0.1103623];

%x = [-0.1 0 0.2 0.3];
%y = [5.3 2 3.19 1];
%x = [-0.1 0 0.2 0.3 0.35];
%y = [5.3 2 3.19 1 0.97260];
x = [0 1 2];
y = [2 -1 4];

c = divided_diff(x, y)

function c = divided_diff(x, y)
    n = length(x);
    F = zeros(n);
    F(:, 1) = y;
    
    for i = 2 : n
        for j = 2 : i
            F(i, j) = (F(i, j - 1) - F(i - 1, j - 1)) / (x(i) - x(i - j + 1));
        end
    end
    c = F;
end



