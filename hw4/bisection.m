MAX_ITER = 1000;
pold = inf;
k = 1;

tol = 1e-5;
%a = 0; b = 1; f = @(x) x-2^(-x); 
%a = 0; b = 1; f = @(x) exp(x)-x^2+3*x-2;
%a = -3; b = -2; f = @(x) 2*x*cos(2*x) - (x + 1)^2;
%a = -1; b = 0; f = @(x) 2*x*cos(2*x) - (x + 1)^2;
%a = 0.2; b = 0.3; f = @(x) x*cos(x) - 2*x^2 + 3*x + 1;
a = 1.2; b = 1.3; f = @(x) x*cos(x) - 2*x^2 + 3*x + 1;


p = a + (b - a) / 2;
while abs(p - pold) > tol || k > MAX_ITER
    k = k + 1;
    if sign(f(a)) < sign(f(p)) 
        b = p; 
    else
        a = p; 
    end  
    pold = p;
    p = a + (b - a) / 2;
end

p
k
