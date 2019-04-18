function [L, dLdy] = Loss_cross_entropy_softmax(x, y)
    y_tilde = exp(x)/sum(exp(x));
    L = sum(y.*log(y_tilde));
    dLdy_tilde = 1./y_tilde;
    dy_tildedx = diag(y_tilde)-(y_tilde*y_tilde');
    dLdy = dLdy_tilde*dy_tildedx;
end