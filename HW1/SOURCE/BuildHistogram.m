function ori_histo = BuildHistogram(grad_mag, grad_angle, cell_size)
    im_size = size(grad_mag);
    ori_histo_size = [floor(im_size(1)/cell_size) floor(im_size(2)/cell_size) 6];
    ori_histo = zeros(ori_histo_size);
    for i=1:ori_histo_size(1)
        for j=1:ori_histo_size(2)
            cell_grad_mag = grad_mag((cell_size*(i-1))+1:(cell_size*(i-1))+cell_size, (cell_size*(j-1))+1:(cell_size*(j-1))+cell_size);
            cell_grad_angle = grad_angle((cell_size*(i-1))+1:(cell_size*(i-1))+cell_size, (cell_size*(j-1))+1:(cell_size*(j-1))+cell_size);
            mask = GetMask(cell_grad_angle);
            ori_histo(i,j,:) = GetHisto(cell_grad_mag, mask);
        end
    end
end

function mask = GetMask(grad_angle)
    [m, n] = size(grad_angle);
    mask = zeros(m, n);
    for i=1:m
        for j=1:n
            angle = grad_angle(i, j);
            if (angle>=(11*pi/12) && angle<pi) || (angle>=0 && angle<(pi/12))
                mask(i,j) = 1;
            elseif (angle>=(pi/12) && angle<(3*pi/12))
                mask(i,j) = 2;
            elseif (angle>=(3*pi/12) && angle<(5*pi/12))
                mask(i,j) = 3;
            elseif (angle>=(5*pi/12) && angle<(7*pi/12))
                mask(i,j) = 4;
            elseif (angle>=(7*pi/12) && angle<(9*pi/12))
                mask(i,j) = 5;
            elseif (angle>=(9*pi/12) && angle<(11*pi/12))
                mask(i,j) = 6;
            end
        end
    end
end

function histogram = GetHisto(cell_grad_mag, mask)
    mask_vals = unique(mask);
    histogram = zeros(6,1);
    for i=1:numel(mask_vals)
        histogram(int16(mask_vals(i))) = sum(cell_grad_mag(mask==mask_vals(i)));
    end
end