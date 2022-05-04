function [a_out, b_out]=dl_kelo(varargin)
% DL_KELO   Mean of the diagonal line lengths and their distribution using KELO correction.
%    A=DL_KELO(X) computes the mean A of the length of the diagonal 
%    line structures in a recurrence plot X using the specific 
%    correction schema for border lines: KEep LOngest diagonal line (KELO).
%    In the KELO correction, only the longest border line (in each 
%    triangle) of the RP is counted. All other border lines are discarded.
%
%    [A B]=DL_KELO(X) computes the mean A and the lengths of the
%    found diagonal lines of the recurrence plot X, stored in B, using the 
%    KELO correction schema. In order to get the histogramme of the 
%    line lengths, simply call HIST(B,[1 MAX(B)]).
%
%    ...=DL_KELO(X,'semi') considers not only lines starting AND ending 
%    at a border of the RP, but also semi border lines, which are lines 
%    that start or end at a border of the RP but have the corresponding
%    ending or starting not at the border. The longest of these counts.
%
%    Examples: a = sin(linspace(0,5*2*pi,1050));
%              X = crp(a,2,50,.2,'nonorm','nogui');
%              [l l_dist1] = dl(X); % considering all border lines
%              [l l_dist2] = dl_kelo(X); % apply KELO correction for border lines
%              nexttile
%              hist(l_dist1,200)
%              title('considering all border lines')
%              nexttile
%              hist(l_dist2,200)
%              title('KELO correction')
%
%    See also CRQA, DL_ALL, DL_CENSI, TT.
%
%    References: 
%    Kraemer, K. H., Marwan, N.:
%    Border effect corrections for diagonal line based recurrence 
%    quantification analysis measures, Phys. Lett. A, 383, 2019.

% Copyright (c) 2019-
% K. Hauke Kraemer, Potsdam Institute for Climate Impact Research, Germany
% http://www.pik-potsdam.de
% Institute of Geosciences, University of Potsdam,
% Germany
% http://www.geo.uni-potsdam.de
% hkraemer@pik-potsdam.de, hkraemer@uni-potsdam.de
% Norbert Marwan, Potsdam Institute for Climate Impact Research, Germany
% http://www.pik-potsdam.de
%
% $Date: 2021/11/25 11:03:48 $
% $Revision: 4.2 $
%
% $Log: dl_kelo.m,v $
% Revision 4.2  2021/11/25 11:03:48  marwan
% correct dl_censi (neglect LOI)
%
% Revision 4.1  2021/11/23 12:05:30  marwan
% merging dl_censi and dl_kelo into the standard dl function
%
% Revision 4.0  2021/11/22 16:42:48  marwan
% add new functions for correcting line length distributions, based on KELO and CENSI schema
%
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or any later version.

X = logical(varargin{1});
styleLib={'normal','semi'}; % the possible borderline-style to look for
try
    type = varargin{2};
    if ~isa(type,'char') || ~ismember(type,styleLib)
        warning(['Specified RP type should be one of the following possible values:',...
           10,sprintf('''%s'' ',styleLib{:})])
    end
catch
    type = 'normal';
end

[Y,~] = size(X);
if issymmetric(X)
    [lines(1),borderlines(1)] = getLinesOnDiag(X,-Y+1,type); % init with first (scalar) diagonal
    for j=-Y+2:-1
        [ll,bl] = getLinesOnDiag(X,j,type);
        lines = horzcat(lines,ll);
        borderlines = horzcat(borderlines,bl);
    end
    % append lines for second triangle 
    lines = horzcat(lines,lines);
    % append longest border lines for second triangle (but exclude LOI)
    lines = horzcat(lines,max(borderlines),max(borderlines));
else
    [lines(1),borderlines(1)] = getLinesOnDiag(X,-Y+1,type); % init with first (scalar) diagonal
    for j=-Y+2:Y-1
        [ll,bl] = getLinesOnDiag(X,j,type);
        lines = horzcat(lines,ll);
        borderlines = horzcat(borderlines,bl);
    end
    borderlines = sort(borderlines,'ascend');
    % add longest borderlines to lines
    lines = horzcat(lines,borderlines(2:3));
end

% remove lines of length zero (=no line)
zero_lines = lines(:)==0;
lines(zero_lines) = []; 

b_out= sort(lines,'descend')';
a_out = mean(b_out);
end

function [lines, borderline] = getLinesOnDiag(M,j,type)
    d = diag(M,j);
    border_line_length = length(d);
    if ~any(d)
        lines = 0;
        borderline = 0;
        return
    end
    starts = find(diff([0; d],1)==1);
    ends = find(diff([d; 0],1)==-1);

    lines = zeros(1,numel(starts));
    borderline = zeros(1,numel(starts));
    
    if strcmp(type,'normal')
        for n=1:numel(starts)
            if ends(n) - starts(n) + 1 < border_line_length
                lines(n) = ends(n) - starts(n) +1;
            elseif ends(n) - starts(n) + 1 == border_line_length
                borderline = ends(n) - starts(n) +1;
            end
        end
    elseif strcmp(type,'semi')
        for n=1:numel(starts)
            if ends(n) ~= border_line_length && starts(n) ~=1               
                lines(n) = ends(n) - starts(n) +1;
            else
                borderline(n) = ends(n) - starts(n) +1;
            end
        end    
    end
    
end
