function [label_test_pred] = PredictKNN(feature_train, label_train, feature_test, k)
    model = fitcknn(feature_train, label_train, 'NumNeighbors', k);
    label_test_pred = predict(model, feature_test);
end