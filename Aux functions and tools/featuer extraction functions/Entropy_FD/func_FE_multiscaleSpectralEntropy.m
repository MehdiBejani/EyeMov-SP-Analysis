function MSE= func_FE_multiscaleSpectralEntropy(x,Fs,tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MultiScale Spectral Entropy
%
%  Input parameters:                                                     
%       - x:        Input signal must be a vector with dimension N    
%       - Fs:       Sampling frequency  
%       - tau:      width of each scale                          
%                                                                         
%   Output:                                                   
%       - MSE:        MultiScale Spectral entropy value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y = mean(buffer(x(:), tau), 1);

MSE=pentropy(y,Fs,'Instantaneous',false);