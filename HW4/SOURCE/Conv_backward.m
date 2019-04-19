function [dLdw, dLdb] = Conv_backward(dLdy, x, w_conv, b_conv, y)
    [H,W,C1]=size(x);
    [~,f,~,C2]=size(w_conv);
    padded_x = padarray(x, [(f-1)/2,(f-1)/2]);
    dLdw = zeros(size(w_conv));
    dLdb = zeros(size(b_conv));
    for filter=1:C2
        dldw = zeros([f,f,C1]);
        for c=1:C1
            dldy = dLdy(:,:,filter);
            col_x = im2col(padded_x(:,:,c),[f,f],'sliding');
            col_x = col_x';
            dldw(:,:,c) = reshape(dldy(:)'*col_x, [f,f]);
        end
        dLdw(:,:,:,filter) = dldw;
        dLdb(filter) = sum(sum(dLdy(:,:,filter)));
    end
end