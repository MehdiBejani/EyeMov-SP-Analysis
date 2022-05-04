function cleansig = BW_removing(sig,method,Fs, Fc)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
tm = (0:length(sig)-1)/Fs;
switch method
    case 'EMD'
        cleansig = EMDRemoveBL(sig,Fs, Fc);
    case 'VMD'
        [imf,~] = vmd(sig,'NumIMF',11); % VMD, 11 is the number of IMF
        cleansig = sum(imf(:,1:10),2);
    case 'FDM'
        cleansig_FDM = sp_DFTOrthogonalOrFIR_IIR_LINOEP(sig,tm ,Fs, Fc ,'dft');
        cleansig = cleansig_FDM {1, 1};
    case 'EWT'
        [mra,~] = ewt(sig,'MaxNumPeaks',6);
        cleansig = sum(mra(:,1:4),2);
    case 'EMD2'
        [imf,~] = emd(sig);
        [~,N]=size(imf);
        cleansig = sum(imf(:,1:N-4),2);
    case 'MAF'
        BW = movmean(sig,600);
        cleansig = sig - BW;
    case 'IIR'
        cleansig = IIR_b_RemoveBL(sig,Fs,Fc);
        
end
end

