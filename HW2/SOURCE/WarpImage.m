function [I_warped] = WarpImage(I, A, output_size)
    I_warped = zeros(output_size, class(I));
    for i=1:output_size(1)
        for j=1:output_size(2)
            x2 = [j,i];
            x1 = floor(A*[x2 1]');
            I_warped(x2(2), x2(1)) = I(x1(2), x1(1));
        end
    end
end