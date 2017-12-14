function [currset] = errorsamp(Y,L,Ns)
%rand('twister',5489)
N = size(Y,2);
Ni = 10;
    
% initialize alg with Ns points
currset = unique(ceil(rand(Ni,1)*(N-1)));
other = setdiff((1:N),currset)';
Lcurr= length(currset);

while (Lcurr<L)    
    
    % compute approx error
    Proj=Y(:,currset)*pinv(Y(:,currset));
    errdist = sum((Proj*Y(:,other) - Y(:,other)).^2);
    newid = randomsamp(Ns,errdist);
    
    % update index set
    currset = [currset; other(newid)];
    other(newid)=[];
    Lcurr = length(currset);
        
end

end % end function


