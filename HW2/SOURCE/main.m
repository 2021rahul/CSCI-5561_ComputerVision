close all;clear all; clc;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

template = imread("../DATA/2/TEMPLATE.png");
target1 = imread("../DATA/2/IMAGE1.png");
target2 = imread("../DATA/2/IMAGE2.png");
target3 = imread("../DATA/2/IMAGE3.png");
target4 = imread("../DATA/2/IMAGE4.png");

set(gcf, 'Position',  [100, 100, 3000, 200])
subplot(1,5,1), image(template), title('Template');
subplot(1,5,2), image(target1), title('Target1');
subplot(1,5,3), image(target2), title('Target2');
subplot(1,5,4), image(target3), title('Target3');
subplot(1,5,5), image(target4), title('Target4');
%%
template = rgb2gray(template);
template = imresize(template, 0.1);
target1 = rgb2gray(target1);
target2 = rgb2gray(target2);
target3 = rgb2gray(target3);
target4 = rgb2gray(target4);
image_cell = {target1 target2 target3 target4};
%%
[x1, x2] = FindMatch(template,target);
%%
figure;ax=axes;
showMatchedFeatures(template, target, x1, x2, 'montage','Parent',ax);
%%
A = AlignImageUsingFeature(x1, x2, 3, 500);
%%
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
subplot(1,4,1), imshow(frame1), title('Frame1');
subplot(1,4,2), imshow(frame2), title('Frame2');
subplot(1,4,3), imshow(frame3), title('Frame3');
subplot(1,4,4), imshow(frame4), title('Frame4');
%%
[A_cell, template_cell] = TrackMultiFrames(template, image_cell);
%%
for i=1:4
    figure(i);
%     imshow(template_cell{i});
    DrawBox(A_cell{i}, template_cell{i}, image_cell{i});
end