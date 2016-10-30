function res = doubleDataByInterpolation(val)
    res = zeros(size(val)*2-1);
    for i = 1:length(val)-1
        x1 = val(i);
        mean = (x1 + val(i+1))/2;
        res(2*i-1) = x1;
        res(2*i) = mean;
    end
    res(end) = val(end);

end