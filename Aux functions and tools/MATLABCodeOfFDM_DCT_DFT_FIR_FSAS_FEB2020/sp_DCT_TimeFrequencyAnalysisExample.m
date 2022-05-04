
if 1 % DCT based FDM
        close all; 
        clear all;    
        clc;
        Fs=1000;
        Fmax=Fs/2; 
        Npart=20;
        Fmax=150;
        
        % 1. for clean signal with complete number of cycles, HT is better
        % than DCT.
        % 2. for noisy signal with complete number of cycles, both HT and DCT are same.
        
        % 3. for clean and noisy signals with incomplete number of cycles, DCT is better
        % than HT.
        
        % 4. for short, clean and noisy signals with incomplete number of cycles, DCT is much better
        % than HT.
        
        
        t = 0:(1/Fs):1-(1/Fs);
        t=t';
        
        x=chirp(t,5,1,100); 
        if 0
            x=0;
            for i=1:5
                x=x+cos(2*pi*i*1*t);
            end
        end
        
        %x=sin(2*pi*2*t+pi/7);
        plot(x)
        snr=40;
        N=length(x);
        %x=awgn(x,snr,'measured');
        plot(x);
        subplot(2,1,1)
        freq0=(0:N-1)*Fs/N;
        plot(freq0,abs(fft(x)));        
        DCT2=1;
        if DCT2 % dct 
            y=dct(x);    
            %y=dct(x,'Type',2); 
        else % dst
            y=dst(x);    
        end
        
        if 0 % idc implementation
           ydct = sp_DCTImpl(x);           
           x_rec = sp_IDCTImpl(ydct);
           subplot(2,1,1)
           plot(x-x_rec);           
           subplot(2,1,2)
           plot(y-ydct); 
           
           % DCT using 2N FFT
           fx2 = fft(x, 2*N);
           ak=(1/sqrt(N)) * [1; sqrt(2)*ones(N-1,1)];
           dctx = ak .*real( fx2(1:N) .* exp(-1i*pi*(0:N-1)'/(2*N)) );
           plot(y-dctx);           
           
           % IDCT using 4N FFT
           ck=ak.*dctx;
           x4N=fft(ck,4*N);
           
           subplot(2,1,1)           
           plot(real(x4N));
           subplot(2,1,2)           
           plot(-imag(x4N));
           
           xrec1=x4N(2:2:(2*N));% FSAS          
           xr=real(xrec1);   % signal x         
           xq=-imag(xrec1);  % quadrature component 
           
           
           
           subplot(2,1,1)           
           plot(t,xr); 
           %axis([t(1) t(end) min(xr) max(xr)]);
           subplot(2,1,2)
           plot(t,xq);
           %axis([t(1) t(end) min(xq) max(xq)]);
           
           tt=1;        
        end
        
        subplot(2,1,2)
        freq=(0:N-1)*0.5*Fs/N;
        plot(freq,abs(y));
        tt=1;  
        
       if 0 
            IntNtime=0;
            x1=x;
            for i=1:IntNtime
                x1=(cumsum(x1));
            end
            plot(x1);
            y1=dct(x1);

            subplot(2,1,1);
            freq=(0:N-1)*0.5*Fs/N;
            plot(freq',abs(y))

            subplot(2,1,2);
            stem(freq',abs(y1))

            figure 

            %y1(100:end)=0; 
            xr=idct(y1);
            xt=xr(1);
            for i=1:IntNtime            
                xr=diff(xr);
                xr=[xt;xr];            
            end
            plot(xr); 


           tt=1;
       end
        if 0
            ym=abs(y); ymax=max(ym);
            ind=find(ym<ymax*0.1);
            y(ind)=0; stem(y)
        end
        
        if 0 % filtering
            ym=abs(y); [ymax ind]=max(ym); 
            nbr=3;
            y(ind+nbr:end)=0; 
            y(1:ind-nbr)=0; 
            subplot(2,1,2);
            stem(y)
        end
        
        if 1
            Fcut1=40; Fcut2=60;  % Hz
            %sx=sp_DCT2_Filter(x,Fs,Fcut1,'LP');
            sx=sp_DCT2_Filter(x,Fs,Fcut1,Fcut2,'BP');
            subplot(2,1,1);
            plot(real(sx));
            subplot(2,1,2);
            plot(x-real(sx'));
            
            tt=1;
            
            subplot(2,1,1);
            plot(real(sx));
            subplot(2,1,2);
            plot(imag(sx));
            tt=1;   
        end 
        
        [freq amp]=sp_IF_timefrequency_plot(x,t,Fs,Fmax); 
        [freq1 amp1]=sp_DCT_IF_timefrequency_plot(x,t,Fs,Fmax);  
        
        %%%%%%%%%%%% DCT based Analytic signal cmputation
        z=0;        
        N=length(x);  
        n=1:N;
        if DCT2
            w=ones(1,N)*(2/N)^(0.5); w(1)= (1/N)^(0.5); 
        else
           w=ones(1,N)*(2/(N+1)); 
        end
        
        for k=1:N
            if DCT2
                tmp=w(k)*y(k)*exp( 1i*pi*(2*n-1)*(k-1)/(2*N) ); % DCT-2 and DCT-3 are inverses of each other.
            else
               tmp=w(k)*y(k)*exp( 1i*pi*n*k/(N+1) ); 
            end
            z= z+tmp; 

            if 0
                subplot(2,1,1);
                plot(real(tmp));
                grid on
                subplot(2,1,2);
                plot(imag(tmp)); 
                grid on
            end
        tt=1;
        end
        
        figure;
        subplot(2,1,1);
        plot(x'-real(z));
        subplot(2,1,2);
        plot(x-idct(y));
        tt=1;
        
        if 1
                figure
                subplot(3,1,1);
                plot(t,real(z));
                grid on
                if DCT2
                    title('Real part of DCT based FSAS');
                else
                    title('Real part of DST based FSAS');
                end
             FntSize=18;
             set(gca,'FontSize',FntSize,'FontName','Times')
             h1 = get(gca, 'xlabel');
             set(h1,'FontSize',FntSize,'FontName','Times')
             h1 = get(gca, 'ylabel');
             set(h1,'FontSize',FntSize,'FontName','Times')
             set(gca,'xticklabel',{[]}) 
                subplot(3,1,2);
                plot(t,imag(z)); 
                grid on
                if DCT2
                    title('Imaginary part of DCT based FSAS');
                else
                    title('Imaginary part of DST based FSAS');
                end
                FntSize=18;
             set(gca,'FontSize',FntSize,'FontName','Times')
             h1 = get(gca, 'xlabel');
             set(h1,'FontSize',FntSize,'FontName','Times')
             h1 = get(gca, 'ylabel');
             set(h1,'FontSize',FntSize,'FontName','Times')
             set(gca,'xticklabel',{[]}) 
                subplot(3,1,3);
                plot(t,imag(hilbert(x))); 
                grid on
                title('Hilbert Transform');
                FntSize=18;
             set(gca,'FontSize',FntSize,'FontName','Times')
             h1 = get(gca, 'xlabel');
             set(h1,'FontSize',FntSize,'FontName','Times')
             h1 = get(gca, 'ylabel');
             set(h1,'FontSize',FntSize,'FontName','Times')
        end
        
        phi=unwrap(angle(z));
        diffPhase=diff(phi)*(Fs/(2*pi)); 
        figure
        plot(diffPhase);
        %%%%%%%%%%%%
        
        figure         
        subplot(3,1,1);
        plot(real(z));
        grid on;
        subplot(3,1,2);
        plot(imag(z));
        grid on;
        subplot(3,1,3);
        plot(abs(z));
        grid on;
        title('DCT');
        
        z1=hilbert(x);
        figure
        phi=unwrap(angle(z1));
        diffPhase1=diff(phi)*(Fs/(2*pi));
        plot(diffPhase, 'LineWidth',2); hold on;
        plot(diffPhase1,'r');
        grid on;
        legend('DCT IF', 'Hilbert IF');
        
        figure
        subplot(3,1,1);   
        plot(real(z1));
        grid on;
        subplot(3,1,2);
        plot(imag(z1));
        grid on;
        subplot(3,1,3);        
        plot(abs(z1));
        grid on;
        title('Hilbert'); 
        
        
        
                       
        tt=1;      
    end
