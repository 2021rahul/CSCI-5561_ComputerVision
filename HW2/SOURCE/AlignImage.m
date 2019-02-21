function [A_refined] = AlignImage(template, target, A)
    p = permute(A, [2,1]);
    p = p(1:6);
    JacobianW = [0 0 1 0 0 0; 0 0 0 0 0 1];
    [filter_x, filter_y] = GetDifferentialFilter()
    im_x = FilterImage(template, filter_x)
    im_y = FilterImage(template, filter_y)
    steepest_images = GetSteepestImages(im_x, im_y, JacobianW);
    A_refined=template;
end 


function [steepest_images] = GetSteepestImages(I_x, I_y, JacobianW)
    steepest_images = zeros(size(I_x,1),size(I_x,2), 6);
    for i=1:size(JacobianW,2)
        steepest_images(:,:,i) = I_x.*JacobianW(1,i) + I_y.*JacobianW(2,i);
    end    
end


function [im_filtered] = FilterImage(im, filter)
    im = im2double(im);
    padded_im = padarray(im, [1,1]);
    im_size = size(padded_im);
    im_filtered = zeros(im_size);
    for i=2:im_size(1)-1
        for j=2:im_size(2)-1
            im_filtered(i, j) = convolution(padded_im(i-1:i+1, j-1:j+1), filter);
        end
    end
end

function [output] = convolution(matA, matB)
    matB = rot90(matB,2);
    output = sum(sum(matA.*matB));
end

function [filter_x, filter_y] = GetDifferentialFilter()
    filter_y = [1 1 1 ; 0 0 0 ; -1 -1 -1];
    filter_x = [1 0 -1 ; 1 0 -1 ; 1 0 -1];
end