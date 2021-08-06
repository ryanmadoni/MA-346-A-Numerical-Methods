function p = eval_poly(coefs, x)
    p = coefs(length(coefs));
    for i = length(coefs) - 1 : -1 : 1
        p = p * x + coefs(i);
    end
end