function [y] = Conv(x, w_conv, b_conv)
    [H,W,C1]=size(x);
    [~,f,~,C2]=size(w_conv);
    padded_x = padarray(x, [(f-1)/2,(f-1)/2]);
    y = zeros([H,W,C2]);
    for filter=1:C2
        y_filter = zeros(H,W,C1);
        for c=1:C1
            col_x = im2col(padded_x(:,:,c),[f,f],'sliding');
            w = w_conv(:,:,c,filter);
            y_filter(:,:,c) = reshape(w(:)'*col_x,[H,W]);
        end
        bias = b_conv(filter)*ones([H,W]);
        y(:,:,filter) = sum(y_filter,3)+bias;
    end
end