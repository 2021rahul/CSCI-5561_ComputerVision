function [im_filtered] = FilterImage(im, filter)
    im = im2double(im);
    padded_im = padarray(im, [1,1]);
    im_size = size(padded_im);
    im_filtered = zeros(im_size);
    for i=2:im_size(1)-1
        for j=2:im_size(2)-1
            im_filtered(i-1, j-1) = sum(sum(padded_im(i-1:i+1, j-1:j+1).*filter));
        end
    end
end

