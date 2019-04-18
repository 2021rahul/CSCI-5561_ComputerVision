function [w1, b1, w2, b2] = TrainMLP(mini_batch_x, mini_batch_y)
    input_length = size(mini_batch_x{1}(:,1),1);
    num_classes = size(mini_batch_y{1}(:,1),1);

    rng('default')
    learning_rate = 0.00001;
    decay_rate = 0.9;
    w1 = normrnd(0,1,[30,input_length]);
    b1 = normrnd(0,1,[30,1]);
    w2 = normrnd(0,1,[num_classes,30]);
    b2 = normrnd(0,1,[num_classes,1]);
    k=1;
    for iter=1:1000000
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
            a2 = FC(f1,w2,b3);
            [~,dlda2] = Loss_cross_entropy_softmax(a2, mini_batch_y{k}(:, image));
            [dldf1,dldw2,dldb2] = FC_backward(dlda2,f1,w2,b2,a2);
            dlda1 = ReLu_backward(dldf1,a1,f1);
            [~,dldw1,dldb1] = FC_backward(dlda1,mini_batch_x{k}(:,image),w1,b1,a1);
            dLdw1 = dLdw1 + dldw1;
            dLdb1 = dLdb1 + dldb1;
            dLdw2 = dLdw2 + dldw2;
            dLdb2 = dLdb2 + dldb2;
        end
        k=k+1;
        w1 = w1-(learning_rate*dLdw1);
        b1 = b1-(learning_rate*dLdb1);
        w2 = w2-(learning_rate*dLdw2);
        b2 = b2-(learning_rate*dLdb2);
    end
end