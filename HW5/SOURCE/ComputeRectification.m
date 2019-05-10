function [H1, H2] = ComputeRectification(K, R, C)
    rx = C/norm(C);
    rzhat = [0;0;1];
    rz = (rzhat-dot(rzhat,rx)*rx)/norm(rzhat-dot(rzhat,rx)*rx);
    ry = cross(rz,rx);
    Rrect = [rx';ry';rz'];
    H1 = K*Rrect*inv(K);
    H2 = K*Rrect*R'*inv(K);
end

% function [H1, H2] = ComputeRectification(K, R, C)
% rx_t=(C./norm(C))';
% rz_tilde=[0;0;1];
% rz= (rz_tilde- (dot(rz_tilde,rx_t')*rx_t'))./norm(rz_tilde- (dot(rz_tilde,rx_t')*rx_t'));
% ry=cross(rz,rx_t');
% 
% R_rect=[rx_t; ry'; rz'];
% 
% H1=K*R_rect*inv(K);
% H2=K*R_rect*R'*inv(K);
% end