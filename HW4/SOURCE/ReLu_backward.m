function [dLdx] = ReLu_backward(dLdy, x, y)
    dLdx = dLdy;
    dLdx(x'<0) = 0;
end