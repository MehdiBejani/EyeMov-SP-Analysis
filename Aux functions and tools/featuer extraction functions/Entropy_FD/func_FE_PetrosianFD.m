
function PFD = func_FE_PetrosianFD(signal)

% This function calculates Petrosian fractal dimension
%                                                                        
%   Input parameters:                                                     
%       - signal:       Input signal must be a vector with dimension N    
%                                                                         
%   Output:                                                   
%       - PFD:        Petrosian fractal dimension 
% -------------------------------------------------------------------------------
    ds=diff(signal);
    ax=sign(ds);
    n=length(signal);
    nd=sum(abs(diff(ax)))/2;
    PFD=log10(n)/(log10(n)+log10(n/(n+.4*nd)));
