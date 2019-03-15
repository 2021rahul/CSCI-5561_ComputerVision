close all;clear all; clc;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

for i=1:15
    template = imread("../DATA/messi/frame"+string(i)+".jpg");
    template = imresize(template, [1000 700]);
    imwrite(template, "../DATA/messi/img"+string(i)+".jpg");
end