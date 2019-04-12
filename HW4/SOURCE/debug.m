load('../DATA/ReducedMNIST/mnist_train.mat');
load('../DATA/ReducedMNIST/mnist_test.mat');

imshow(uint8(reshape(im_train(:,1), [14, 14])))
%%
labels = unique(label_train);
one_hot_label = zeros(max(size(labels)), max(size(label_train)));
one_hot_label = one_hot_label';
for i=1:max(size(unique(label_train)))
    mask = label_train==i-1;
    one_hot_label(mask, i)=1;
end
one_hot_label = one_hot_label';

%%
batch_size = 10;
num_batches = max(size(label_train))/batch_size;
index = randperm(max(size(label_train)));
%%
mini_batch_x = {};
mini_batch_y = {};
i=1;
while i<max(size(index))
    if i+batch_size<max(size(index))
        mini_batch_x{end+1} = im_train(:,index(i:i+batch_size-1));
        mini_batch_y{end+1} = one_hot_label(:,index(i:i+batch_size-1));
    else
        mini_batch_x{end+1} = im_train(:,index(i:end));
        mini_batch_y{end+1} = one_hot_label(:,index(i:end));
    end
    i = i+batch_size;
end
%%
batch_size = 120;
[mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size);
%%
w = zeros(10,196);
x = zeros(196,1);
b = zeros(10,1);
y = FC(x, w, b);
%%
