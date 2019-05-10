function [H1, H2] = ComputeRectification(K, R, C)
    rx = C/norm(C);
    rzhat = [0;0;1];
    rz = (rzhat-dot(rzhat,rx)*rx)/norm(rzhat-dot(rzhat,rx)*rx);
    ry = cross(rz,rx);
    Rrect = [rx';ry';rz'];
    H1 = K*Rrect/K;
    H2 = K*Rrect*R'/K;
end