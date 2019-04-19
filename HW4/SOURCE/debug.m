clear all
close all
clc
%%
load('mnist_train.mat');
load('mnist_test.mat');
%%
batch_size = 30;
im_train = im_train/255;
im_test = im_test/255;
[mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size);
%%
num_batches = size(mini_batch_y,2);
input_length = size(mini_batch_x{1}(:,1),1);
num_classes = size(mini_batch_y{1}(:,1),1);

rng('default')
learning_rate = 0.6;
decay_rate = 0.99;
w_conv = normrnd(0,1,[3,3,1,3]);
b_conv = normrnd(0,1,[3,1]);
w_fc = normrnd(0,1,[10,147]);
b_fc = normrnd(0,1,[10,1]);
k=1;
nIter = 10000;
L = zeros(nIter,1);
%%
image=1;
x = reshape(mini_batch_x{k}(:,image), [14, 14, 1]);
a1=Conv(x,w_conv,b_conv);
f1 = ReLu(a1);
f2 = Pool2x2(f1);
f3 = Flattening(f2);
a2 = FC(f3,w_fc,b_fc);
%%
[Loss,dlda2] = Loss_cross_entropy_softmax(a2, mini_batch_y{k}(:, image));
[dldf3,dldw_fc,dldb_fc] = FC_backward(dlda2,f3,w_fc,b_fc,a2);
dldf2 = Flattening_backward(dldf3,f2,f3);
dldf1 = Pool2x2_backward(dldf2,f1,f2);
dlda1 = ReLu_backward(dldf1,a1,f1);
%%
[dldw_conv, dldb_conv] = Conv_backward(dlda1,x,w_conv,b_conv,a1);
%%