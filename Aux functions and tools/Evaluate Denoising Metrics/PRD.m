function [prd] = PRD(sig1, sig2)
%  Percentage Root-Mean-Square Difference (PRD) Metric
%
%  ECG1:        This is the Groun truth signal
%  ECG2:        This is the Processed signal to be compared with
%               the Groun truth signal
%  prd:         The output value of MAD metric
%
%  Reference:
%  R. Nygaard, G. Melnikov, A.K. Katsaggelos, A rate distortion optimal ECG coding
%  algorithm,%  IEEE Trans. Biomed. Eng. 48 (2001) 28–40. doi:10.1109/10.900246.
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com

    if (size(sig1) == size(sig2))

        dECG1 = sig1;
        dECG2 = sig2;

        % Measure implementation
        meandECG1 = mean(dECG1);
        numerator = sum((dECG1 - dECG2).^2);
        denominator = sum((dECG1 - meandECG1).^2);
        prd = sqrt(numerator/denominator) * 100;

    else
        disp('The signals have diferent size')
    end

end


function [mad,xmax, ymax, xmin, ymin] = MAD_XY(ECG1, ECG2)
% Maximum Absolute Distance Metric
%
%  ECG1:        This is the Groun truth signal
%  ECG2:        This is the Processed signal to be compared with
%               the Groun truth signal
%  mad:         The output value of MAD metric
%
%  Reference:
%  R. Nygaard, G. Melnikov, A.K. Katsaggelos, A rate distortion optimal ECG coding
%  algorithm,%  IEEE Trans. Biomed. Eng. 48 (2001) 28–40. doi:10.1109/10.900246.
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com
%  This version also return the position off maximum and minimum

    if (size(ECG1) == size(ECG2))
        % We are interest in the shape of signals, then we have to
        % eliminate the bias due to DC components runnin metrics on
        % the derivate of the signals

        %dECG1 = diff(ECG1);
        %dECG2 = diff(ECG2);

        dECG1 = ECG1;
        dECG2 = ECG2;

        % Measure implementation
        ds = abs(dECG1 - dECG2);
        mad = max(ds);

        % Find the point of maximum and minimum of the metric
        indexmin = find(min(ds) == ds);
        xmin = indexmin;
        ymin = ds(indexmin);

        indexmax = find(max(ds) == ds);
        xmax = indexmax;
        ymax = ds(indexmax);

    else
        disp('The signals have diferent size')
    end

end