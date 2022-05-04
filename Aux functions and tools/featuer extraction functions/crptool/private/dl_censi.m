function [a_out, b_out]=dl_censi(varargin)
% DL_CENSI   Mean of the diagonal line lengths and their distribution using Censi correction.
%    A=DL_CENSI(X) computes the mean A of the length of the diagonal 
%    line structures in a recurrence plot X using the specific 
%    correction schema for border lines proposed by Censi et al. 2004,
%    in which the length of the longest border line is used for all
%    border lines.
%
%    [A B]=DL_CENSI(X) computes the mean A and the lengths of the
%    found diagonal lines of the recurrence plot X, stored in B, using the 
%    Censi correction schema. In order to get the histogramme of the 
%    line lengths, simply call HIST(B,[1 MAX(B)]).
%
%    ...=DL_CENSI(X,'semi') considers not only lines starting AND ending 
%    at a border of the RP, but also semi border lines, which are lines 
%    that start or end at a border of the RP but have the corresponding
%    ending or starting not at the border. The longest of these counts.
%
%    Remark: In Censi et al. 2004, the length of the LOI was considered
%    to be the longest borderline. Here we use a modification by 
%    excluding the LOI from the set of borderlines. This usually results
%    in a shorter length of the border lines than in the original
%    Censi approach. But this would allow us to use this correction
%    schema also for non-cyclical signals without strange effects.
%
%    Examples: a = sin(linspace(0,5*2*pi,1050));
%              X = crp(a,2,50,.2,'nonorm','nogui');
%              [l l_dist1] = dl(X); % considering all border lines
%              [l l_dist2] = dl_censi(X); % apply Censi correction for border lines
%              nexttile
%              hist(l_dist1,200)
%              title('considering all border lines')
%              nexttile
%              hist(l_dist2,200)
%              title('Censi correction')
%
%    See also CRQA, DL_ALL, DL_CENSI, TT.
%
%    References: 
%    Censi, F., et al.:
%    Proposed corrections for the quantification of coupling patterns by 
%    recurrence plots, IEEE Trans. Biomed. Eng., 51, 2004.
%
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
% $Log: dl_censi.m,v $
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
    % append lines for second triangle and LOI   
    [~,bl] = getLinesOnDiag(X,0,type);
    lines = horzcat(lines,lines,bl);
    borderlines = horzcat(borderlines,borderlines);
    % remove lines of length zero (=no line)
    zero_lines = borderlines(:)==0;
    borderlines(zero_lines) = [];
    % set all borderlines to the LOI
    borderlines(:)=max(borderlines);
    % append borderlines (but exclude LOI)
    lines = horzcat(lines,borderlines);
else
    [lines(1),borderlines(1)] = getLinesOnDiag(X,-Y+1,type); % init with first (scalar) diagonal
    for j=-Y+2:Y-1
        [ll,bl] = getLinesOnDiag(X,j,type);
        lines = horzcat(lines,ll);
        borderlines = horzcat(borderlines,bl);
    end    
    % remove lines of length zero (=no line)
    zero_lines = borderlines(:)==0;
    borderlines(zero_lines) = [];
    % set all borderlines to the longest one 
    borderlines(:)=max(borderlines);
    % add borderlines to lines
    lines = horzcat(lines,borderlines);
end

% remove lines of length zero (=no line)
zero_lines = lines(:)==0;
lines(zero_lines) = []; 

b_out= sort(lines,'ascend')';
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
