function X = coeffmatrix(Supp,Coef,L)

N = size(Coef,2);
X = zeros(L,N); 
%idx = idx(1:L);

for i=1:N 
    which = find(Supp(:,i));
    newid = Supp(which,i);
    X(newid,i) = Coef(which,i); 
end


end
