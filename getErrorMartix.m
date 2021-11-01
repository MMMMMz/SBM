function [errorMartix] = getErrorMartix(data,D)
    dataLen = length(data);
    resIndex = zeros(dataLen);
    index = 1;
    DT = D.';
    totalRes = 0;
    for i = 1 : dataLen
        input = data(i,:)';
        a = Mul(DT, input);
        GI = pinv(Mul(DT,D));
        w0 = GI * a;
        w = w0 / sum(w0);
        output = D * w;
        res = (input - output);
        res =abs(res ./ input) / size(res,1);
        errorMartix(i,:) = res;
    end 
end