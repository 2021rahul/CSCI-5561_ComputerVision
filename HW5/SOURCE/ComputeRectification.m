function [H1, H2] = ComputeRectification(K, R, C)
    rx = c/norm(C);
    rzhat = [0;0;1];
    rz = rzhat-(rzhat*rx')*rx/norm(rzhat - (rzhat*rx')*rx);
    ry = cross(rz,rx);
    Rrect = [rx';ry';rz'];
    H1 = K*Rrect/K;
    H2 = K*Rrect*R'/K;
end