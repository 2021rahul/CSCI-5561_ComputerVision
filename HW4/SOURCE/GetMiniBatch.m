function [mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size)
    label_train = OneHotEncoding(label_train);
    index = randperm(max(size(label_train)));
    mini_batch_x = {};
    mini_batch_y = {};
    i=1;
    while i<max(size(index))
        if i+batch_size<max(size(index))
            mini_batch_x{end+1} = im_train(:,index(i:i+batch_size-1));
            mini_batch_y{end+1} = label_train(:,index(i:i+batch_size-1));
        else
            mini_batch_x{end+1} = im_train(:,index(i:end));
            mini_batch_y{end+1} = label_train(:,index(i:end));
        end
        i = i+batch_size;
    end
end

function [one_hot_label] = OneHotEncoding(label_train)
    labels = unique(label_train);
    one_hot_label = zeros(max(size(labels)), max(size(label_train)));
    one_hot_label = one_hot_label';
    for i=1:max(size(unique(label_train)))
        mask = label_train==i-1;
        one_hot_label(mask, i)=1;
    end
    one_hot_label = one_hot_label';
end