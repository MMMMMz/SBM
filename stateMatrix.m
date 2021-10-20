function D = stateMatrix(data,t) 
% 输入数据生成状态矩阵D
m = size(data,2); 
for i=1:m 
    minnum(i) = find(data(:,i) == min(data(:,i))); 
    maxnum(i) = find(data(:,i) == max(data(:,i))); 
end 
snum = unique([minnum,maxnum]); 
D1 = data(snum,:); % D1是包含各测点最大最小值的历史数据
remain = setdiff(1:2461,snum); 
data_rem = data(remain,:); 
n1 = size(data_rem,1); 
% 求出每个历史数据的L2范数，并对其降序排列
for j=1:n1 
    datanorm2(j) = norm(data_rem(j,:),2); 
end 
[~,index] = sort(datanorm2,'descend'); 
rem_sorted = zeros(n1,m); 
for j=1:n1 
    rem_sorted(j,:) = data_rem(index(j),:); 
end 
% 对剩余数据进行抽取 
D2 = downsample(rem_sorted,t,round(rand(1,1)*(t-1))); 
D = [D1;D2]; % D为最终状态矩阵
