function [A] = AlignImageUsingFeature(x1, x2, ransac_thr, ransac_iter)
    A = [rand(2,3); 0 0 1];
    x1_pad = [x1'; ones(1,size(x1,1))];
    x2_pad = A*x1_pad;
    
end

function [bestModel] = RANSAC(x1, x1_pad, x2, threshold, iterations)
    
end