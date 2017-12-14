%%%%%%%%%%%%%%%%%%%
% Generate a union of subspaces dataset with overlapping pairs of subspaces
% At each iteration: generate X1 in S1, X2 in S2 and dim(S1+S2)<dim(S1)+dim(S2)
% Iteratively add a pair of overlapping subspaces to X = [X; X1; X2]; 
%%%%%%%%%%%%%%%%%%%
% INPUT
% opts.numsub (number of subspaces)
% opts.sampling (either 'uniform' or 'nonuniform' distribution of points on each subspace)
% opts.ambdim (ambient dimension for each point)
% opts.n1 (vector containing number of points per subspace in X1)
% opts.n2 (vector containing number of points per subspace in X2)
% opts.k1 (vector containing dimension of subspaces in X1)
% opts.k2 (vector containing dimension of subspaces in X2)
% opts.overlap (overlapping dimensions between subspaces in X1 and X2)
%%%%%%%%%%%%%%%%%%%
% EXAMPLE (1)
% opts.numsub = 10; % number of subspaces
% opts.ambdim=200; % ambient dimension of signals
% opts.subdim=10; % dimension of each subspace
% opts.n1=2.^[5:5+opts.numsubs/2]; % number of points in S1
% opts.n2=2.^[5:5+opts.numsubs/2]; % number of points in S2
% opts.k1=10*ones(1,opts.numsubs/2); % dimension of S1
% opts.k2=20*ones(1,opts.numsubs/2); % dimension of S2
% opts.overlap = 5; % dimension of intersection between pairs (S1,S2)
% opts.sampling = 'nonuniform'; %
% opts.kmax = opts.k2; opts.epsilon = 0.05;
% Results = compute_err([],[1:5:150],opts);
%%%%%%%%%%%%%%%%%%%
% EXAMPLE (2) = two 20-dim subspaces with 5-dim intersection
% opts.numsub = 2; opts.ambdim=100; opts.subdim=20; 
% opts.n1=200; opts.n2=200;
% opts.overlap = 5; opts.sampling = 'uniform';
%%%%%%%%%%%%%%%%%%%

function [Y,labels] = gensynthdata(opts) 

%%%%% Read in opts (or set to default)
if isfield(opts,'numsub')
    numsub = opts.numsub;
else
    numsub = 10;
end

if isfield(opts,'sampling')
    subsamp = opts.sampling;
else
    subsamp = 'uniform';
end

if isfield(opts,'ambdim')
    ambdim = opts.ambdim;
else
    ambdim = 200;
end

if isfield(opts,'n1')
    n1 = opts.n1;
else
    n1 = 2.^[4:4+numsub/2];
end

if isfield(opts,'n2')
    n2 = opts.n2;
else
    n2 = 2.^[4:4+numsub/2];
end

if isfield(opts,'k1')
    k1 = opts.k1;
else
    k1 = 20*ones(numsub/2,1);
end

if isfield(opts,'k2')
    k2 = opts.k2;
else
    k2 = 20*ones(numsub/2,1);
end

if isfield(opts,'overlap')
    overlap = opts.overlap;
else
    overlap = k2(1)/2;
end
%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%
%%% Create union of numsub/2 pairs of overlapping subspaces
Y=[];

for i=1:numsub/2
    Y1 = gendata(ambdim,n1(i),n2(i),k1(i),k2(i),overlap,subsamp);
    Y = [Y Y1];
end


%%%%%%%%%%%%%%%%%%%%
%%% Generate labels
clear tmp
tmp(1:2:numsub) = n1(1:numsub/2);
tmp(2:2:numsub) = n2(1:numsub/2);
tmp = [0, tmp];
N = cumsum(tmp);

labels = zeros(N(end),1);
for i=1:length(N)-1
    labels(N(i)+1:N(i+1))=i;
end

Y = removemean(Y); 

end % end main function


%%%%%% Generate data living on a union of two overlapping subspaces
function  [Y,D1,D2] = gendata(ambdim,n1,n2,k1,k2,numoverlap,varargin)
% Example (union of four 20-dimensional subspaces)
% Y1 = gensynthdata(200,50,200,20,20,5);
% Y2 = gensynthdata(200,30,100,20,20,5);
% Y = [Y1 Y2];
% Y = removemean(Y);

numarg=6;

if nargin>numarg
    method = varargin{1};
else
    method = 'uniform';
end

q = numoverlap;
n = ambdim; 

if q>k1
   display('Q > K !!') 
   Y=0;
   return
end

D1 = randn(n,k1);
D2 = [ D1(:,1:q) randn(n,k2-q) ] ;

if strcmp(method,'uniform')
    Y1 = D1*randn(k1,n1);
    Y2 = D2*randn(k2,n2);
    
elseif strcmp(method,'nonuniform')
    % nonuniform sampling of subspace
    % half of each subspace is distributed in k0-coordinates
    
    if nargin>numarg+1
        k0_1 = varargin{2};
        k0_2 = k0_1;
    else
        k0_1 = round(0.5*k1);
        k0_2 = round(0.5*k2);
    end
        
    choosek1 = ceil(rand(k0_1,1)*(k1-1));
    Lk1 = length(choosek1);
    Y1 = [D1(:,choosek1)*randn(Lk1,n1/2) , D1*randn(k1,n1/2)];
        
    choosek2 = ceil(rand(k0_2,1)*(k2-1));
    Lk2 = length(choosek2);
    Y2 = [D2(:,choosek2)*randn(Lk2,n2/2) D2*randn(k2,n2/2)];
end

    
Y = [Y1 Y2];

Y = normcol(Y);

end


function Y2 = removemean(Y)

Y2 = Y - repmat(mean(Y),size(Y,1),1);

end

