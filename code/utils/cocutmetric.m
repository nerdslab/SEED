function out = cocutmetric(V,selection,labels)

[L,N1] = size(V);
N = L+N1;
V=abs(V).*(abs(V)>1e-5);

% number of clusters
numc = length(unique(labels));

if length(selection)==N1
    notselect = 1:N1;
else
    notselect = setdiff(1:N1,selection);
end

out=[]; labels2 = unique(labels);
for i=1:numc
    % find points that use points from another class
    
    classid = labels2(i);
    
    whichrows = find(labels(selection)==classid);
    whichcols = find(labels(notselect)==classid);
    notrows = setdiff(1:L,whichrows);
    notcols = setdiff(1:length(notselect),whichcols);
    
    if ( classid~=0 && isempty(whichrows)~=1 )
        cut1 = sum(sum(V(whichrows,notselect(notcols))))./sum(sum(V(whichrows,:)));
        cut2 = sum(sum(V(notrows,notselect(whichcols))))./sum(sum(V(:,notselect(whichcols))));
        
        cutt = cut1+cut2;
        if isnan(cutt)
            cutt=0;
        end
        out = [out cutt];
    end
end

out = min(out);


end

