%%
close all;clear all; clc;
dic_size = 50;
dirname = '../DATA/scene_classification_data';
filename = fullfile(dirname, 'train.txt');
train = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

filename = fullfile(dirname, 'test.txt');
test = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);
%%
train_image_cell = {};
for i=1:size(train)
    img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
    train_image_cell{end+1} = img;
end
%%
[~, feature] = vl_dsift(single(train_image_cell{i}), 'Fast', 'step', 20, 'size', 10);
%%
%BUILD VISUAL DICTIONARY
sift_features = [];
for i=1:max(size(train_image_cell))
    [~, feature] = vl_dsift(single(train_image_cell{i}), 'Fast', 'step', 20, 'size', 10);
    sift_features = [sift_features ; double(feature)'];
end
%%
[~,vocab] = kmeans(sift_features, dic_size, 'MaxIter', 2000);
%%
%COMPUTE BOW
feature_train = zeros(size(train, 1), dic_size);
label_train = grp2idx(train{:,1});
for i=1:size(train)
    img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
    [~, feature] = vl_dsift(single(img), 'Fast', 'step', 20, 'size', 10);
    idx = knnsearch(vocab, double(feature)');
    [C,ia,ic] = unique(idx);
    value_counts = [C, accumarray(ic,1)];
    bow_feature = zeros(1,50);
    bow_feature(value_counts(:,1)) = value_counts(:,2);
    feature_train(i,:) = bow_feature/norm(bow_feature);
end
%%
feature_test = zeros(size(test, 1), dic_size);
label_test = grp2idx(test{:,1});
for i=1:size(test)
    img = imread(fullfile(dirname, strrep(test{i,2}{1},'\','/')));
    [~, feature] = vl_dsift(single(img), 'Fast', 'step', 20, 'size', 10);
    idx = knnsearch(vocab, double(feature)');
    [C,ia,ic] = unique(idx);
    value_counts = [C, accumarray(ic,1)];
    bow_feature = zeros(1,50);
    bow_feature(value_counts(:,1)) = value_counts(:,2);
    feature_test(i,:) = bow_feature/norm(bow_feature);
end
%%
label_test_pred = PredictKNN(feature_train, label_train, feature_test, 10);
confusion = confusionmat(label_test, label_test_pred);
accuracy = (sum(label_test_pred==label_test)*100)/ size(label_test, 1);
%%
label_test_pred = PredictSVM(feature_train, label_train, feature_test);
confusion = confusionmat(label_test, label_test_pred);
accuracy = (sum(label_test_pred==label_test)*100)/ size(label_test, 1);
