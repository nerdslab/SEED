function rval = GramMatrixSampler(Z,r,c)

% If we're given a list of points, return the inner products for the list
if length(r)>1
    rList = Z(:,r)';
    cList = Z(:,c);
    rval = rList*cList';
    return;
end

% The Diagonal of the Gram matrix = ones
if strcmp(r,'D') || strcmp(c,'D')
    rval = ones(size(Z,2),1);
    return;
end

% Compute a single entry in the Gram matrix
if ~isempty(r)
    rval = Z(:,r)'*Z(:,c);
    return;
end

% Compute the cth column of G
% assume that Z is normalized!!
rval = Z'*Z(:,c);
return;

end