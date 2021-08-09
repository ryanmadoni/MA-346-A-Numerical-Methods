%Ab1 = [1 -1 1; 0 12 -8; 0 3 -1];
Ab1 = [1 1 1; 1 1 1; 1 1 1];

i = inverse(Ab1)
inv(Ab1)

function my_inv = inverse(Ab)
    [n, m] = size(Ab);
    Ab = horzcat(Ab,eye(n));
    
    if n ~= m
        error('no inverse');
    end
    
    s = max(abs(Ab(:,1:n - 1)),[],2);
    if any(s==0)
      error('no inverse');
    end

   for r = 1 : n - 1
     Ab(r, :) = Ab(r,:) / Ab(r, r);
     for c = r : n - 1
         Ab(c + 1 ,:) = Ab(c + 1, :) - Ab(r, :) * Ab(c + 1, r);
     end
   end
   Ab(n, :) = Ab(n, :) / Ab(n, n);
    
   for r = 2 : n
     for c = (r-1) : -1 : 1
         Ab(c,:) = Ab(c,:) - Ab(r,:) * Ab(c,r);
     end
   end
   my_inv = Ab(1:n,n + 1:2*n);
end
