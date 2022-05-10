clear variables
close all
clc

%% Evaluation of diffrent methods for BW estimation ... T7 qives the number of cases that each method has best performance 
addpath(genpath('./'))
carpetaIn = 'LX';

dir_carpetaIn = dir(carpetaIn);
dir_carpetaIn([dir_carpetaIn.isdir]) = [];
% dir_carpetaIn(1:2) = [];

C = 1; % counter

for j=2:2:numel(dir_carpetaIn)
    name = dir_carpetaIn(j).name;
    %% read the signlas
    load(name);
    
    %% BW of signals by diffrent methods
    [Smad(C), Sprd(C), Sssd(C), Smse(C), Smae(C), Ssnr(C), Spsnr(C), Scc(C)] = My_Evaluation_BW(sig,name,BWS);
    C = C+1;
end

%% compare the methods
Tmad = My_compare_BW_methods(Smad);
Tprd = My_compare_BW_methods(Sprd);
Tssd = My_compare_BW_methods(Sssd);
Tmse = My_compare_BW_methods(Smse);
Tmae = My_compare_BW_methods(Smae);
Tsnr = My_compare_BW_methods_max(Ssnr);
Tpsnr = My_compare_BW_methods_max(Spsnr);
Tcc = My_compare_BW_methods_max(Scc);

T1 = join(Tmad,Tprd,'Keys' , 'Columns');
T2 = join(T1,Tssd,'Keys' , 'Columns');
T3 = join(T2,Tmse,'Keys' , 'Columns');
T4 = join(T3,Tmae,'Keys' , 'Columns');
T5 = join(T4,Tsnr,'Keys' , 'Columns');
T6 = join(T5,Tpsnr,'Keys' , 'Columns');
T7 = join(T6,Tcc,'Keys' , 'Columns');

T7.Properties.VariableNames = {'Columns','MAD', 'PRD','SSD','MSE','MAE','SNR', 'PSNR', 'CC'};

% writetable(T7,'table.csv')