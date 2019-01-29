img = imread("DATA/Einstein.jpg");
[filter_x, filter_y] = GetDifferentialFilter();
im_filtered_x = FilterImage(img, filter_x);
im_filtered_y = FilterImage(img, filter_y);
[grad_mag, grad_angle] = GetGradient(im_filtered_x, im_filtered_y);

subplot(1,3,1), imshow(img)
subplot(1,3,2), imshow(im_filtered_x)
subplot(1,3,3), imshow(im_filtered_y)