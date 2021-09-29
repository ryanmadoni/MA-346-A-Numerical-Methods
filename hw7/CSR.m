format long;

f = @(x) x * log(x + 1);
a = -0.5;
b = 0.5;
n = 6;

i = simpsons(f, a, b, n)

function i = simpsons(f, a, b, n)
    i = f(a) + f(b);
    h = (b - a) / n;
    
    sum1 = 0;
    sum2 = 0;
    for j = 1 : n - 1
        x = a + j * h;
        if mod(j, 2) == 0
            sum1 = sum1 + f(x);
        else
            sum2 = sum2 + f(x);
        end
    end
    
    i = i + 2 * sum1 + 4 * sum2;
    i = i * (h / 3);
end