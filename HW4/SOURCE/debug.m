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
dLdy = zeros(1, 10);
n = max(size(y));
m = max(size(x));
dLdx = dLdy*w;
dLdb = dLdy;
dydw = zeros(n, n*m);
for i=1:n
    dydw(i, ((i-1)*n)+1:((i-1)*n)+m) = x';
end
dLdw = dLdy*dydw;

%%
x = ones(10,1)
y_tilde = exp(x)/sum(exp(x))
L = sum(y.*log(y_tilde))
dLdy_tilde = (1./y_tilde)'
dy_tildedx = diag(y_tilde)-(y_tilde*y_tilde')
dLdy = dLdy_tilde*dy_tildedx
%%
x = cat(3,randi(10,4,4),randi(10,4,4),randi(10,4,4));
y=Pool2x2(x)
%%
for channel=1:size(x,3)
    i=1;
    while i<size(x,1)
        j=1;
        while j<size(x,2)
            x_new(floor(i/2)+1,floor(j/2)+1,channel) = max(max(x(i:i+1,j:j+1,channel)));
            j=j+2;
        end
        i=i+2;
    end
end
%%
% x = cat(3,randi(4,4),randi(4,4),randi(4,4))
x = randi(4,4)
see = im2col(x(:,:,1),[2,2],'distinct')
reshape(max(see), [2,2])
%%
x = cat(3,randi(10,4,4),randi(10,4,4),randi(10,4,4));
reshape(x(:), size(x))
%%
x = cat(3,randi(10,4,4),randi(10,4,4),randi(10,4,4));
w_conv = ones(3,3,3,4);
b_conv = ones(4);
%%
[H,W,C1]=size(x);
[~,f,~,C2]=size(w_conv);
padded_x = padarray(x, [(f-1)/2,(f-1)/2]);
y = zeros([H,W,C2]);
for filter=1:C2
    y_filter = zeros([H,W,C1]);
    for c=1:C1
        col_x = im2col(padded_x(:,:,c),[f,f],'sliding');
        w = w_conv(:,:,c,1);
        y_filter(:,:,c) = reshape(w(:)'*col_x,[H,W]);
    end
    bias = b_conv(filter)*ones([H,W]);
    y(:,:,filter) = sum(y_filter,3)+bias;
end
%%
y = Conv(x, w_conv, b_conv);
%%
y = AB_Conv(x, w_conv, b_conv);
