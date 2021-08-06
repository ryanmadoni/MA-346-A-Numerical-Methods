function primes = first_n_primes(N)
    primeBool = ones(1, N);
    primeBool(1) = 0;
    prime = 2;
    while prime * prime <= N
        if primeBool(prime) == 1
            for i = prime * 2 : prime : N 
                primeBool(i) = 0;
            end
        end
        prime = prime + 1;
    end
    
    primes = 1 : N;
    i = 1;
    while i < length(primeBool) + 1
        if primeBool(i) == 0
            primes(i) = [];
            primeBool(i) = [];
            i = i - 1;
        end
        i = i + 1;
    end
end