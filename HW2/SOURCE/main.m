close all;clear all; clc;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

target = imread("../DATA/2/IMAGE1.png");
target = rgb2gray(target);
template = imread("../DATA/2/TEMPLATE.png");
template = rgb2gray(template);
template = imresize(template, 0.1);


[ximage, xtemplate] = FindMatch(target,template);

[x1, x2] = FindMatch(template,target);
% ShowMatchedPoints(x1, x2, template, target);

A = AlignImageUsingFeature(x1, x2, 3, 500);
DrawBox(A, template, target);
%%
output_size=size(template);
I_warped = WarpImage(target,A,output_size);
figure;
set(gcf, 'Position',  [100, 100, 3000, 500])
subplot(1,4,1), imshow(target);
subplot(1,4,2), imshow(I_warped);
subplot(1,4,3), imshow(template);
subplot(1,4,4), imshow(abs(template-I_warped));

A_refined = AlignImage(template, target, A);

frame1 = imread("../DATA/2/IMAGE1.png");
frame1 = rgb2gray(frame1);
frame2 = imread("../DATA/2/IMAGE2.png");
frame2 = rgb2gray(frame2);
frame3 = imread("../DATA/2/IMAGE3.png");
frame3 = rgb2gray(frame3);
frame4 = imread("../DATA/2/IMAGE4.png");
frame4 = rgb2gray(frame4);
image_cell = {frame1 frame2 frame3 frame4};

A_cell = TrackMultiFrames(template, image_cell);
%%
for i=1:4
    DrawBox(A_cell{i}, template, image_cell{i});
end