function [A_refined] = AlignImage(template, target, A)
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
        A = A*inv(del_A);
        error=[error norm(double(template-I_warped),'fro')];
    end
    A_refined = A;
end 

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
            I_error=I_warped(i,j)-template(i,j);
            F=F+(([template_x(i,j) template_y(i,j)]*JacobianW)'*double(I_error));
        end
    end
end