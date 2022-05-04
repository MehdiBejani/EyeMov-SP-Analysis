function y=normalize(x)
%NORMALIZE   Normalizes data series.
%   Y=NORMALIZE(X) normalizes the matrix X to zero-mean and
%   standard deviation one (Y=(X-mean(X))/std(X)).

% Copyright (c) 2008-
% Norbert Marwan, Potsdam Institute for Climate Impact Research, Germany
% http://www.pik-potsdam.de
%
% Copyright (c) 1998-2008
% Norbert Marwan, Potsdam University, Germany
% http://www.agnld.uni-potsdam.de
%
% $Date: 2017/09/18 20:10:58 $
% $Revision: 2.4 $
%
% $Log: normalize.m,v $
% Revision 2.4  2017/09/18 20:10:58  marwan
% added fix for NaNs
%
% Revision 2.3  2016/03/03 14:57:40  marwan
% updated input/output check (because Mathworks is removing downwards compatibility)
% bug in crqad_big fixed (calculation of xcf).
%
% Revision 2.2  2009/03/24 08:32:57  marwan
% copyright address changed
%
% Revision 2.1  2004/11/10 07:07:51  marwan
% initial import
%
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or any later version.


narginchk(1,1)
nargoutchk(0,1)
if min(size(x))==1
    y=(x-nanmean(x))/nanstd(x);
else

  for i=1:size(x,2);
    y(:,i)=(x(:,i)-nanmean(x(:,i)))/nanstd(x(:,i));
  end

end
