clc 
clear all
close all
Target=imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\Target.jpg');
Template=imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\Template.jpg');

[m n p]=size(Template);
figure,imshow(Template);
figure,imshow(Target);

ransac_thr=1;
ransac_iter=500;

[x1,x2]=findMatch(Template,Target);
[A]=AlignImageUsingFeature(x1,x2, ransac_thr,ransac_iter);

x21=zeros(3,1);
x22=zeros(3,1);
x23=zeros(3,1);
x24=zeros(3,1);

x11=[1;1;1];
x12=[n;1;1];
x13=[n;m;1];
x14=[1;m;1];

x21=A*x11;
x22=A*x12;
x23=A*x13;
x24=A*x14;

width=x22(1)-x21(1);
height=x24(2)-x21(2);

figure;
imshow(Target);
hold on;
rectangle('Position', [x21(1) x21(2) width height], 'EdgeColor', 'r');

% warps the target image onto the template image
output_size=[m n];
[I_warped]= WarpImage(rgb2gray(Target),A,output_size);
error_map=abs(rgb2gray(Template)-I_warped);
figure;
imshow(error_map);

[A_refined]=AlignImage(rgb2gray(Template),rgb2gray(Target),A);

