close all;clear all; clc;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

target = imread("../DATA/2/IMAGE1.png");
target = rgb2gray(target);
template = imread("../DATA/2/TEMPLATE.png");
template = rgb2gray(template);
template = imresize(template, 0.2);


[ximage, xtemplate] = FindMatch(target,template);

[x1, x2] = FindMatch(template,target);
%%
figure;ax=axes;
showMatchedFeatures(template, target, x1, x2, 'montage','Parent',ax);
%%
A = AlignImageUsingFeature(x1, x2, 3, 500);
DrawBox(A, template, target);
%%
output_size=size(template);
I_warped = WarpImage(target,A,output_size);
figure;
set(gcf, 'Position',  [100, 100, 3000, 500])
subplot(1,4,1), imshow(target), title('Target Image');
subplot(1,4,2), imshow(I_warped), title('Warped Image');
subplot(1,4,3), imshow(template), title('Template Image');
subplot(1,4,4), imshow(abs(template-I_warped)), title('Error Image');
%%
A_refined = AlignImage(template, target, A);
%%
frame1 = imread("../DATA/2/IMAGE1.png");
frame2 = imread("../DATA/2/IMAGE2.png");
frame3 = imread("../DATA/2/IMAGE3.png");
frame4 = imread("../DATA/2/IMAGE4.png");
image_cell = {rgb2gray(frame1) rgb2gray(frame2) rgb2gray(frame3) rgb2gray(frame4)};

set(gcf, 'Position',  [100, 100, 3000, 500])
subplot(2,2,1), imshow(frame1), title('Frame1');
subplot(2,2,2), imshow(frame2), title('Frame2');
subplot(2,2,3), imshow(frame3), title('Frame3');
subplot(2,2,4), imshow(frame4), title('Frame4');
%%
[imind,cm] = rgb2ind(frame1,256);
imwrite(imind,cm,'Frames','gif', 'Loopcount',inf);
[imind,cm] = rgb2ind(frame2,256);
imwrite(imind,cm,'Frames','gif','WriteMode','append');
[imind,cm] = rgb2ind(frame3,256);
imwrite(imind,cm,'Frames','gif','WriteMode','append');
[imind,cm] = rgb2ind(frame4,256);
imwrite(imind,cm,'Frames','gif','WriteMode','append');
%%
[A_cell, template_cell] = TrackMultiFrames(template, image_cell);
%%
for i=1:4
    figure(i);
%     imshow(template_cell{i});
    DrawBox(A_cell{i}, template_cell{i}, image_cell{i});
end