function [mad] = MAD(sig1, sig2)
% Maximum Absolute Distance Metric
%
%  ECG1:        This is the Groun truth signal
%  ECG2:        This is the Processed signal to be compared with
%               the Groun truth signal
%  mad:         The output value of MAD metric
%
%  Reference:
%  R. Nygaard, G. Melnikov, A.K. Katsaggelos, A rate distortion optimal ECG coding
%  algorithm,%  IEEE Trans. Biomed. Eng. 48 (2001) 28–40. doi:10.1109/10.900246.
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com

    if (size(sig1) == size(sig2))
        % We are interest in the shape of signals, then we have to
        % eliminate the bias due to DC components runnin metrics on
        % the derivate of the signals

        %dECG1 = diff(ECG1);
        %dECG2 = diff(ECG2);

        dECG1 = sig1;
        dECG2 = sig2;

        % Measure implementation
        ds = abs(dECG1 - dECG2);
        mad = max(ds);

    else
        disp('The signals have diferent size')
    end

end