function ShannEn = func_FE_ShannEn(signal,n)

% This function calculates Shannon Entropy based on the following algorithm 
%------------------------------------------------------------------------------------
% - The number of n intervals of the signal is selected.
% - The width of each interval is calculated from the formula (xmax-xmin)/n.
% - The number of points of the signal that are placed in each interval is counted: Ni i = 1: n
% - Probability pi = Ni / N is calculated.
% - Shannon entropy is calculated using the formula H=-sum(pi.log2(pi))  i=1->n.
%------------------------------------------------------------------------------------
%                                                                        
%   Input parameters:                                                     
%       - signal:       Input signal must be a vector with dimension N    
%       - n:            number of devision                            %
%                                                                         
%   Output:                                                   
%       - ShannEn:        Shannon entropy value 
% Author: Golnaz Baghdadi
% -------------------------------------------------------------------------------

    if nargin < 2
        n=3;
    end
    [s1,s2]=size(signal);
    if (s1>1) && (s2>1)
        error('input signal must be a vector');
    end
    if s1>s2
        signal=signal';
    end
    N=length(signal);

    L= (max(signal)-min(signal))/n; % width of amplitude bins
    for i=1:n
        p(i)=(length(find((((i-1)*L)+min(signal))<=signal & signal<((i*L)+min(signal)))))/N;
    end
    ShannEn=-sum(p.*log2(p));
    