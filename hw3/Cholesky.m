Ab = [4 12 -16; 12 37 -43; -16 -43 98];

for k=1:n
  i = find(Ab(k:n,k)~=0,1);  
  p = k+i-1;
  if Ab(p,k) ~= 0
    tmp = Ab(k,:);
    tmp = P(k,:);
  else
    error('No unique solution. Infinite or no solution.');
  end
  M = eye(n);
  Mi = eye(n);
  for i=(k+1):n
    m = Ab(i,k)/Ab(k,k);
    Ab(i,:) = Ab(i,:) - m*Ab(k,:);
    opE = opE + size(Ab,2);
    M(i,k) = -m;
    Mi(i,k) = m;
  end
  Ab(k,k:end) = Ab(k,k:end)/sqrt(Ab(k,k));  
end

L = Ab'