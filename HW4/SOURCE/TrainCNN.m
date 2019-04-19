function [w_conv, b_conv, w_fc, b_fc] = TrainCNN(mini_batch_x, mini_batch_y)
    num_batches = size(mini_batch_y,2);
    input_length = size(mini_batch_x{1}(:,1),1);
    num_classes = size(mini_batch_y{1}(:,1),1);

    rng('default')
    learning_rate = 0.1;
    decay_rate = 0.9;
    w_conv = normrnd(0,1,[3,3,1,3]);
    b_conv = normrnd(0,1,[3,1]);
    w_fc = normrnd(0,1,[10,147]);
    b_fc = normrnd(0,1,[10,1]);
    k=1;
    nIter = 10000;
    L = zeros(nIter,1);
    for iter=1:nIter
        iter
        if ~rem(iter, 1000)
            learning_rate = decay_rate*learning_rate;
        end
        dLdw_conv = 0;
        dLdb_conv = 0;
        dLdw_fc = 0;
        dLdb_fc = 0;
        num_images = size(mini_batch_x{k}, 2);
        for image=1:num_images
            x = reshape(mini_batch_x{k}(:,image), [14, 14, 1]);
            a1=Conv(x,w_conv,b_conv);
            f1 = ReLu(a1);
            f2 = Pool2x2(f1);
            f3 = Flattening(f2);
            a2 = FC(f3,w_fc,b_fc);

            [Loss,dlda2] = Loss_cross_entropy_softmax(a2, mini_batch_y{k}(:, image));
            L(iter) = L(iter) + Loss;
            
            [dldf3,dldw_fc,dldb_fc] = FC_backward(dlda2,f3,w_fc,b_fc,a2);
            dldf2 = Flattening_backward(dldf3,f2,f3);
            dldf1 = Pool2x2_backward(dldf2,f1,f2);
            dlda1 = ReLu_backward(dldf1,a1,f1);
            [dldw_conv, dldb_conv] = Conv_backward(dlda1,x,w_conv,b_conv,a1);
                        
            dLdw_conv = dLdw_conv + dldw_conv;
            dLdb_conv = dLdb_conv + dldb_conv;
            dLdw_fc = dLdw_fc + dldw_fc;
            dLdb_fc = dLdb_fc + dldb_fc;
        end
        k=k+1;
        if k > num_batches
            k = 1;
        end
        w_conv = w_conv-(learning_rate*dLdw_conv)/num_images;
        b_conv = b_conv-(learning_rate*dLdb_conv)/num_images;
        w_fc = w_fc-(learning_rate*dLdw_fc')/num_images;
        b_fc = b_fc-(learning_rate*dLdb_fc')/num_images;
        L(iter) = L(iter)/num_images;
    end
    PlotLoss(L,"CNN");
end