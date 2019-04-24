close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
%%
im1 = imread('../DATA/left.bmp');
im2 = imread('../DATA/right.bmp');

K = [700/2 0 960/2;
     0 700/2 540/2;
     0 0 1];

[x1, x2] = FindMatch(im1, im2);
figure;ax=axes;
showMatchedFeatures(im1, im2, x1, x2, 'montage','Parent',ax);