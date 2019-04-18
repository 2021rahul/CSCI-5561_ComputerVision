function [dLdx] = ReLu_backward(dLdy, x, y)
    dLdx = dLdy;
    dLdx(y'<0) = 0;
end