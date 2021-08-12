%     p0 = 1.5;
%     g1 = @(x) x - x^3 - 4*x^2 + 10;
%     g2 = @(x) ((10 / x) - 4*x)^(1/2);
%     g3 = @(x) (1/2)*(10 - x^3)^(1/2);
%     g4 = @(x) (10 / (4 + x))^(1/2);
%     g5 = @(x) x - (x^3 + 4*x^2 - 10) / (3*x^2 + 8*x);
% 
%     a = zeros(30, 6);
% 
%     for i = 1 : 30
%         a(i, 1) = i;
%     end
%     [~, a] = fpi(g1, 1.5, 3, a, 2);
%     [~, a] = fpi(g2, 1.5, 2, a, 3);
%     [~, a] = fpi(g3, 1.5, 29, a, 4);
%     [~, a] = fpi(g4, 1.5, 15, a, 5);
%     [~, a] = fpi(g5, 1.5, 4, a, 6);
%     a

g = @(x) (20 * x + (21 / x^2)) / 21;
%g = @(x) x - ((x^3 - 21) / (3 * x^2));
p = fpi(g, 1, 100);
p;



function p = fpi(g, p0, MAX_ITER) % pass in a, col
    %a = m;
    %a(1, col) = p0;
    p = p0;
    tol = 1e-5;
    pold = inf;
    k = 0;
    while k < MAX_ITER
      p = g(p)   % fixed-point iteration
      if abs(p - pold) < tol
          k
          return
      end
      pold = p;
      %a(k + 2, col) = p;
      k = k + 1;
    end
    
    if abs(p - pold) > tol
      error('Failed to attain tol');
    end
end


