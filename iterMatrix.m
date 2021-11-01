% function [D,resIndex,outMartix] =  iterMatrix(data) 
function [D,resIndex] =  iterMatrix(data)
% 输入数据生成状态矩阵D（每次迭代增加一数据点）
    [n, ~] = size(data); 
    sim_matrix = zeros(n,n); % 相似度矩阵 
    for i = 1:n 
        for j = 1:n 
            sim_matrix(i,j) = Eul(data(i,:),data(j,:)); 
        end 
    end
   errorIndex = 1;
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
%     m = size(data,2); 
%     for i=1:m 
%         minnum(i) = find(data(:,i) == min(data(:,i))); 
%         maxnum(i) = find(data(:,i) == max(data(:,i))); 
%     end 
%     snum = unique([minnum,maxnum]); 
%     resIndex = unique([resIndex,snum]);
% %     resIndex = snum;
%     index = length(resIndex);
    
    %加入第二列数据 七个最小的和三个最大的
    sortRes = sortrows(data(:,2),'ascend');
    for i = 1 : 7
        specialIndex(i) =  find(data(:,2) == sortRes(i));
    end
    resIndex = unique([resIndex,specialIndex]);
    clear specialIndex;
    sortRes = sortrows(data(:,2),'descend');
    for i = 1 : 3
        specialIndex(i) =  find(data(:,2) == sortRes(i));
    end
    resIndex = unique([resIndex,specialIndex]);
    %加入第十列数据两个最小的和三个最大的
    clear specialIndex;
    sortRes = sortrows(data(:,10),'descend');
    for i = 1 : 3
        specialIndex(i) =  find(data(:,10) == sortRes(i));
    end
    resIndex = unique([resIndex,specialIndex]);
    clear specialIndex;
    sortRes = sortrows(data(:,10),'ascend');
    for i = 1 : 2
        specialIndex(i) =  find(data(:,10) == sortRes(i));
    end
    resIndex = unique([resIndex,specialIndex]);
    index = length(resIndex);
    
    for i = 1 : index
        D(i,:) = data(resIndex(i),:);
    end
    D = D(1:index,:);
    
    
    %进行矩阵填充
    while index < 30  %最终D填充到多少个
        [minIndex,rIndex] = minSim(data,D');
        if ~ismember(minIndex, resIndex)
            resIndex = unique([resIndex,minIndex]); 
            index = length(resIndex);
             for i = 1 : index
                 D(i,:) = data(resIndex(i),:);
             end
            
        end
    end
    index = length(resIndex);
    D = D(1:index,:);
%     for i = 1:30
%        outMartix(errorIndex) = getErrotVal(data,D(1:i,:)');
%        i
%        errorIndex = errorIndex + 1;
%     end 
%     %kmeans填充
%     [Idx,C] = kmeans(data,20);
%     for i = 1: 20
%         D = cat(1,D,C(i,:));
%         outMartix(errorIndex) = getErrotVal(data,D');
%         errorIndex = errorIndex + 1;
%     end
    [Idx,C] = kmeans(data,20);
    D = cat(1,D,C);
end