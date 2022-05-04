clear variables
close all
clc

addpath(genpath('./'))
carpetaIn = './CORRECTED BLINKS+SACCADES';

dir_carpetaIn = dir(carpetaIn);
dir_carpetaIn(~[dir_carpetaIn.isdir]) = [];
dir_carpetaIn(1:2) = [];

counter = 1;

for j=1:numel(dir_carpetaIn)
    % Loop patients
    dirActual = dir(fullfile(dir_carpetaIn(j).folder, dir_carpetaIn(j).name));
    dirActual(~[dirActual.isdir]) = [];
    dirActual(1:2)  = [];
    
    for k=1:numel(dirActual)
        % Loop for each of the tasks (SP1, SP2, SP3....)
        name = dirActual(k).name;
        spActual = fullfile( dirActual(k).folder, name );
        
        % Import LEvent.dat
        eventos = importdata( fullfile( spActual, 'LEvent.dat' ) );
        % Import LTS.dat
        datosSt    = importdata( fullfile( spActual, 'LTS.dat' ) );
        nElementsSt = size(datosSt,1);
        
        % Import LREvent.dat
        eventosR = importdata( fullfile( spActual, 'REvent.dat' ) );
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
        switch name
            case 'SmoothPur_1'
                PeriodoTgtX = 5000;
                PeriodoTgtY = 0;
            case 'SmoothPur_2'
                PeriodoTgtX = 5000;
                PeriodoTgtY = 0;
            case 'SmoothPur_3'
                PeriodoTgtX = 2500;
                PeriodoTgtY = 0;
            case 'SmoothPur_4'
                PeriodoTgtX = 2500;
                PeriodoTgtY = 0;
            case 'SmoothPur_5'
                PeriodoTgtX = 0;
                PeriodoTgtY = 5000;
            case 'SmoothPur_6'
                PeriodoTgtX = 0;
                PeriodoTgtY = 5000;
            case 'SmoothPur_7'
                PeriodoTgtX = 0;
                PeriodoTgtY = 2500;
            case 'SmoothPur_8'
                PeriodoTgtX = 0;
                PeriodoTgtY = 2500;
            case 'SmoothPur_9'
                PeriodoTgtX = 5000;
                PeriodoTgtY = 2500;
            case 'SmoothPur_10'
                PeriodoTgtX = 5000;
                PeriodoTgtY = 2500;
            case 'SmoothPur_11'
                PeriodoTgtX = 2500;
                PeriodoTgtY = 5000;
            case 'SmoothPur_12'
                PeriodoTgtX = 2500;
                PeriodoTgtY = 5000;
        end
        
        % The division will be made with respect to the smallest period of the coordinates
        % (it does not make sense to make a different division with the periods of each of the coordinates)
        maxVal = max( [PeriodoTgtX, PeriodoTgtY] );
        minVal = min( [PeriodoTgtX, PeriodoTgtY] );
        
        % % This is done to prevent the minimum period from being 0
        if(minVal==0)
            PeriodoTgt = maxVal;
        else
            PeriodoTgt = minVal;
        end
        
        disp(['Processing:    ', spActual])
        
        % Preprocess to remove the first and last quarter (see inside the function the graph of what is done)
        [datosSt,datosStR, datosTgt, eventos,eventosR,....
            datosStPrimerCuarto,datosStPrimerCuartoR, datosStUltimoCuarto, datosStUltimoCuartoR] = ...
            RecortaCuartoInicialFinal( datosSt,datosStR, datosTgt, eventos,eventosR, PeriodoTgt );
        
        filename = dir_carpetaIn(j).name;
        
        %% extracting the data
        Lx = datosSt(:,1);  % Left eye, x axis
        Ly = datosSt(:,2);  % Left eye, y axis
        Rx = datosStR(:,1); % Right eye, x axis
        Ry = datosStR(:,2); % Right eye, y axis
        %% mised values is filled with 'pchip' method (There are some NaN in the signals that maybe not recognized as blinks)
        Lx = fillmissing(Lx,'pchip');
        Ly = fillmissing(Ly,'pchip');
        Rx = fillmissing(Rx,'pchip');
        Ry = fillmissing(Ry,'pchip');
        %% BW removing
        Fc= 0.3; Fs = 1000; method = 'VMD';
        cleansigLx = BW_removing(Lx,method,Fs, Fc);
        cleansigLy = BW_removing(Ly,method,Fs, Fc);
        cleansigRx = BW_removing(Rx,method,Fs, Fc);
        cleansigRy = BW_removing(Ry,method,Fs, Fc);
        
        %% Figure Properties
        if p == 1 % if p =1 plot the signals with events and save them in jpg or emf formats
            f = figure;
            f.WindowState = 'maximized';
            f.Position = get( 0, 'ScreenSize' );
            %         f.Visible     = 'off';
            
            subplot (3,2,1);
            BW = Lx - cleansigLx;
            PlotDataConTgt( Lx, BW, eventos, min(min(Lx),min(BW)), max(max(Lx),max(BW)), 0 ) % plot the signals with evets
            legend('signal', 'BW')
            title('BW for Left eye and x axis');
            
            subplot (3,2,2)
            BW = Ly - cleansigLy;
            PlotDataConTgt( Ly, BW, eventos, min(min(Ly),min(BW)), max(max(Ly),max(BW)), 0 )
            legend('signal', 'BW')
            title('BW for Left eye and y axis');
            
            subplot (3,2,3);
            BW = Rx - cleansigRx;
            PlotDataConTgt( Rx, BW, eventos, min(min(Rx),min(BW)), max(max(Rx),max(BW)), 0 )
            legend('signal', 'BW')
            title('BW for Right eye and x axis');
            
            subplot (3,2,4)
            BW = Ry - cleansigRy;
            PlotDataConTgt( Ry, BW, eventos, min(min(Ry),min(BW)), max(max(Ry),max(BW)), 0 )
            legend('signal', 'BW')
            title('BW for Right eye and y axis');
            
            subplot (3,2,5)
            plot (cleansigLx)
            hold on
            plot (cleansigRx)
            title('cleaned signal for x (Left:blue Right:red)');
            legend('Left', 'Right');
            
            subplot (3,2,6)
            plot (cleansigLy)
            hold on
            plot (cleansigRy)
            title('cleaned signal for y (Left:blue Right:red)');
            legend('Left', 'Right');
            
            saveas(f, fullfile('./JPG', [filename,'_',name]),'jpeg'	)
            saveas(f, fullfile('./EMF', [filename,'_',name]),'meta' )
            close(f);
        end
        %% Extracting diffrent featuers of the signals
        structureLx(counter) = ExtractFeatuers (cleansigLx,filename,name);
        structureLy(counter) = ExtractFeatuers (cleansigLy,filename,name);
        structureRx(counter) = ExtractFeatuers (cleansigRx,filename,name);
        structureRy(counter) = ExtractFeatuers (cleansigRy,filename,name);
        
        counter = counter+1;
    end
    
end

%% save the extraced featuers in CSV files

tablaLX = struct2table(structureLx(:));
writetable(tablaLX,'./tablaLX.csv')

tablaLy = struct2table(structureLy(:));
writetable(tablaLy,'./tablaLy.csv')

tablaRX = struct2table(structureRx(:));
writetable(tablaRX,'./tablaRX.csv')

tablaRY = struct2table(structureRy(:));
writetable(tablaRY,'./tablaRY.csv')

