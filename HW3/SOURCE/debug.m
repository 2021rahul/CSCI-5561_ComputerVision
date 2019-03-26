%%
close all;clear all; clc;
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
%BUILD VISUAL DICTIONARY
sift_features = [];
for i=1:max(size(train_image_cell))
%     [~, feature] = vl_dsift(single(train_image_cell{i}), 'fast', 'step', 20, 'size', 10);
    [~, feature] = vl_dsift(single(train_image_cell{i}), 'fast', 'step', 5);
    sift_features = [sift_features ; double(feature)'];
end
%%
dic_size = 40;
[~,vocab] = kmeans(sift_features, dic_size, 'MaxIter', 2000);
% vocab = BuildVisualDictionary(train_image_cell, dic_size);
% vocab = sp_BuildVisualDictionary(train_image_cell, dic_size);
%%
%COMPUTE BOW
feature_train = zeros(size(train, 1), dic_size);
label_train = grp2idx(train{:,1});
for i=1:size(train)
    img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
    [~, feature] = vl_dsift(single(img), 'fast', 'step', 20, 'size', 10);
    feature_train(i,:) = ComputeBoW(double(feature)', vocab);
%     feature_train(i,:) = sp_ComputeBoW(double(feature)', vocab);
end
%%
feature_test = zeros(size(test, 1), dic_size);
label_test = grp2idx(test{:,1});
for i=1:size(test)
    img = imread(fullfile(dirname, strrep(test{i,2}{1},'\','/')));
    [~, feature] = vl_dsift(single(img), 'fast', 'step', 20, 'size', 10);
    feature_test(i,:) = ComputeBoW(double(feature)', vocab);
%     feature_test(i,:) = sp_ComputeBoW(double(feature)', vocab);
end
%%
label_test_pred = PredictKNN(feature_train, label_train, feature_test, 10);
% label_test_pred = sp_PredictKNN(feature_train, label_train, feature_test, 15);
confusion = confusionmat(label_test, label_test_pred);
accuracy = (sum(label_test_pred==label_test)*100)/ size(label_test, 1);
%%
label_test_pred = PredictSVM(feature_train, label_train, feature_test);
% label_test_pred = sp_PredictSVM(feature_train, label_train, feature_test);
confusion = confusionmat(label_test, label_test_pred);
accuracy = (sum(label_test_pred==label_test)*100)/ size(label_test, 1);
