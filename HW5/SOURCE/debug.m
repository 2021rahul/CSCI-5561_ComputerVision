close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('../DATA/left.bmp');
im2 = imread('../DATA/right.bmp');
[f1,d1] = vl_sift(single(rgb2gray(im1)));
[f2,d2] = vl_sift(single(rgb2gray(im2)));
%%
[X1, X2] = FindMatch(im1, im2);
%%
[F] = ComputeF(X1, X2);
%%
K = [700/2 0 960/2;
     0 700/2 540/2;
     0 0 1];
[R1, C1, R2, C2, R3, C3, R4, C4] = ComputeCameraPose(F, K);
%%