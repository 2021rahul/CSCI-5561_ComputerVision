function [confusion, accuracy] = ClassifyKNN_BoW
    dic_size = 50;
    dirname = '../DATA/scene_classification_data';
    filename = fullfile(dirname, 'train.txt');
    train = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

    filename = fullfile(dirname, 'test.txt');
    test = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

    output_size = [16, 16];
    train_image_cell = {};
    for i=1:size(train)
        img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
        train_image_cell{end+1} = img;;
    end

    vocab = BuildVisualDictionary(train_image_cell, dic_size);
    
    feature_train = zeros(size(train, 1), dic_size);
    label_train = grp2idx(categorical(train{:,1}));
    for i=1:size(train)
        img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
        [d, feature] = vl_dsift(single(img), 'step', 40);
        feature_train(i,:) = ComputeBoW(feature, vocab);
    end
    
    feature_test = zeros(size(test, 1), dic_size);
    label_test = grp2idx(categorical(test{:,1}));
    for i=1:size(test)
        img = imread(fullfile(dirname, strrep(test{i,2}{1},'\','/')));
        [d, feature] = vl_dsift(single(img), 'step', 40);
        feature_test(i,:) = ComputeBoW(feature, vocab);
    end
    
    label_test_pred = PredictKNN(feature_train, label_train, feature_test, 5);
    confusion = confusionmat(label_test, label_test_pred);
    accuracy = (sum(label_test_pred==label_test)*100)/ size(label_test, 1);
end