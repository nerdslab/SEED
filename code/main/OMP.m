function [Supp,Coef,CMat,normz] = OMP(Data,Phi,k,varargin)
% k = max sparsity
% varargin{1} = errtol = amount of error for sparse appx of each signal
% varargin{2} = flag, if flag == 1, flag data points that cant be
% represented with at least kmax atoms

% REad in Optional Arguments
%flag=0; 
errtol=1e-5;
%errflag=[];
[~,num] = size(Data);

if nargin==5
    errtol = varargin{1};
    %flag=varargin{2};
elseif nargin==4
    errtol = varargin{1};
end

% Initialize Variables
Supp=zeros(k,num);
Coef=zeros(k,num);
normz = zeros(num,1);

for ii=1:num
    
    data = Data(:,ii);
    resid=data;
    
    supp=[];

        for i=1:k % loop to select k atoms
            proxy = Phi'*resid;
            [~,idx] = max(abs(proxy));
            supp = [supp, idx];
            coef = pinv(Phi(:,supp))*data;
            y = Phi(:,supp)*coef;
            resid = data - y;    
            nmz = norm(resid)./norm(data);
            
            if nmz<errtol
                break
            end
            
            %plotimg(y)

        end % end loop to select k atoms
        
       
    Coef(1:length(coef),ii) = coef;
    Supp(1:length(supp),ii) = supp;
    
    normz(ii) = norm(y);
    % ii
   
end % end loop over Data vectors (diff signals to form appx over)


CMat = coeffmatrix(Supp,Coef,size(Phi,2));

end % end function



