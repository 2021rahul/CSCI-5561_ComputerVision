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


% function [X] = Triangulation(P1, P2, x1, x2)
% 
% X=zeros(size(x1,1),3);
% for i=1:size(x1,1)
%     A_upper=[0 -1 x1(i,2); 1 0  -x1(i,1); -x1(i,2) x1(i,1) 0]*P1;
%     A_lower=[0 -1 x2(i,2); 1 0  -x2(i,1); -x2(i,2) x2(i,1) 0]*P2;
%     A=[A_upper;A_lower];
%     [U,S,V]=svd(A);
%     temp=V(:,4);
%     X_each=[temp(1,1)/temp(4,1)  temp(2,1)/temp(4,1)  temp(3,1)/temp(4,1)];
%     X(i,:)=X_each;
%     
% end
% 
% end