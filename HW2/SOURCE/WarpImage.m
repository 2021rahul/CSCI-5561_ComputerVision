function [I_warped] = WarpImage(I, A, output_size)
    I_warped = zeros(output_size);
    for i=1:size(I,1)
        for j=1:size(I,2)
            x2 = [j,i];
            x1 = floor(inv(A)/x2);
            I_warped(x2) = I1(x1);
        end
    end
end