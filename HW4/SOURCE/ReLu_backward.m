function [dLdx] = ReLu_backward(dLdy, x, y)
    dLdx = dLdy;
    if size(x)>2
        dLdx(x<0) = 0;
    else
        dLdx(x'<0) = 0;
    end
end