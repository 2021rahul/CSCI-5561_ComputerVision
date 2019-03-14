function [label_test_pred] = PredictKNN(feature_train, label_train, feature_test, k)
    idx = knnsearch(feature_train, feature_test, 'k', k);
    labels = [];
    for i=1:k
        first_label = label_train(idx(:,i));
        labels = [labels first_label];
    end
    label_test_pred = mode(labels');
    label_test_pred = label_test_pred';
end