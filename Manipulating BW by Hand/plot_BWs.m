function  plot_BWs(sig, Target, BWM, BW,BWS )
 
f = figure;
f.WindowState = 'maximized';
t=1:numel(sig);
plot(t,sig ,'b'); % just plotting something, but totally not required
hold on
plot(t,BWM,'g')
plot(t,Target, 'k')
plot (t,BW,'r', 'LineWidth',2 )
plot(t,BWS,'m', 'LineWidth',2)
legend ('Eye', 'BWM: moving avrage', 'Target', 'BW: Hand', 'BWS:smoothed BW')
grid on
grid min
end

