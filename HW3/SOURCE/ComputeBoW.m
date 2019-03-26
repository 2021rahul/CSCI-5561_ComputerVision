function [bow_feature] = ComputeBoW(feature, vocab)
    idx = knnsearch(vocab, feature, 'Distance', 'correlation');
    [C,~,ic] = unique(idx);
    value_counts = [C, accumarray(ic,1)];
    bow_feature = zeros(1,50);
    bow_feature(value_counts(:,1)) = value_counts(:,2);
    bow_feature = bow_feature/norm(bow_feature);
end