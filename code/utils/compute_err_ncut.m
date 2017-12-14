function [Err,Ncut,VV] = compute_err_ncut(X,Xnm,selection,opts,varargin)
    
% Compute Self-Expressive Decomposition (SEED) [ X <=> (D,V) ]
% X' = D*V, D = normc(X_S), S = selection 
[D1,VV] = seed(X,selection,opts);

% Calculate LS-error
Err =  sum(sum((D1*pinv(D1)*X - X).^2))./Xnm;
    
% Calculate cut ratios
Ncut = cocutmetric(VV,selection,opts.labels); 
      
end   % end function

