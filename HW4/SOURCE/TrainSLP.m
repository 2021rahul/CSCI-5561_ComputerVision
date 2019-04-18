function [w, b] = TrainSLP(mini_batch_x, mini_batch_y)    
    num_batches = size(mini_batch_y,2);
    input_length = size(mini_batch_x{1}(:,1),1);
    num_classes = size(mini_batch_y{1}(:,1),1);

    rng('default')
    learning_rate = 1;
    decay_rate = 0.9;
    w = normrnd(0,1,[num_classes,input_length]);
    b = normrnd(0,1,[num_classes,1]);
    k=1;
    nIter = 10000;
    L = zeros(nIter,1);
    for iter=1:nIter
        if ~rem(iter, 1000)
            learning_rate = decay_rate*learning_rate;
        end
        dLdw = 0;
        dLdb = 0;
        num_images = size(mini_batch_x{k}, 2);
        for image=1:num_images
            y=FC(mini_batch_x{k}(:,image),w,b);
            [Loss,dLdy] = Loss_cross_entropy_softmax(y, mini_batch_y{k}(:, image));
            L(iter) = L(iter) + Loss;
            [~,dldw,dldb] = FC_backward(dLdy,mini_batch_x{k}(:,image),w,b,mini_batch_y{k}(:, image));
            dLdw = dLdw + dldw;
            dLdb = dLdb + dldb;
        end
        k=k+1;
        if k > num_batches
            k = 1;
        end
        w = w-(learning_rate*dLdw')/num_images;
        b = b-(learning_rate*dLdb')/num_images;
        L(iter) = L(iter)/num_images;
    end
    figure(2);
    plot(L);
    ylim([-0.1 20]);
end