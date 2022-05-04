function structure = ExtractFeatuers (sig,filename,name)
%this function extract diffent featuers
structure.name = filename;
structure.SP = name;
%% estimating the embading dimantion and lag

[~,eLag,eDim] = phaseSpaceReconstruction(sig);
Fs=1000;
% structuraLx.XR = XR;
structure.Lag = eLag;
structure.Dim = eDim;
%% time domain featurs
mu= mean(sig);
v= var(sig);
ske= skewness(sig);
kr= kurtosis(sig);
P= mean(sig.^2);

structure.mu = mu;
structure.var = v;
structure.ske = ske;
structure.kr = kr;
structure.P = P;
%% DFA
[~,Alpha]=DFA_main(sig);
structure.DFA = Alpha;
 %% RQA featuers
% % Y= crqa (sig,eDim, eLag);
% % structure.RQA1 = Y(1);
% % structure.RQA2 = Y(2);
% % structure.RQA3 = Y(3);
% % structure.RQA4 = Y(4);
% % structure.RQA5 = Y(5);
% % structure.RQA6 = Y(6);
% % structure.RQA7 = Y(7);
% % structure.RQA8 = Y(8);
% % structure.RQA9 = Y(9);
% % structure.RQA10 = Y(10);
% % structure.RQA11 = Y(11);
% % structure.RQA12 = Y(12);
% % structure.RQA13 = Y(13);
%% fractal
CD = correlationDimension(sig,eLag,eDim);
HFD = Higuchi_FD(sig,13);
KFD = Katz_FD(sig);
HE = genhurst(sig);
LZC = calc_lz_complexity(sig,'exhaustive',1);
PED = func_FE_PetrosianFD(sig);

structure.CD=CD;
structure.HFD=HFD;
structure.KFD=KFD;
structure.HE=HE;
structure.LZC=LZC;
structure.PED=PED;
%% Entropy
EnShann = func_FE_ShannEn(sig,4);
EnShann2= wentropy(sig,'shannon');
EnReny = func_FE_RenyiEn(sig,4,0.2);
% ENApp = approximateEntropy(sig,eLag,eDim);
EnSamp = sampen(downsample(sig,2),eDim,0.2,'euclidean');
EnPe = pec(sig,2,1);
ENFuzzy = func_FE_FuzzEn(downsample(sig,2),eDim,0.2);
EnSpect = pentropy(sig,Fs,'Instantaneous',false);

for tau=1:40
    [e,A,B] = multiscaleSampleEntropy(downsample(sig,2),2,0.2,tau);
    F(tau)=e;
end
EnMS=sum(F);
% EnMS=max(F);
structure.EnShann=EnShann;
structure.EnShann=EnShann2;
structure.EnReny=EnReny;
% structure.ENApp=ENApp;
structure.EnSamp=EnSamp;
structure.EnPe=EnPe;
structure.ENFuzzy=ENFuzzy;
structure.EnSpect=EnSpect;
structure.EnMS=EnMS;

%% lyapunov exponent
lyapE = lyapunovExponent(sig,Fs,eLag,eDim);
% lyapE = lyapunovExponent(sig,Fs);
structure.lyapE=lyapE;
[mobility,complexity] = HjorthParameters(sig);
%% Hjorth Mobility : mean signal frequency
structure.HjMobi= mobility;
% Hjorth Complexity: rate of change in mean signal frequency
structure.HjComp= complexity;

[mEntropy] = CalculateEntropy( sig,eLag,eDim );
structure.rApEn   = mEntropy (1,1);
structure.rSampEn = mEntropy (1,2);
structure.rmSampEn= mEntropy (1,3);
structure.rGSampEn= mEntropy (1,4);
structure.rFuzzyEn= mEntropy (1,5);
% structure.rApEn2   = mEntropy (2,1);
% structure.rSampEn2 = mEntropy (2,2);
% structure.rmSampEn2= mEntropy (2,3);
% structure.rGSampEn2= mEntropy (2,4);
% structure.rFuzzyEn2= mEntropy (2,5);
%
% structure.rApEn3  = mEntropy (3,1);
% structure.rSampEn3 = mEntropy (3,2);
% structure.rmSampEn3= mEntropy (3,3);
% structure.rGSampEn3= mEntropy (3,4);
% structure.rFuzzyEn3= mEntropy (3,5);

%% featuers by omidvarnia

[ApEn_h,SampEn_h,RangeEn_A_h,RangeEn_B_h] = RengeEntropy_omidvarnia(sig,eDim);
structure.ApEn_h  = ApEn_h;
structure.SampEn_h  = SampEn_h;
structure.RangeEn_A_h  = RangeEn_A_h;
structure.RangeEn_B_h  = RangeEn_B_h;

end

