function [vocab] = BuildVisualDictionary(training_image_cell, dic_size)
    sift_features = GetPoolSiftFeatures(training_image_cell);
    [idx,vocab] = kmeans(double(sift_features), dic_size, 'MaxIter', 1000);
end


function [sift_features] = GetPoolSiftFeatures(image_cell)
    sift_features = [];
    for i=1:max(size(image_cell))
        [f, d] = vl_dsift(single(image_cell{i}), 'step', 20);
        sift_features = [sift_features ; d'];
    end
end