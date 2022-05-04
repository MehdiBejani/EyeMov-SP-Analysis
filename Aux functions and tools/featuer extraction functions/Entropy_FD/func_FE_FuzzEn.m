function fuzEn = func_FE_FuzzEn(signal,m,r,n)

% This function calculates Fuzzy Entropy based on the algorithm in the following reference:
%------------------------------------------------------------------------------------
% Xiang, J., Li, C., Li, H., Cao, R., Wang, B., Han, X., & Chen, J. (2015). 
% The detection of epileptic seizure signals based on fuzzy entropy. 
% Journal of neuroscience methods, 243, 18-25.
%------------------------------------------------------------------------------------
%                                                                        
%   Input parameters:                                                     
%       - signal:       Input signal must be a vector with dimension N    
%       - m:            Embedding dimension (m <= N-2)                    
%       - r:            Width of the exponential function                 
%       - n:            (Optional) gradient of the exponential function (default =1)                            %
%                                                                         
%   Output:                                                   
%       - fuzEn:        Fuzzy entropy value 
% -------------------------------------------------------------------------------

    % Error detection and defaults
    if nargin < 3, error('Not enough parameters.'); end
    if nargin < 4
        n=1;
    end
    if m > length(signal)-2
        error('Embedding dimension must be smaller than the signal length minus 2 (m<N-2).');
    end
    
    [s1,s2]=size(signal);
    if (s1>1) && (s2>1)
        error('input signal must be a vector');
    end
    if s1>s2
        signal=signal';
    end
    N=length(signal);
    % Creating reconstructed vectors minus the average 
    Xm=buffer(signal, m+1 , m, 'nodelay');
    Xm1=Xm(1:m,:)-mean(Xm(1:m,:));
    Xm1 = Xm1';
    % distance calcultion
    dm = pdist(Xm1,'chebychev');
    % calculating similarity degree
    Dm=exp(-(dm.^n)./r);
    pi_1=mean(Dm);
    %%% increasing m by one and repeating the previous steps
    % Creating reconstructed vectors minus the average 
    Xm2=Xm-mean(Xm);
    Xm2 = Xm2';
    % distance calcultion
    dm = pdist(Xm2,'chebychev');
    % calculating similarity degree
    Dm=exp(-(dm.^n)./r);
    pi_2=mean(Dm);
    
    % Fuzzy entropy
    fuzEn=log(pi_1)-log(pi_2);
end