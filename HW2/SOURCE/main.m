close all;clear all; clc;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

template = imread("../DATA/2/TEMPLATE.png");
target1 = imread("../DATA/2/IMAGE1.png");
target2 = imread("../DATA/2/IMAGE2.png");
target3 = imread("../DATA/2/IMAGE3.png");
target4 = imread("../DATA/2/IMAGE4.png");

template = rgb2gray(template);
template = imresize(template, 0.2);
target1 = rgb2gray(target1);
target2 = rgb2gray(target2);
target3 = rgb2gray(target3);
target4 = rgb2gray(target4);

image_cell = {target1 target2 target3 target4};

figure;
set(gcf, 'Position',  [100, 100, 3000, 200])
subplot(1,5,1), image(repmat(template,1,1,3)), title('Template');
subplot(1,5,2), image(repmat(image_cell{1},1,1,3)), title('Target1');
subplot(1,5,3), image(repmat(image_cell{2},1,1,3)), title('Target2');
subplot(1,5,4), image(repmat(image_cell{3},1,1,3)), title('Target3');
subplot(1,5,5), image(repmat(image_cell{4},1,1,3)), title('Target4');
%%
[x1, x2] = FindMatch(template,image_cell{1});
%%
figure;ax=axes;
showMatchedFeatures(template, image_cell{1}, x1, x2, 'montage','Parent',ax);
%%
A = AlignImageUsingFeature(x1, x2, 3, 1000);
output_size=size(template);
I_warped = WarpImage(image_cell{1}, A, output_size);
%%
template1 = [1,1];
template2 = [output_size(2),1];
template3 = [output_size(2), output_size(1)];
template4 = [1,output_size(1)];

target1 = [A*[template1 1]']';
target1 = target1(1:2);
target2 = [A*[template2 1]']';
target2 = target2(1:2);
target3 = [A*[template3 1]']';
target3 = target3(1:2);
target4 = [A*[template4 1]']';
target4 = target4(1:2);

x = [target1(1) target2(1) target3(1) target4(1) target1(1)];
y = [target1(2) target2(2) target3(2) target4(2) target1(2)];

figure;
set(gcf, 'Position',  [100, 100, 3000, 300])
subplot(1,4,1), image(repmat(image_cell{1},1,1,3)), hold on, plot(x, y, 'r'), title('Target Image');
subplot(1,4,2), image(repmat(I_warped,1,1,3)), title('Warped Image');
subplot(1,4,3), image(repmat(template,1,1,3)), title('Template Image');
subplot(1,4,4), image(repmat(abs(template-I_warped),1,1,3)), title('Error Image');
%%
A_refined = AlignImage(template, image_cell{1}, A);
%%
[A_cell] = TrackMultiFrames(template, image_cell);
%%
for i=1:max(size(image_cell))
    DrawBox(A_cell{i}, template, image_cell{i})
    template = WarpImage(image_cell{i}, A_cell{i}, size(template));
end