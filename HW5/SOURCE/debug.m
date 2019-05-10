close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('../DATA/left.bmp');
im2 = imread('../DATA/right.bmp');
%%
[x1, x2] = FindMatch(im1, im2);
%%
F_mat = estimateFundamentalMatrix(x1,x2);
%%
[F] = ComputeF(x1, x2);
%%
F = F_mat;
%%
K = [350 0 960/2;
     0 350 540/2;
     0 0 1];
[R1, C1, R2, C2, R3, C3, R4, C4] = ComputeCameraPose(F, K);
%%
P0 = K*[eye(3) zeros([3,1])];
P1 = K*R1*[eye(3) -C1];
P2 = K*R2*[eye(3) -C2];
P3 = K*R3*[eye(3) -C3];
P4 = K*R4*[eye(3) -C4];
[X1] = Triangulation(P0, P1, x1, x2);
[X2] = Triangulation(P0, P2, x1, x2);
[X3] = Triangulation(P0, P3, x1, x2);
[X4] = Triangulation(P0, P4, x1, x2);
%%
[R,C,X] = DisambiguatePose(R1,C1,X1,R2,C2,X2,R3,C3,X3,R4,C4,X4);
%%
[H1, H2] = ComputeRectification(K, R, C);
im1_w = WarpImage(im1, H1);
im2_w = WarpImage(im2, H2);
%%
% imshow(im1_w)
imshow(im2_w)
%%
im1_w = imresize(im1_w, 0.5);
im2_w = imresize(im2_w, 0.5);
[disparity] = DenseMatch(im1_w, im2_w);

figure(1)
clf;
imagesc(disparity);
axis equal
axis off
colormap(jet);