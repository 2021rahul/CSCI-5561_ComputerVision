% im1 = imread('left.bmp');
% im2 = imread('right.bmp');
%%
close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('../DATA/left.bmp');
im2 = imread('../DATA/right.bmp');
figure(1);
imshow(im1);
saveas(gcf,"../RESULT/im1.png")
figure(2);
imshow(im2);
saveas(gcf,"../RESULT/im2.png")
%%
K = [350 0 960/2;
     0 350 540/2;
         0 0 1];
[x1, x2] = FindMatch(im1, im2);
save("../RESULT/x1.mat",'x1');
save("../RESULT/x2.mat",'x2');
figure(3);
ax=axes;
showMatchedFeatures(im1, im2, x1, x2, 'montage','Parent',ax);
saveas(gcf,"../RESULT/matched_points.png")
%%
% [F] = ComputeF(x1, x2);
F = estimateFundamentalMatrix(x1,x2);
save("../RESULT/F.mat",'F');
%%
% Compute four configurations of camera pose given F
[R1, C1, R2, C2, R3, C3, R4, C4] = ComputeCameraPose(F, K);
%% Fill your code here
% Triangulate Points using four configurations
% e.g., P1: reference camera projection matrix at origin, P2: relative
% camera projection matrix with respect to P1
% X1 = Triangulation(P1, P2, x1, x2);
P0 = K*[eye(3) zeros([3,1])];
P1 = K*R1*[eye(3) -C1];
P2 = K*R2*[eye(3) -C2];
P3 = K*R3*[eye(3) -C3];
P4 = K*R4*[eye(3) -C4];

% [X1] = Triangulation(P0, P1, x1, x2);
% [X2] = Triangulation(P0, P2, x1, x2);
% [X3] = Triangulation(P0, P3, x1, x2);
% [X4] = Triangulation(P0, P4, x1, x2);

[X1] = triangulate(x1,x2,P0',P1');
[X2] = triangulate(x1,x2,P0',P2');
[X3] = triangulate(x1,x2,P0',P3');
[X4] = triangulate(x1,x2,P0',P4');
%%
% Disambiguate camera pose
[R,C,X] = DisambiguatePose(R1,C1,X1,R2,C2,X2,R3,C3,X3,R4,C4,X4);
save("../RESULT/X.mat",'X')
%%
% Stereo rectification
[H1, H2] = ComputeRectification(K, R, C);
im1_w = WarpImage(im1, H1);
im2_w = WarpImage(im2, H2);
save("../RESULT/im1_w.mat",'im1_w')
save("../RESULT/im2_w.mat",'im2_w')
figure(4);
imshow(im1_w);
saveas(gcf,"../RESULT/im1_w.png")
figure(5);
imshow(im2_w);
saveas(gcf,"../RESULT/im2_w.png")
%%
im1_w = imresize(im1_w, 0.2);
im2_w = imresize(im2_w, 0.2);
[disp] = DenseMatch(im1_w, im2_w);
% [disp] = disparityBM(rgb2gray(im1_w),rgb2gray(im2_w));
save("../RESULT/disp.mat",'disp')
%%
figure(6)
imagesc(disp);
axis equal
axis off
colormap(jet);
saveas(gcf,"../RESULT/disp.png")