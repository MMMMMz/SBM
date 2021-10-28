function [result,resIndex] = minSim(data,D)
    dataLen = length(data);
    resIndex = zeros(dataLen);
    index = 1;
    DT = D.';
    for i = 1 : dataLen
        input = data(i,:)';
        a = Mul(DT, input);
        GI = pinv(Mul(DT,D));
        w0 = GI * a;
        w = w0 / sum(w0);
        output = D * w;
        res = (input - output);
        res = sum(abs(res ./ input)) / size(res,1);
        resMartix(i) = res;
    end 
        
    for i = 1 : dataLen
        if resMartix(i) > 0.005
            resIndex(index) = i;
            resIndex(index,2) = resMartix(i);
            index = index + 1;
        end
    end
    resIndex = sortrows(resIndex(1:index - 1, 1:2),2,'descend');
    result =  resIndex(1,1);
%     result = randperm(length(resIndex), 1);
end