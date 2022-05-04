
t=0:0.01:30;
input=sin(5*t)+2*cos(13*t);
plot(t,input)

CD = correlationDimension(input)
HFD = Higuchi_FD(input,13)
KFD = Katz_FD(input)
HE = genhurst(input)         
LZC = calc_lz_complexity(input,'exhaustive',1)
PFD = func_FE_PetrosianFD(input)
