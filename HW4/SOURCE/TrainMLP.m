function [w1, b1, w2, b2] = TrainMLP(mini_batch_x, mini_batch_y)
    num_batches = size(mini_batch_y,2);
    input_length = size(mini_batch_x{1}(:,1),1);
    num_classes = size(mini_batch_y{1}(:,1),1);

    rng('default')
    learning_rate = 0.5;
    decay_rate = 1;
    w1 = normrnd(0,1,[30,input_length]);
    b1 = normrnd(0,1,[30,1]);
    w2 = normrnd(0,1,[num_classes,30]);
    b2 = normrnd(0,1,[num_classes,1]);
    k=1;
    nIter = 10000;
    L = zeros(nIter,1);
    for iter=1:nIter
        if ~rem(iter, 1000)
            learning_rate = decay_rate*learning_rate;
        end
        dLdw1 = 0;
        dLdb1 = 0;
        dLdw2 = 0;
        dLdb2 = 0;
        num_images = size(mini_batch_x{k}, 2);
        for image=1:num_images
            a1=FC(mini_batch_x{k}(:,image),w1,b1);
            f1 = ReLu(a1);
            a2 = FC(f1,w2,b2);
            [Loss,dlda2] = Loss_cross_entropy_softmax(a2, mini_batch_y{k}(:, image));
            L(iter) = L(iter) + Loss;
            [dldf1,dldw2,dldb2] = FC_backward(dlda2,f1,w2,b2,a2);
            dlda1 = ReLu_backward(dldf1,a1,f1);
            [~,dldw1,dldb1] = FC_backward(dlda1,mini_batch_x{k}(:,image),w1,b1,a1);
            dLdw1 = dLdw1 + dldw1;
            dLdb1 = dLdb1 + dldb1;
            dLdw2 = dLdw2 + dldw2;
            dLdb2 = dLdb2 + dldb2;
        end
        k=k+1;
        if k > num_batches
            k = 1;
        end
        w1 = w1-(learning_rate*dLdw1')/num_images;
        b1 = b1-(learning_rate*dLdb1')/num_images;
        w2 = w2-(learning_rate*dLdw2')/num_images;
        b2 = b2-(learning_rate*dLdb2')/num_images;
        L(iter) = L(iter)/num_images;
    end
    figure(2);
    plot(L);
    ylim([-0.1 20]);
end