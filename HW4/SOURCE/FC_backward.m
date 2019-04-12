function [dLdx, dLdw, dLdb] = FC_backward(dLdy, x, w, b, y)
    n = max(size(y));
    m = max(size(x));
    dLdx = dLdy*w;
    dLdb = dLdy;
    dydw = zeros(n, n*m);
    for i=1:n
        dydw(i, ((i-1)*n)+1:((i-1)*n)+m) = x';
    end
end