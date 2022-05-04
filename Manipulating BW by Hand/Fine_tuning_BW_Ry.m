clear variables
close all
clc

carpetaIn = 'K:\extracted+corrected 07 07 2021 (1)\CORRECTED BLINKS+SACCADES';
[Lx, Ly, Rx, Ry, Target, filename, name, dir_carpetaIn] = My_Import_data(carpetaIn, Participant_number, SP_index);
% you can check the participants number in dir_carpetaIn 
% SP_index is based on this order (1,10,11,12,2,3,4,5,6,7,8,9)

sig= Ry;
Target= Target(:,2);

BW = movmean(sig,600); % Estimated BW by moving avrage
f = figure; f.WindowState = 'maximized';
plot(sig ,'b'); 
hold on
plot(BW,'g'); plot(Target, 'k');
BWM = BW;
grid on
grid minor

%% Edit the BW
[x,y] = ginput
pp = spline(x,y);
t=x(1):x(end);
yy = ppval(pp, t);
BW(x(1):x(end))= yy;
plot(t, yy, 'r')

%% Smoothing the BW and plot it
BWS = movmean(BW,50);
% BW (numel(sig)+1:end) = [];
plot_BWs(sig, Target, BWM, BW,BWS );

%% Edit the beginning and end of the smoothed BW (BWS)
[x,y] = ginput
pp = spline(x,y);
t=x(1):x(end);
yy = ppval(pp, t);
BWS(x(1):x(end))= yy;
plot(t, yy, 'r')

%% plot the final smoothed BW
plot_BWs(sig, Target, BWM, BW,BWS );
%% save the result
BW_name =  fullfile('.\Ry', [filename,'_',name]);
save(BW_name,'sig', 'Target', 'BWM','BW', 'BWS' )
saveas(gcf, BW_name,'meta'	)
