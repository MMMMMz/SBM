function D = iterMatrix(data,tau) 
% 输入数据生成状态矩阵D（每次迭代增加一数据点）
[n, ~] = size(data); 
sim_matrix = zeros(n,n); % 相似度矩阵 
for i = 1:n 
    for j = 1:n 
        sim_matrix(i,j) = Eul(data(i,:),data(j,:)); 
    end 
end 
sim_add = sum(sim_matrix); 
mid_index = find(sim_add == min(sim_add)); 
D = data(mid_index,:); % geometric median 
data(mid_index,:) = []; 
k = 1; 
while k <= n-1 
        for t = 1:size(D,1) 
            sim_x(k,t) = Eul(data(k,:),D(t,:)); 
        end 
        minsim(k) = min(sim_x(k,:)); 
        if minsim(k) < tau 
            D = [D;data(k,:)]; 
        end 
        k = k+1; 
end 