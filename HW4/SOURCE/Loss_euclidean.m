function [L, dLdy] = Loss_euclidean(y_tilde, y)
    L = (y-y_tilde)'*(y-y_tilde);
    dLdy = (-2*(y-y_tilde))';
end