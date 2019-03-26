function [vocab] = BuildVisualDictionary(training_image_cell, dic_size)
    sift_features = [];
    for i=1:max(size(training_image_cell))
        [~, feature] = vl_dsift(single(training_image_cell{i}), 'Fast', 'step', 20, 'size', 10);
        sift_features = [sift_features ; double(feature)'];
    end
    [~,vocab] = kmeans(sift_features, dic_size, 'MaxIter', 1000, 'Distance', 'correlation');
end