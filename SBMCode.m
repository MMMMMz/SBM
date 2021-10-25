clc;
clear;
fileName = './ReferenceData.csv';
sourceData = csvread(fileName,2,1);
dataLen = length(sourceData);
tau=40;
data=sourceData;
% input = sourceData(dataLen - 2,:)';
% D = sourceData(randperm(dataLen, 40),:)';
[D,ind] = iterMatrix(sourceData,tau);
D = D';
% D = stateMatrix(sourceData(1:dataLen - 5),50)';
DT = D.';

totalRes = 0;
resMartix = zeros(2461);
for i = 1 : dataLen
    input = sourceData(i,:)';
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
        if resMartix(i) > 0.08
            resIndex(index,1) = i;
            resIndex(index,2) = resMartix(i);
            index = index + 1;
        end
end
resIndex = resIndex(1:index - 1, 1:2);