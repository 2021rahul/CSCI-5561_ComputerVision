function [label_test_pred] = PredictSVM(feature_train, label_train, feature_test)
    num_classes = size(unique(label_train), 1);
    models = containers.Map();
    for i=1:num_classes
        new_labels = ones(size(label_train)).*(-1);
        new_labels(label_train==i)=1;
        [w, b] = vl_svmtrain(feature_train', new_labels', 0.000005, 'solver', 'sdca', 'loss', 'hinge2');
        model = containers.Map();
        model("w") = w;
        model("b") = b;
        models(string(i)) = model;
    end
    
    score = zeros(size(feature_test,1), num_classes);
    for i=1:size(models,1)
        model = models(string(i));
        [~,~,~, scores] = vl_svmtrain(feature_test', new_labels', 0, 'model', model('w'), 'bias', model('b'), 'solver', 'none');
        score(:, i) = scores';
    end
    [~, label_test_pred] = max(score, [], 2);
end