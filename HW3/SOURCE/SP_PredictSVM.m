function [label_test_pred] = sp_PredictSVM(feature_train, label_train, feature_test) 
    lambda = 0.00005 ; % Regularization parameter
    w={};
    b={};
    for i=1:15
        new_label=-1*ones(size(label_train,1),1);
        new_label(label_train==i)=1;
        [w{i}, b{i} ,~] = vl_svmtrain(feature_train', new_label, lambda, 'solver', 'sdca', 'loss', 'hinge2');
    end

    scores=zeros(size(label_train,1),15);

    for i=1:15
        [~,~,~, scores(:,i)] = vl_svmtrain(feature_test', new_label, 0, 'model', w{i}, 'bias', b{i}, 'solver', 'none') ;
    end

    [~,label_test_pred]=max(scores');
    label_test_pred=label_test_pred';
end