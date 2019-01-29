function [hog] = HOG(im)
im = im2double(im);
filter_x, filter_y = GetDifferentialFilter();
im_filtered_x = FilterImage(im, filter_x);
im_filtered_y = FilterImage(im, filter_y);
grad_mag, grad_angle = GetGradient(im_filtered_x, im_filtered_y);
ori_histo = BuildHistogram(grad_mag, grad_angle, 10);
hog = GetBlockDescriptor(ori_histo, 10);
end