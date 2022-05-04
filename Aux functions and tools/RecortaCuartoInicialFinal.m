function [datosStRecortados,datosStRecortadosR, datosTgtRecortados, eventosRecortados,eventosRecortadosR,....
            datosStPrimerCuarto,datosStPrimerCuartoR, datosStUltimoCuarto, datosStUltimoCuartoR] = ...
            RecortaCuartoInicialFinal( datosSt,datosStR, datosTgt, eventos,eventosR, PeriodoTgt )
        
% Se corta el primer cuarto y el ultimo cuarto de los periodos de
% las señales, para centrarse en el computo de las regiones de interes
%     . .                     .            .  .
%   .     .                 .            .      .
%  .        .             .            .          .
% .           .          .      .....               .
%               .      .
%                 .  .
% |-----|*----------*----------*              |-----|
% Recorta   ROI         ROI                    Recorta
cuartoPeriodo = floor( PeriodoTgt/4 );

% Datos primer y ultimo cuarto
datosStPrimerCuarto = datosSt(1:cuartoPeriodo,:);
datosStUltimoCuarto = datosSt(end-cuartoPeriodo:end,:);

datosStPrimerCuartoR = datosStR(1:cuartoPeriodo,:);
datosStUltimoCuartoR = datosStR(end-cuartoPeriodo:end,:);

% Copia en nuevas variables
datosStRecortados   = datosSt;
datosStRecortadosR   = datosStR;
datosTgtRecortados  = datosTgt;

% Recortar obviando los datos del primer cuarto
datosStRecortados( 1:cuartoPeriodo,: )  = [];
datosStRecortadosR( 1:cuartoPeriodo,: )  = [];
datosTgtRecortados( 1:cuartoPeriodo,: ) = [];

% Recortar obviando los datos del primer cuarto
datosStRecortados( end-cuartoPeriodo:end,: )  = [];
datosStRecortadosR( end-cuartoPeriodo:end,: )  = [];
datosTgtRecortados( end-cuartoPeriodo:end,: )  = [];

% Recortar los eventos quitando los datos del primer y ultimo cuarto
finalSerie = size( datosTgt, 1 );
eventosRecortados        = eventos(eventos(:,2)>=cuartoPeriodo & eventos(:,1)<=finalSerie-cuartoPeriodo,:);
eventosRecortados(:,1:2) = eventosRecortados(:,1:2)-cuartoPeriodo+1;

if(eventosRecortados(1,1)<0)
    eventosRecortados(1,1) = 1;
end
valMax = finalSerie-2*cuartoPeriodo-1;
if eventosRecortados(end,2)>valMax
    eventosRecortados(end,2) = valMax;
end

eventosRecortadosR        = eventosR(eventosR(:,2)>=cuartoPeriodo & eventosR(:,1)<=finalSerie-cuartoPeriodo,:);
eventosRecortadosR(:,1:2) = eventosRecortadosR(:,1:2)-cuartoPeriodo+1;

if(eventosRecortadosR(1,1)<0)
    eventosRecortadosR(1,1) = 1;
end
valMax = finalSerie-2*cuartoPeriodo-1;
if eventosRecortadosR(end,2)>valMax
    eventosRecortadosR(end,2) = valMax;
end