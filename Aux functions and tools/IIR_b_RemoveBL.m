function [ECG_Clean] = IIR_b_RemoveBL(ecgy,Fs,Fc)
%  BLW removal method based on IIR Filter
%
%  ecgy:        the contamined signal
%  Fc:          cut-off frequency
%  Fs:          sample frequiency
%  ECG_Clean :  processed signal without BLW
%
%  Reference:
%  https://www.mathworks.com/help/signal/ref/butter.html
%
%  This variant use the Matlab butterword calculation coficients for a IIR filter
%  the results were better that the original implementation of the paper
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com

    [b,a] = butter(4,Fc/(Fs/2),'high');

    ECG_Clean = filtfilt (b,a,ecgy); % filtrado bidirecional
end