close all

img = imread("../DATA/Einstein.jpg");
[filter_x, filter_y] = GetDifferentialFilter();
im_filtered_x = FilterImage(img, filter_x);
im_filtered_y = FilterImage(img, filter_y);
[grad_mag, grad_angle] = GetGradient(im_filtered_x, im_filtered_y);
ori_histo = BuildHistogram(grad_mag, grad_angle, 8);
hog = GetBlockDescriptor(ori_histo, 2);

figure;
set(gcf, 'Position',  [100, 100, 2000, 500]);
subplot(1,3,1), imshow(img), title('Input image');
subplot(1,3,2), imagesc(im_filtered_x), title('Differential along x direction');
subplot(1,3,3), imagesc(im_filtered_y), title('Differential along y direction');

figure;
set(gcf, 'Position',  [100, 100, 2000, 500])
subplot(1,3,1), imagesc(grad_mag), title('Gradient Magnitude');
subplot(1,3,2), imagesc(grad_angle), colorbar, title('Gradient Angle');
img_size = size(img);
img_filtered_size = size(im_filtered_x);
[x,y] = meshgrid(1:3:img_size(2), 1:3:img_size(1));
subplot(1,3,3), imshow(img), title('Gradient'), hold on;
q = quiver(x,y,im_filtered_y(2:3:img_filtered_size(1)-1,2:3:img_filtered_size(2)-1),im_filtered_x(2:3:img_filtered_size(1)-1,2:3:img_filtered_size(2)-1));
q.Color = 'red'; q.AutoScaleFactor = 2; q.LineWidth = 2; q.ShowArrowHead = 'off';

figure;
set(gcf, 'Position',  [100, 100, 2000, 500])
subplot(1,1,1), imshow(img), title('HOG features'), hold on;
[h, w, d] = size(hog);
[x,y] = meshgrid(5:8:8*w, 5:8:8*h);
for i=1:6
    magnitude = hog(:,:,i)+hog(:,:,i+6)+hog(:,:,i+12)+hog(:,:,i+18);
    theta = 2*(i-1)*pi/12;
    hog_x = magnitude.*(cos(theta)*ones(h,w));
    hog_y = magnitude.*(-sin(theta)*ones(h,w));
    q = quiver(x,y,hog_x,hog_y); q.Color='red'; q.AutoScaleFactor = 0.5; q.LineWidth = 1; q.ShowArrowHead = 'on';
    hold on;
end