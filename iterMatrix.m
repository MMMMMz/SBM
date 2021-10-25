function [D,resIndex] =  iterMatrix(data, tau) 
% 输入数据生成状态矩阵D（每次迭代增加一数据点）
    [n, ~] = size(data); 
    sim_matrix = zeros(n,n); % 相似度矩阵 
    for i = 1:n 
        for j = 1:n 
            sim_matrix(i,j) = Eul(data(i,:),data(j,:)); 
        end 
    end
    
   %加入几何中值
    sim_add = sum(sim_matrix); 
    mid_index = find(sim_add == min(sim_add));  % geometric median index
    row_num = 100;
    D = zeros(row_num,10);
    index = 1;
    D(index,:) = data(mid_index,:);
    resIndex(index) = mid_index;
    index = index + 1;
    

 %最大最小值加入矩阵中
    m = size(data,2); 
    for i=1:m 
        minnum(i) = find(data(:,i) == min(data(:,i))); 
        maxnum(i) = find(data(:,i) == max(data(:,i))); 
    end 
    snum = unique([minnum,maxnum]); 
    resIndex = unique([resIndex,snum]);
    index = length(resIndex);

    for i = 1 : index
        D(i,:) = data(resIndex(i),:);
    end
    D = D(1:index,:);
    %进行矩阵填充
    data_remain = data;
    while index < 50  %最终D填充到多少个
        [minIndex,rIndex] = minSim(data,D');
        if ~ismember(minIndex, resIndex)
            index = index + 1;
            resIndex(index) = minIndex;
             for i = 1 : index
                 D(i,:) = data(resIndex(i),:);
            end
        end
    end
    index = length(resIndex);
    D = D(1:index,:);
end