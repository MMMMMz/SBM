function [C] = Mul(A, B)
    C = zeros(size(A, 1), size(B, 2));
    for i = 1:size(A, 1)
        for j = 1:size(B, 2)
            C(i, j) = sum(Eul(A(i, :),B(:, j)'));
        end 
    end
end