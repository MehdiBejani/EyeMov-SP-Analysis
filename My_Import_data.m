function [Lx, Ly, Rx, Ry, Target, filename, name, dir_carpetaIn] = My_Import_data(carpetaIn, j, k)
%read the dat files in the  carpetaIn directory
dir_carpetaIn = dir(carpetaIn);
dir_carpetaIn(~[dir_carpetaIn.isdir]) = [];
dir_carpetaIn(1:2) = [];


dirActual = dir(fullfile(dir_carpetaIn(j).folder, dir_carpetaIn(j).name));
dirActual(~[dirActual.isdir]) = [];
dirActual(1:2)  = [];

% Loop for each of the tasks (SP1, SP2, SP3....)
name = dirActual(k).name;
spActual = fullfile( dirActual(k).folder, name );

% Import LTS.dat
datosSt    = importdata( fullfile( spActual, 'LTS.dat' ) );
nElementsSt = size(datosSt,1);
% Import RTS.dat
datosStR    = importdata( fullfile( spActual, 'RTS.dat' ) );
nElementsStR = size(datosStR,1);

% Import Target data
try
    datosTgt = importdata( fullfile( spActual, 'target.dat' ) );
catch
    error(['CHECK MANUALLY: Error importing Target file: ',...
        fullfile( spActual, 'target.dat' )])
end
nElementsTgt = size(datosTgt,1);
%%
minnElements = min (nElementsSt, nElementsTgt);
minnElements = min (minnElements, nElementsStR);
datosTgt = datosTgt (1:minnElements,:);
datosSt = datosSt (1:minnElements,:);
datosStR = datosStR (1:minnElements,:);
%
filename = dir_carpetaIn(j).name;
disp(['Processing:    ', spActual])

Lx = datosSt(:,1);  % Left eye, x axis
Ly = datosSt(:,2);  % Left eye, y axis
Rx = datosStR(:,1); % Right eye, x axis
Ry = datosStR(:,2); % Right eye, y axis
%% mised values is filled with 'pchip' method (There are some NaN in the signals that maybe not recognized as blinks)
Lx = fillmissing(Lx,'pchip');
Ly = fillmissing(Ly,'pchip');
Rx = fillmissing(Rx,'pchip');
Ry = fillmissing(Ry,'pchip');
Target = datosTgt;
end

