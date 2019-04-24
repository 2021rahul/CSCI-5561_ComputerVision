function [x1, x2] = FindMatch(I1,I2)
    [f1,d1] = vl_sift(single(rgb2gray(I1)));
    [f2,d2] = vl_sift(single(rgb2gray(I2)));
    d1 = double(d1);
    d2 = double(d2);
    f1 = f1'; d1=d1'; f2=f2'; d2=d2';
    [idx12, D] = knnsearch(d2, d1, "k", 2);
    idx12 = idx12(:,1);
    idx12(D(:,1)./D(:,2) >= 0.7) = 0;
    [idx21, D] = knnsearch(d1, d2, "k", 2);
    idx21 = idx21(:,1);
    idx21(D(:,1)./D(:,2) >= 0.7) = 0;
    
    idx = BiDirectional(idx12, idx21);
    x1 = f1(idx~=0, 1:2);
    x2 = f2(idx12(idx~=0), 1:2);
end

function [idx] = BiDirectional(idx12, idx21)
    for i=1:size(idx12)
        if idx12(i)~=0 && idx21(idx12(i))~=i
            idx12(i)=0;
        end
    end
    idx = idx12;
end
