format long;
%f = @(x) cos(x) - x; 
%f = @(x) 230*x^4 + 18*x^3 + 9*x^2 - 221*x - 9;
f = @(x) 1 - 4*x*cos(x) + 2*x^2 + cos(2*x);
 

%[p, ~] = falsePosition(f, 0, 1, 1e-6, 100)
%[p, ~] = secant(f, 0.5, 1, 1e-6, 200)
%[p, iter] = newton(f, 0, 1e-5, 200)
[p, iter] = modifiedNewton(f, 0, 1e-5, 200)


function [p,iter] = newton(f, p0, tol, max_iter)
    syms x;
    fsp = diff(f, x);
    iter = 0;
    while iter < max_iter
        p = p0 - f(p0) / eval(subs(fsp, x, p0));
        if abs(p - p0) < tol
            return
        end
        iter = iter + 1;
        p0 = p;
    end
    if abs(p - p0) > tol
        error('Failed to attain tol');
    end
end

function [p,iter] = secant(f, p0, p1, tol, max_iter)
    iter = 0;
    q0 = f(p0);
    q1 = f(p1);
    while iter < max_iter
        p = p1 - q1 * (p1 - p0) / (q1 - q0);
        if abs(p - p1) < tol
            return
        end
        iter = iter + 1;
        p0 = p1;
        q0 = q1;
        p1 = p;
        q1 = f(p);
    end
    if abs(p - p1) > tol
        error('Failed to attain tol');
    end
end

function [p,iter] = falsePosition(f, a, b, tol, max_iter)
    iter = 0;
    q0 = f(a);
    q1 = f(b);
    while iter < max_iter
        p = b - q1 * (b - a) / (q1 - q0);
        if abs(p - b) < tol
            return
        end
        iter = iter + 1;
        q = f(p);
        if q * q1 < 0
            a = b;
            q0 = q1;
        end
        b = p;
        q1 = q;
    end
    if abs(p - b) > tol
        error('Failed to attain tol');
    end  
end

function [p,iter] = modifiedNewton(f, p0, tol, max_iter)
    syms x;
    fsp = diff(f, x);
    fspp = diff(fsp, x);
    iter = 0;
    while iter < max_iter
        dp = eval(subs(fsp, x, p0));
        ddp = eval(subs(fspp, x, p0));
        p = p0 - (f(p0) *  dp) / (dp * dp - f(p0) * ddp);
        if abs(p - p0) < tol
            return
        end
        iter = iter + 1;
        p0 = p;
    end
    if abs(p - p0) > tol
        error('Failed to attain tol');
    end
end


