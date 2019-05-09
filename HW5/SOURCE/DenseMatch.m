function [disp] = DenseMatch(im1, im2)
    [H,W] = size(im1);
    [~,d1] = vl_dsift(single(padarray(rgb2gray(im1),[2 2],0,'symmetric')),'step',1,'size',1,'Geometry',[5 5 8]);
    [~,d2] = vl_dsift(single(padarray(rgb2gray(im2),[2 2],0,'symmetric')),'step',1,'size',1,'Geometry',[5 5 8]);
    num_features = min(size(d1));
    d1 = reshape(d1',[H W num_features]);
    d2 = reshape(d2',[H W num_features]);
    disp = zeros([H,W]);
    for i=1:H
        [~,disp(i,:)] = knnsearch(reshape(d2(i,:,:),[],num_features), reshape(d1(i,:,:),[],num_features));
    end
end