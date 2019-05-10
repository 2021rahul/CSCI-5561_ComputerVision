function [X] = Triangulation(P1, P2, x1, x2)
    X = zeros(size(x1,1), 3);
    for i =1:size(x1,1)
        A = [SkewSymmetric([x1(i,:) 1])*P1 ; SkewSymmetric([x2(i,:) 1])*P2];
        x = NullSpace(A);
        X(i,:) = x(1:3);
    end
end

function x = NullSpace(A)
    [~,~,V] = svd(A);
    x = V(:, end);
    x = x./x(end);
end

function Ax = SkewSymmetric(A)
    Ax=[0 -A(3) A(2) ; A(3) 0 -A(1) ; -A(2) A(1) 0 ];
end
