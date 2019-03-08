close all;
run('~/MATLAB/vlfeat-0.9.21/toolbox/vl_setup')

target = imread("../DATA/IMAGE1.png");
target = rgb2gray(target);
template = imread("../DATA/TEMPLATE_1.png");
template = rgb2gray(template);

[x1, x2] = FindMatch(template,target);
A = AlignImageUsingFeature(x1, x2, 3, 500);

[template_x, template_y] = imgradientxy(template);
template_size=size(template);
H=zeros(6,6);
for i=1:template_size(1)
    for j=1:template_size(2)
       JacobianW=[[j i 1 0 0 0]; [0 0 0 j i 1]];
       H=H+([template_x(i,j) template_y(i,j)]*JacobianW)'*([template_x(i,j) template_y(i,j)]*JacobianW);
    end
end

epsilon=0.01;
error=[];
iter=1;
delp = ones(6,1);
while norm(delp) > epsilon
    [I_warped, F] = GetWarpedImage(template, target, A, template_x, template_y);
    delp=H\F;
    del_A=[[delp(1)+1 delp(2) delp(3)]; [delp(4) delp(5)+1 delp(6)]; [0 0 1]];
    A = A*del_A;
    error=[error norm(double(template-I_warped),'fro')];
    iter=iter+1
    break;
end
A_refined = A;

function [I_warped, F] = GetWarpedImage(template, target, A, template_x, template_y)
    template_size=size(template);
    I_warped = zeros(template_size, class(template));
    F=zeros(6,1);
    for i=1:template_size(1)
        for j=1:template_size(2)
            x2=[j,i];
            x1 = floor(A*[x2 1]');
            I_warped(x2(2), x2(1)) = target(x1(2), x1(1));
            JacobianW=[[x2(1) x2(2) 1 0 0 0]; [0 0 0 x2(1) x2(2) 1]];
            I_error=abs(template(i,j)-I_warped(i,j));
            F=F+(([template_x(i,j) template_y(i,j)]*JacobianW)'*double(I_error));
        end
    end
end