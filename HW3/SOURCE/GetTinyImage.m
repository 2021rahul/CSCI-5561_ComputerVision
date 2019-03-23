function [feature] = GetTinyImage(I, output_size)
    feature = imresize(I, output_size);
    feature = double(reshape(feature, [], 1));
    feature = feature - mean(feature);
    feature = feature/norm(feature);
end