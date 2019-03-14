function [feature] = GetTinyImage(I, output_size)
    feature = imresize(I, output_size);
    feature = reshape(feature', 1, []);
end