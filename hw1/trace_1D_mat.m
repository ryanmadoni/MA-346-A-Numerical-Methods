function trace = trace_1D_mat(v)
    trace = 0;
    n = sqrt(length(v));
    if floor(n) ~= n
        error("matrix must be square");
    end
    d = 0;
    for i = 1 : n : length(v)
        trace = trace + v(i + d);
        d = d + 1;
    end
end
