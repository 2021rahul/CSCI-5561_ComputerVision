close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('../DATA/left.bmp');
im2 = imread('../DATA/right.bmp');
%%
[seef1,seed1] = vl_dsift(single(padarray(rgb2gray(im1),[2 2],0,'symmetric')),'step',1,'size',1,'Geometry',[5 5 8]);
[seef2,seed2] = vl_dsift(single(padarray(rgb2gray(im2),[2 2],0,'symmetric')),'step',1,'size',1,'Geometry',[5 5 8]);
%%
% see = (seef1-[2;2])';
% seet = reshape(see, [540,960,2]);
% seex = seet(:,:,1);
% seey = seet(:,:,2);
see = GridForm(seef1, 540, 960);
seex = seet(:,:,1);
seey = seet(:,:,2);

function d = GridForm(d, H, W)
    d = reshape(d',[H W min(size(d))]);
end
%%
% [f1,d1] = vl_sift(single(rgb2gray(im1)));
% [f2,d2] = vl_sift(single(rgb2gray(im2)));
% %%
% [x1, x2] = FindMatch(im1, im2);
% %%
% [F] = ComputeF(x1, x2);
% %%
% K = [350 0 960/2;
%      0 350 540/2;
%      0 0 1];
% [R1, C1, R2, C2, R3, C3, R4, C4] = ComputeCameraPose(F, K);
% %%
% P1 = K*[eye(3) zeros([3,1])];
% P2 = K*R1*[eye(3) -C1];
% [X1] = Triangulation(P1, P2, x1, x2);
% 
% P1 = K*[eye(3) zeros([3,1])];
% P2 = K*R2*[eye(3) -C2];
% [X2] = Triangulation(P1, P2, x1, x2);
% 
% P1 = K*[eye(3) zeros([3,1])];
% P2 = K*R3*[eye(3) -C4];
% [X3] = Triangulation(P1, P2, x1, x2);
% 
% P1 = K*[eye(3) zeros([3,1])];
% P2 = K*R4*[eye(3) -C4];
% [X4] = Triangulation(P1, P2, x1, x2);
% %%
% [R,C,X] = DisambiguatePose(R1,C1,X1,R2,C2,X2,R3,C3,X3,R4,C4,X4);
