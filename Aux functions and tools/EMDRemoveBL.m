function [ECG_Clean] = EMDRemoveBL(sig,Fs, Fc)
%  BLW removal method based on Empirical Mode Decomposition
%  EMD toolbox developed by Rilling and Flandrin.
%
%  EMD library source code and install:
%  http://perso.ens-lyon.fr/patrick.flandrin/emd.html
%
%  ecgy:        the contamined signal
%  Fc:          cut-off frequency
%  Fs:          sample frequiency
%  ECG_Clean :  processed signal without BLW
%
%  Reference:
%  Blanco-Velasco M, Weng B, Barner KE. ECG signal denoising and baseline wander
%  correction based on the empirical mode decomposition. Comput Biol Med. 2008;38(1):1–13.
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com

% Import utilECG resources

EMD_sig = emd(sig);
EMD_sig=EMD_sig';

[N_imf, L] = size(EMD_sig);

for i = N_imf: -1: 1% N_imf - 8 % N_imf-9
    EMD_sig(i,:) = highPassFilter(EMD_sig(i,:), Fc, Fs);
end

Final_ecg = zeros(L,1);
for i = 1 : N_imf
    Final_ecg = Final_ecg + EMD_sig(i,:)';
end

ECG_Clean = Final_ecg;
end

function ecgy_filt = highPassFilter(ecgy, F, Fs)
%  High pass IIR filter
%
%  ecgy:        ECG signal
%  F:           Cut-off Frequency for the filter
%  Fs:          Sampling Frequency
%
%  ecgy_filt:     ECG signal contaminated with artificial
%               electric line noise
%
%  Reference:
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com

[b,a] = butter(4,F/Fs,'high');
ecgy_filt = filtfilt (b,a,ecgy); % bidirectional filteroing
end
