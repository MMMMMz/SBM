clc;
clear;
fileName = './ReferenceData.csv';
sourceData = csvread(fileName,2,1);
dataLen = length(sourceData);
data=sourceData;
% input = sourceData(dataLen - 2,:)';
% D = sourceData(randperm(dataLen, 40),:)';
[D,ind] = iterMatrix(sourceData);
% [Idx,D] = kmeans(data,20);
D = D';
% D = stateMatrix(sourceData(1:dataLen - 5),50)';
DT = D.';

totalRes = 0;
resMartix = zeros(dataLen);
%过滤掉选到D中的数据
remain = setdiff(1:2461,ind); 
data_rem = data(remain,:);
dataLen = length(data_rem);
for i = 1 : dataLen
    input = data_rem(i,:)';
    a = Mul(DT, input);
    GI = pinv(Mul(DT,D));
    w0 = GI * a;
    w = w0 / sum(w0);
    output = D * w;
    res = (input - output);
    res = sum(abs(res ./ input)) / size(res,1);
    resMartix(i) = res;
    totalRes = totalRes + res;
end 
totalRes / dataLen

index = 1;
resIndex = zeros(dataLen);
 for i = 1 : dataLen
        if resMartix(i) > 0.008
            resIndex(index,1) = i;
            resIndex(index,2) = resMartix(i);
            index = index + 1;
        end
end
resIndex = resIndex(1:index - 1, 1:2);