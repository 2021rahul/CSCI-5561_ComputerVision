function [bow_feature] = sp_ComputeBoW(feature, vocab) 
    pre_histogram=knnsearch(vocab, feature);
    histo=histcounts(pre_histogram,'BinLimits', [1,size(vocab, 1)],'BinMethod','integers');
    bow_feature=histo/norm(histo);
end