function [S,T] = Concatenation(S1,S2,T1,T2)
    l1=size(S1,1);
    S=[S1;S2];
    T=[T1;T2+l1];
end