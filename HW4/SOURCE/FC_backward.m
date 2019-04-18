function [dLdx, dLdw, dLdb] = FC_backward(dLdy, x, w, b, y)
    dLdw = x*dLdy;
    dLdx = dLdy*w;
    dLdb = dLdy;
end