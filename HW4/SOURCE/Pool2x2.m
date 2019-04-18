function [y] = Pool2x2(x)
    y = zeros(size(x,1)/2,size(x,2)/2,size(x,3));
    for channel=1:size(x,3)
        image_col = im2col(x(:,:,channel),[2,2],'distinct');
        y(:,:,channel) = reshape(max(image_col), [size(x,1)/2,size(x,2)/2]);
    end
end