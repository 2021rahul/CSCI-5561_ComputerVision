close all;clear all; clc;
run('~/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')
%%

[ClassifyKNN_Tiny_confusion, ClassifyKNN_Tiny_accuracy] = ClassifyKNN_Tiny;
[ClassifyKNN_BoW_confusion, ClassifyKNN_BoW_accuracy] = ClassifyKNN_BoW;
[ClassifySVM_BoW_confusion, ClassifySVM_BoW_accuracy] = ClassifySVM_BoW;

