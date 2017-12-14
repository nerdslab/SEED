
function slev = leveragescores(X,k)

if size(X,1)>size(X,2)
    r = rank(X);
    [Uk,tmp] = eigs(X'*X,0.9*r);
    
else
    [Uk,tmp] = eigs(X'*X,k);
end
    
slev = sum((Uk').^2);

end