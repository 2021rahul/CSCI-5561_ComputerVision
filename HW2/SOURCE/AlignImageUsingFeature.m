function [A] = AlignImageUsingFeature(x1, x2, ransac_thr, ransac_iter)
    inliers = RANSAC(x1, x2, ransac_thr, ransac_iter);
    sum(inliers>0)
    [H, b] = GetAxbForm(x1(inliers,:), x2(inliers,:));
    [A] = LeastSquaresTransform(H, b);
end

function [max_inliers] = RANSAC(x1, x2, threshold, iterations)
    n = size(x1, 1);
    max_inliers = zeros(n, 1);
    for i=1:iterations
        indexes = randperm(n, 4);
        [A, b] = GetAxbForm(x1(indexes, :), x2(indexes, :));
        [H] = LeastSquaresTransform(A, b);
        x2transformed = Transform(H, x1);
        distances = diag(pdist2(x2transformed, x2));
        inliers = distances<threshold;
        if (sum(inliers)>sum(max_inliers))
            max_inliers = inliers;
        end
    end
end

function [A, b] = GetAxbForm(x1, x2)
    n = size(x1, 1);
    A = zeros(2*n, 6);
    b = zeros(2*n, 1);
    A(1:2:2*n,1:2) = x1;
    A(1:2:2*n,3) = 1;
    A(2:2:2*n,4:5) = x1;
    A(2:2:2*n,6) = 1;
    b(1:2:2*n) = x2(:,1);
    b(2:2:2*n) = x2(:,2);
end

function [H] = LeastSquaresTransform(A, b)
    x = (inv(A'*A)*A'*b);
    H = zeros(3);
    H(3,3) = 1;
    H(1:2,:) = reshape(x, 3, 2)';
end

function [xtransformed] = Transform(H, x)
    n = size(x, 1);
    x = [x ones(n, 1)];
    xtransformed = (H*x')';
    xtransformed = xtransformed(:,1:2);
end