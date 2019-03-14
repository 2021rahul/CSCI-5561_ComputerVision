close all;clear all; clc;
dirname = '../DATA/scene_classification_data';
filename = fullfile(dirname, 'train.txt');
train = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

filename = fullfile(dirname, 'test.txt');
test = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);

output_size = [16, 16];
feature_train = zeros(size(train, 1), output_size(1)*output_size(2));
label_train = grp2idx(categorical(train{:,1}));
train_image_cell = {};
for i=1:size(train)
    img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
    train_image_cell{end+1} = img;
end

output_size = [16, 16];
feature_test = zeros(size(test, 1), output_size(1)*output_size(2));
label_test = grp2idx(categorical(test{:,1}));
test_image_cell = {};
for i=1:size(test)
    img = imread(fullfile(dirname, strrep(test{i,2}{1},'\','/')));
    test_image_cell{end+1} = img;
end

sift_features = [];
for i=1:max(size(train_image_cell))
    [f, d] = vl_dsift(single(train_image_cell{i}), 'step', 40);
    sift_features = [sift_features ; d'];
end

[idx,vocab] = kmeans(double(sift_features), 50, 'MaxIter', 1000);

[d, feature] = vl_dsift(single(test_image_cell{i}), 'step', 40);
idx = knnsearch(vocab, feature');
[C,ia,ic] = unique(idx);
value_counts = [C, accumarray(ic,1)];
boW_feature = zeros(1,50);
boW_feature(value_counts(:,1)) = value_counts(:,2);

%%
dirname = '../DATA/scene_classification_data';
filename = fullfile(dirname, 'train.txt');
train = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);
% train = train(randperm(size(train, 1), size(train, 1)), :);

filename = fullfile(dirname, 'test.txt');
test = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);
% test = test(randperm(size(test, 1), size(test, 1)), :);

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
%%
labels = unique(label_train);
models = containers.Map();
for i=1:size(labels, 1)
    new_labels = ones(size(label_train)).*(-1);
    new_labels(label_train==labels(i))=1;
    [w, b] = vl_svmtrain(feature_train', new_labels', 0.1);
    model = containers.Map();
    model("w") = w;
    model("b") = b;
    models(string(i)) = model;
end
%%
score = [];
for i=1:size(models,1)
    new_labels = ones(size(label_test)).*(-1);
    new_labels(label_test==labels(i))=1;
    model = models(string(i));
    w = model('w');
    b = model('b');
    [~,~,~, scores] = vl_svmtrain(feature_test', new_labels', 0, 'model', model('w'), 'bias', model('b'), 'solver', 'none');
    score = [score scores'];
    break;
end
%%
[val, class_label] = max(score, [], 2);



