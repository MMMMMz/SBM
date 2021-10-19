clc;
clear;
fileName = './ReferenceData.csv';
sourceData = csvread(fileName,3,1);
dataLen = length(sourceData);

input = sourceData(dataLen - 1,:)';
D = sourceData(randperm(dataLen - 5, 100),:)';
DT = D.';

a = Mul(DT, input);
GI = inv(Mul(DT,D));
w0 = GI * a;
w = w0 / sum(w0);
output = D * w;
res = input - output;
figure;
hold on;
plot(input,'LineWidth', 2)
plot(output,'LineWidth', 1)
figure;
plot(res)
res