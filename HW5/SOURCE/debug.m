close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('../DATA/left.bmp');
im2 = imread('../DATA/right.bmp');
[f1,d1] = vl_sift(single(rgb2gray(im1)));
[f2,d2] = vl_sift(single(rgb2gray(im2)));
%%
d1 = double(d1);
d2 = double(d2);
f1 = f1'; d1=d1'; f2=f2'; d2=d2';
[idx12, D] = knnsearch(d2, d1, "k", 2);
idx12 = idx12(:,1);
idx12(D(:,1)./D(:,2) >= 0.7) = 0;
[idx21, D] = knnsearch(d1, d2, "k", 2);
idx21 = idx21(:,1);
idx21(D(:,1)./D(:,2) >= 0.7) = 0;
%%
sum(idx12~=0)
%%
[X1, X2] = FindMatch(im1, im2);
%%
P1 = [magic(3) ones(3,1)];
P2 = [magic(3) ones(3,1)];
%%
X = zeros(size(X1,1), 3);
for i =1:size(X1,1)
    A = [SkewSymmetric([X1(i,:) 1])*P1 ; SkewSymmetric([X2(i,:) 1])*P2];
    x = null(A);
    X(i,:) = x(1:3);
end
%%
function Ax = SkewSymmetric(A)
    Ax=[0 -A(3) A(2) ; A(3) 0 -A(1) ; -A(2) A(1) 0 ];
end

