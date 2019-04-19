function [dLdx] = Pool2x2_backward(dLdy, x, y)
    dLdx = zeros(size(x));
    for channel=1:size(x,3)
        x_col = im2col(x(:,:,channel),[2,2],'distinct');
        y_col = y(:,:,channel);
        y_col = y_col(:);
        dldy = dLdy(:,:,channel);
        dldy_col = dldy(:);
        dldx = zeros(size(x_col));
        for col=1:size(x_col,2)
            id = find(x_col(:,col)==y_col(col));
            dldx(id,col) = dldy_col(col);
        end
        dldx = col2im(dldx,[2,2],size(x),'distinct');
        dLdx(:,:,channel) = dldx;
    end
end    