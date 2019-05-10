function [disp] = DenseMatch(im1, im2)
    [H,W,~] = size(im1);
    [~,d1] = vl_dsift(single(padarray(rgb2gray(im1),[1 1],0,'symmetric')),'step',1,'size',1,'Geometry',[3 3 5]);
    [~,d2] = vl_dsift(single(padarray(rgb2gray(im2),[1 1],0,'symmetric')),'step',1,'size',1,'Geometry',[3 3 5]);
    num_features = min(size(d1));
    d1 = reshape(d1',[H W num_features]);
    d2 = reshape(d2',[H W num_features]);
    disp = zeros([H,W]);
    for i=1:H
        i
        for j=1:W
            [~,d] = knnsearch(double(reshape(d2(i,j:end,:),[],num_features)), double(reshape(d1(i,j,:),[],num_features)));
            disp(i,j) = d.^2;
        end
    end
end