function [confusion, accuracy] = ClassifySVM_BoW
    dirname = '../DATA/scene_classification_data';
    filename = fullfile(dirname, 'train.txt');
    train = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

    filename = fullfile(dirname, 'test.txt');
    test = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

    output_size = [16, 16];
    feature_train = zeros(size(train, 1), output_size(1)*output_size(2));
    label_train = grp2idx(categorical(train{:,1}));
    for i=1:size(train)
        img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
        feature_train(i,:) = GetTinyImage(img, output_size);
    end

    output_size = [16, 16];
    feature_test = zeros(size(test, 1), output_size(1)*output_size(2));
    label_test = grp2idx(categorical(test{:,1}));
    for i=1:size(test)
        img = imread(fullfile(dirname, strrep(test{i,2}{1},'\','/')));
        feature_test(i,:) = GetTinyImage(img, output_size);
    end
    
    label_test_pred = PredictSVM(feature_train, label_train, feature_test);
    confusion = confusionmat(label_test, label_test_pred);
    accuracy = (sum(label_test_pred==label_test)*100)/ size(label_test, 1);
end