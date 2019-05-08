function [F] = ComputeF(x1, x2)
    max_inliers = 0;
    nIter = 1000;
    epsilon = 0.0001;
    for iter = 1:nIter
        index = randperm(max(size(x1)));
        u = [x1(index(1:8),:) ones(8,1)];
        v = [x2(index(1:8),:) ones(8,1)];
        A = zeros(8,9);
        for i=1:8
            x = u(i,:)'*v(i,:);
            A(i,:) = x(:)';
        end
        f = null(A);
        F = reshape(f(:,1), [3,3])';
        [U,S,V] = svd(F);
        S(3,3) = 0;
        F = U*S*V';
        if sum(diag([x1 ones(size(x1,1),1)]*F*[x2 ones(size(x1,1),1)]')<epsilon) > max_inliers
            max_inliers = sum(diag([x1 ones(size(x1,1),1)]*F*[x2 ones(size(x1,1),1)]')<epsilon);
            bestF = F;
        end
    end
    F = bestF;
end

