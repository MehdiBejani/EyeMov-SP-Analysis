function [ApEn_h,SampEn_h,RangeEn_A_h,RangeEn_B_h] = RengeEntropy_omidvarnia(x,m)
%UNTITLED10 Summary of this function goes here
r_span =  0 : 0.01 : 1;  % A span of tolerance parameter r for entropy measures with fixed signal length (N)
%% Initialize output matrices
N_r = length(r_span);           % Number of tolerance values

%%% Extract entropy measures
parfor n_r = 2: N_r
    r = r_span(n_r);
    sd_sig = std(x);
    r = r * sd_sig;
    
    ApEn_h(n_r) = ApEn_fast(x, m, r);
    SampEn_h(n_r) = SampEn_fast(x, m, r);
    RangeEn_A_h(n_r) = RangeEn_A(x, m, r);
    RangeEn_B_h(n_r) = RangeEn_B(x, m, r);
end
ApEn_h = sum (ApEn_h);
SampEn_h = sum (SampEn_h);
RangeEn_A_h = sum (RangeEn_A_h);
RangeEn_B_h = sum (RangeEn_B_h);

end

