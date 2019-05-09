function [R,C,X] = DisambiguatePose(R1,C1,X1,R2,C2,X2,R3,C3,X3,R4,C4,X4)
    N1 = NValid(R1,C1,X1);
    N2 = NValid(R2,C2,X2);
    N3 = NValid(R3,C3,X3);
    N4 = NValid(R4,C4,X4);
    if N1 == max([N1 N2 N3 N4])
        R = R1;
        C = C1;
        X = X1;
    elseif N2 == max([N1 N2 N3 N4])
        R = R2;
        C = C2;
        X = X2;
    elseif N3 == max([N1 N2 N3 N4])
        R = R3;
        C = C3;
        X = X3;
    elseif N4 == max([N1 N2 N3 N4])
        R = R4;
        C = C4;
        X = X4;
    end
end

function N = NValid(R,C,X)
    N = sum((X-C')*R(3,:)' >0);
end