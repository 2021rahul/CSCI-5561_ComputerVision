function [x1, x2] = FindMatch(I1,I2)
    [f1,d1] = vl_sift(single(I1));
    [f2,d2] = vl_sift(single(I2));
    
    idx = knnsearch(d2',d1');
    x1 = f1';
    x1 = x1(:,1:2);
    x2 = f2';
    x2 = x2(idx,1:2);
end

