This function computes the Sample Entropy (SampEn) algorithm according to the Richman, J. S., & Moorman, J. R. (2000) recommendations. The script is bearable, compressed and vectorized. Therefore, the computation cost is minimal.

Furthermore, extraordinary cases when SampEn is not defined are considered:
- If B = 0, no regularity has been detected. A common SampEn implementation would return -Inf value.
- If A = 0, the conditional probability is zero (A/B = 0), returning an Inf value.

According to Richman & Moorman, the upper bound of SampEn must be A/B = 2/[(N-m-1)(N-m)], returning SampEn = log(N-m)+log(N-m-1)-log(2). Hence, whenever A or B are equal to 0, that is the correct value.

Input parameters:
- signal: Signal vector with dims. [1xN]
- m: Embedding dimension (m < N).
- r: Tolerance (percentage applied to the SD).
- dist_type: (Optional) Distance type, specified by a string. Default value: 'chebychev' (type help pdist for further information).

Output variables:
- value: SampEn value.

Example of use:
signal = rand(200,1);
value = sampen(signal,1,0.2)

Cite As
Víctor Martínez-Cagigal (2018). Sample Entropy. Mathworks.