format long;

f = @(x) (x^2) * exp(-1 * x);
a = 0;
b = 1;
n = 3;

i = trapezoidal(f, a, b, n)

function i = trapezoidal(f, a, b, n)
    i = f(a) + f(b);
    h = (b - a) / n;
    
    sum = 0;
    
    for j = 1 : n - 1
        sum = sum + f(a + j * h);
    end
    
    sum = sum * 2;
    i = i + sum;
    i = i * (h / 2);
end