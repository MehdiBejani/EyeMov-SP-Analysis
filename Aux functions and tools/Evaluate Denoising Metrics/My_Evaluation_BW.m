function [Smad, Sprd, Sssd, Smse, Smae, Ssnr, Spsnr, Scc] = My_Evaluation_BW(sig,name,BWS)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Fs = 1000; Fc = 0.1;
BW_EMD = sig - BW_removing(sig,'EMD',Fs, Fc);
BW_VMD = sig - BW_removing(sig,'VMD',Fs, Fc);
BW_FDM = sig - BW_removing(sig,'FDM',Fs, Fc);
BW_EWT = sig - BW_removing(sig,'EWT',Fs, Fc);
BW_EMD2 = sig - BW_removing(sig,'EMD2',Fs, Fc);
BW_MAF = sig - BW_removing(sig,'MAF',Fs, Fc);
BW_IIR = sig - BW_removing(sig,'IIR',Fs, Fc);
% MAD
Smad.name = name;
Smad.EMD = MAD(BW_EMD, BWS);
Smad.VMD = MAD(BW_VMD, BWS);
Smad.FDM = MAD(BW_FDM, BWS);
Smad.EWT = MAD(BW_EWT, BWS);
Smad.EMD2 = MAD(BW_EMD2, BWS);
Smad.MAF = MAD(BW_MAF, BWS);
Smad.IIR = MAD(BW_IIR, BWS);
% PRD
Sprd.name = name;
Sprd.EMD = PRD(BW_EMD, BWS);
Sprd.VMD = PRD(BW_VMD, BWS);
Sprd.FDM = PRD(BW_FDM, BWS);
Sprd.EWT = PRD(BW_EWT, BWS);
Sprd.EMD2 = PRD(BW_EMD2, BWS);
Sprd.MAF = PRD(BW_MAF, BWS);
Sprd.IIR = PRD(BW_IIR, BWS);

%  SSD
Sssd.name = name;
Sssd.EMD = SSD(BW_EMD, BWS);
Sssd.VMD = SSD(BW_VMD, BWS);
Sssd.FDM = SSD(BW_FDM, BWS);
Sssd.EWT = SSD(BW_EWT, BWS);
Sssd.EMD2 = SSD(BW_EMD2, BWS);
Sssd.MAF = SSD(BW_MAF, BWS);
Sssd.IIR = SSD(BW_IIR, BWS);

% MSE (Mean squared error), MAE(Mean absolute error), SNR (signal to noise ratio)
% PSNR (peak signal to noise ratio), cross_core (Cross correlation)
Smse.name = name; Smae.name = name; Ssnr.name = name; Spsnr.name = name; Scc.name = name; 
[Smse.EMD, Smae.EMD, Ssnr.EMD, Spsnr.EMD, Scc.EMD] = evaluate_denoising_metrics(BW_EMD, BWS);
[Smse.VMD, Smae.VMD, Ssnr.VMD, Spsnr.VMD, Scc.VMD] = evaluate_denoising_metrics(BW_VMD, BWS);
[Smse.FDM, Smae.FDM, Ssnr.FDM, Spsnr.FDM, Scc.FDM] = evaluate_denoising_metrics(BW_FDM, BWS);
[Smse.EWT, Smae.EWT, Ssnr.EWT, Spsnr.EWT, Scc.EWT] = evaluate_denoising_metrics(BW_EWT, BWS);
[Smse.EMD2, Smae.EMD2, Ssnr.EMD2, Spsnr.EMD2, Scc.EMD2] = evaluate_denoising_metrics(BW_EMD2, BWS);
[Smse.MAF, Smae.MAF, Ssnr.MAF, Spsnr.MAF, Scc.MAF] = evaluate_denoising_metrics(BW_MAF, BWS);
[Smse.IIR, Smae.IIR, Ssnr.IIR, Spsnr.IIR, Scc.IIR] = evaluate_denoising_metrics(BW_IIR, BWS);
end

