%%
close all;clear all; clc;
dirname = '../DATA/scene_classification_data';
filename = fullfile(dirname, 'train.txt');
train = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);
train = train(randperm(size(train, 1), size(train, 1)), :);

filename = fullfile(dirname, 'test.txt');
test = readtable(filename,'Delimiter',' ', 'ReadVariableNames', false);
test = test(randperm(size(test, 1), size(test, 1)), :);

output_size = [16, 16];
feature_train = zeros(size(train, 1), output_size(1)*output_size(2));
label_train = grp2idx(train{:,1});
for i=1:size(train)
    img = imread(fullfile(dirname, strrep(train{i,2}{1},'\','/')));
    feature_train(i,:) = GetTinyImage(img, output_size)';
end

feature_test = zeros(size(test, 1), output_size(1)*output_size(2));
label_test = grp2idx(test{:,1});
for i=1:size(test)
    img = imread(fullfile(dirname, strrep(test{i,2}{1},'\','/')));
    feature_test(i,:) = GetTinyImage(img, output_size)';
end

%%
file=fopen("../DATA/scene_classification_data/train.txt");
end_of_file = fgetl(file);
train_class=[];
output_size=[16 16];
SP_feature_train=[];
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    train_class=[train_class; convertCharsToStrings(cell{1})];
    filename="../DATA/scene_classification_data/"+strrep(cell{2},'\','/');
    I=imread(filename);
    feature= SP_GetTinyImage(I, output_size);
    SP_feature_train=[SP_feature_train; feature'];
    end_of_file = fgetl(file);
end

fclose(file);
SP_label_train=grp2idx(train_class);

file=fopen("../DATA/scene_classification_data/test.txt");
end_of_file = fgetl(file);
test_class=[];
output_size=[16 16];
SP_feature_test=[];
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    test_class=[test_class; convertCharsToStrings(cell{1})];
    filename="../DATA/scene_classification_data/"+strrep(cell{2},'\','/');
    I=imread(filename);
    feature= SP_GetTinyImage(I, output_size);
    SP_feature_test=[SP_feature_test; feature'];

    end_of_file = fgetl(file);
end

fclose(file);
SP_label_test=grp2idx(test_class);
%%
[label_test_pred] = PredictKNN(feature_train, label_train, feature_test, 10);
accuracy= sum(label_test_pred==label_test)*100/size(label_test,1);
confusion = confusionmat(label_test,label_test_pred);
%%
label_test_pred = SP_PredictKNN(SP_feature_train, SP_label_train, SP_feature_test, 10);
confusion = confusionmat(SP_label_test, label_test_pred);
accuracy = (sum(label_test_pred==SP_label_test)*100)/ size(SP_label_test, 1);




