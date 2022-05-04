
function [mEntropy] = CalculateEntropy( vSignal,eLag,eDim )

% Normalization
vSignal     = vSignal-mean( vSignal );
vNormSignal = ( vSignal - min( vSignal ) ) ./ ( max( vSignal )+abs( min( vSignal ) ) + 0.001 );
vSignal=vNormSignal;
%% Reconstruction
tau =  eLag;
dim = eDim;

% dim = m + 1
mAttractorEntropyp1 = embeb( vSignal, dim+1, tau );
% dim = m
mAttractorEntropy   = embeb( vSignal, dim, tau );

% iAlpha = [0.1:0.05:0.2];
iAlpha = 0.2;
rParam = std( vSignal )*iAlpha;

mEntropy = zeros( numel(iAlpha), 5 );
for j=1:numel( iAlpha )
    [rApEn,rSampEn,rmSampEn,rGSampEn,rFuzzyEn] =...
        CalculateRegularity( mAttractorEntropyp1, mAttractorEntropy, rParam(j), 'chebychev', true );
    
    mEntropy(j,:) = [rApEn,rSampEn,rmSampEn,rGSampEn,rFuzzyEn];
end

% PE = permutation_entropy_mod( mAttractorEntropy' );
% SH = wentropy( vSignal, 'shannon' );

end