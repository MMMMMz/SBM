function [d] = Eul(a, b)
    c = (a - b).^2;
    d = sqrt(sum(c( : )));
end