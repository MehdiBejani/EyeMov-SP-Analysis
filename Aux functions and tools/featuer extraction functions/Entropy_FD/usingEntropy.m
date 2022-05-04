
t=0:0.01:30;
input=sin(5*t)+2*cos(13*t);
plot(t,input)

n=4; alpha=0.2; Fs=100;

SEn = func_FE_ShannEn(input,n)
REn = func_FE_RenyiEn(input,n,alpha)
ApEn = approximateEntropy(input)
SaEn = sampen(input,2,0.2,'euclidean')
PEn = pec(input,2,1)
FEn = func_FE_FuzzEn(input,2,0.2)       
for tau=1:40
        [e,A,B] = multiscaleSampleEntropy(input,2,0.2,tau);
        F(tau)=e;
end
MSaEn=sum(F)
SpectEn = pentropy(input,Fs,'Instantaneous',false)
