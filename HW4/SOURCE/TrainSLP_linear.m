function [w, b] = TrainSLP_linear(mini_batch_x, mini_batch_y)
    input_length = size(mini_batch_x{1}(:,1),1);
    num_classes = size(mini_batch_y{1}(:,1),1);

    rng('default')
    learning_rate = 0.00001;
    decay_rate = 0.9;
    w = normrnd(0,1,[num_classes,input_length]);
    b = normrnd(0,1,[num_classes,1]);
    k=1;
    for iter=1:1000000
        if ~rem(iter, 1000)
            learning_rate = decay_rate*learning_rate;
        end
        dLdw = 0;
        dLdb = 0;
        num_images = size(mini_batch_x{k}, 2);
        for image=1:num_images
            y=FC(mini_batch_x{k}(:,image),w,b);
            [~,dLdy] = Loss_euclidean(y, mini_batch_y{k}(:, image));
            [~,dldw,dldb] = FC_backward(dLdy,mini_batch_x{k}(:,image),w,b,mini_batch_y{k}(:, image));
            dLdw = dLdw + dldw;
            dLdb = dLdb + dldb;
        end
        k=k+1;
        w = w-(learning_rate*dLdw);
        b = b-(learning_rate*dLdb);
    end
end