%Ab1 = [1 -2 3 0 1; 1 -2 3 1 1; 1 -2 2 -2 1; 2 1 3 -1 1];
% Ab1 = [3 5 7 1; 11 12 7 2; 2 1 4 3];
%Ab1 = [1 -1 1 5; 0 12 -8 -27; 0 3 -1 -3];
%A = [1 -1 1; 0 12 -8; 0 3 -1];
%B = [5; -27; -3];


Ab1 = [1 -1 1 6; 0 12 -8 -5; 0 3 -1 -9];
A = [1 -1 1; 0 12 -8; 0 3 -1];
B = [6; -5; -9];

global L;

[~, P] = gauss_elim_srpp(Ab1);
[Ub, ~] = gauss_elim_srpp(P*Ab1);
X = backward_sub(Ub);

function [Ub, P] = gauss_elim_srpp(Ab)
    [n, ~] = size(Ab);
    global L;
    L = eye(n);
    P = eye(n);

    s = max(abs(Ab(:,1:n)),[],2);
    if any(s==0)
      error('Infinite or no solutions');
    end

    opE = 0;

    %Gaussian elimination
    for k=1:n - 1
      [~, i] = max(abs(Ab(k:n,k))./s(k:n));
      p = k+i-1;
      if Ab(p,k) ~= 0
        tmp = Ab(k,:);
        Ab(k,:) = Ab(p,:);
        Ab(p,:) = tmp;
        tmp = P(k,:);
        P(k,:) = P(p,:);
        P(p,:) = tmp;
      else
        error('No unique solution. Infinite or no solution.');
      end
      for i=(k+1):n
        m = Ab(i,k)/Ab(k,k);
        L(i,k) = m;
        for c = 1:n + 1
            Ab(i,c) = Ab(i,c) - m*Ab(k,c);
        end
        opE = opE + size(Ab,2);
      end  
    end
    Ub = Ab;
end

function [X] = backward_sub(Ub)
    global L;
    [n, ~] = size(Ub);
    if Ub(n,n) == 0
     error('No solution');
    end
    m = size(Ub,2)-n;
    X = zeros(m,n);
    for j=1:m
        for i=n:-1:1
          X(j,i) = (Ub(i,n+j) - sum(Ub(i,i+1:n).*X(j,i+1:n)))/Ub(i,i);
        end
    end
end



