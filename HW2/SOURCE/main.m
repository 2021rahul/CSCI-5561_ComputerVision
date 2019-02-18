close all;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

image = imread("../DATA/IMAGE.png");
image = rgb2gray(image);
template = imread("../DATA/TEMPLATE.png");
template = rgb2gray(template);

[ximage, xtemplate] = FindMatch(image,template);







% figure;
% imshow(template);
% perm = randperm(size(f,2)) ;
% sel = perm(1:500);
% templateh = vl_plotframe(f(:,sel)) ;
% set(templateh,'color','y','linewidth',2) ;