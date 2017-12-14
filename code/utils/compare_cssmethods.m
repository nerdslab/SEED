%%%%%%%%%%%%%%
% Function to compute approximation error and cut metrics for SEED
%%%%%%%%%%%%%%
% INPUT
% X = dataset (with N examples in columns)
% L = vector with number of samples (numsamples < N)
%%%%%%%%%%%%%%
% OUTPUT
% Results = struct containing results + parameters
%%%%%%%%%%%%%%
% Example Usage:
% Results = compare_cssmethods([],[1:5:150],[]);
%%%%%%%%%%%%%%

function Results = compare_cssmethods(X,L,opts)

[M,N] = size(X);
labels = ones(N,1);    

%%%%%% If X is empty, Generate synthetic data
if isempty(X)
   [X,labels] = gensynthdata(opts);
   [M,N] = size(X);
end

if ~isfield(opts,'labels')
    opts.labels = labels;
end

%%%%%% read in arguments (for sparse recovery)
if isfield(opts,'kmax')
    kmax = opts.kmax;
else
    kmax = 20;
end

if isfield(opts,'numselect')
    numselect = opts.numselect;
else
    numselect = 10;
    opts.numselect = 10;
end

if isfield(opts,'knn')
    knn = opts.knn;
else
    knn = kmax;
end

if isfield(opts,'epsilon')
    epsilon = opts.epsilon;
else
    epsilon = 0.05;
end

Xnm = sum(X(:).^2);
Lmax = max(L);
Errs = zeros(length(L),4);
Ncut = zeros(length(L),4);

if length(labels)~=N
    error('Not enough (or too many) labels!')
end


%%%%%%%%%%%%%%%%%%%
% Step 1. Column selection (oASIS, SES, Leverage, and Random)
%%%%%%%%%%%%%%%%%%%
% 1. oASIS sampling

Xnorm = normc(X);
Gf = @(r,c)GramMatrixSampler(Xnorm,r,c);
opts.verbose = true;            
opts.computeApproxSVD = false;  
opts.selection = [];            
opts.use_randomseed = true;    
opts.startSize = 1;     
[outs] = oASIS( Gf,L, 'oASIS', opts);
asisset = outs.selection;

% 2. Sequential error sampling (SES)
errset = errorsamp(X,Lmax,numselect); % select one signal at a time

% 3. Leverage sampling
levset = leveragesamp(X,M,Lmax);

% 4. Random sampling
randset = uniformsamp(Lmax,N);

%%%%%%%%%%%%%%%%%%%
% Step 2. Compute error and normalized cuts for different num of cols
%%%%%%%%%%%%%%%%%%%
for i=1:length(L)
    
    selection = unique(asisset(1:min(L(i),length(asisset))));
    [Errs(i,1),Ncut(i,1)] = compute_err_ncut(X,Xnm,selection,opts);
    
    selection = unique(errset(1:min(L(i),length(errset))));
    [Errs(i,2),Ncut(i,2)] = compute_err_ncut(X,Xnm,selection,opts);
    
    selection = unique(levset(1:min(L(i),length(levset))));
    [Errs(i,3),Ncut(i,3)] = compute_err_ncut(X,Xnm,selection,opts);
    
    selection = unique(randset(1:min(L(i),length(randset))));
    [Errs(i,4),Ncut(i,4)] =  compute_err_ncut(X,Xnm,selection,opts);

end


%%%%%%%%%%%%%%%%%%%
% Step 3. Compare to Gram, SSC, and NN
%%%%%%%%%%%%%%%%%%%
% NN matrix
if isfield(opts,'Gnn')
    Gnn = opts.Gnn;
else
    G = Xnorm'*Xnorm;
    Gnn = knngraph(abs(G),knn);
end

% Greedy SSC decomposition (SSC-OMP)
if isfield(opts,'Vssc')
    Vssc = opts.Vssc;
else
    Vssc = createsuppmat(X,kmax,epsilon);
end
Gssc= abs(Vssc)+abs(Vssc');
    
% Compute clustering metrics
ym = cocutmetric(G,1:N,labels);
sscm = cocutmetric(Gssc,1:N,labels);
nnm = cocutmetric(Gnn,1:N,labels);


%%%%%%%%%%%%%%%%%%%
% Step 4. Compile Results + Parameters
%%%%%%%%%%%%%%%%%%%
opts.M = M;
opts.N = N;
opts.L = L;
Results.opts = opts;
Results.X = X;
Results.Ncuts = [Ncut, ym*ones(length(L),1), ...
    sscm*ones(length(L),1), nnm*ones(length(L),1)];
Results.Errs = Errs;
Results.Labels = labels;
Results.ClustMethods = {'SEED','ErrorSamp','LeverageSamp','RandomSamp',...
                        'Gram','SSC', 'NN'};
Results.ErrMethods = {'SEED','ErrorSamp','LeverageSamp','RandomSamp'};
Results.oASISset = asisset;

end


function  refset = sortbylabel(selection,labels)

[~,i,~] = unique(selection);
notid = setdiff((1:length(selection)),i);
selection(notid)=[];
[~,idd] = sort(labels(selection)); 
refset = selection(idd);

end


