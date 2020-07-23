function  plotfig_petrophysical_param(L,POR,VOL,BPV,fname)
figure()
%%
N=6;
subplot(1,N,1);    plot(L.Rho,L.Depth);     title('Density [g/cc]');   ylabel('Depth [z]');         set(gca,'XaxisLocation','Top')
subplot(1,N,2);    plot(L.GR,L.Depth);      title('GR');            set(gca,'XaxisLocation','Top')
subplot(1,N,3);    plot(POR.PhiE ,L.Depth, 'k');  hold on
                           plot(POR.PhiC,L.Depth, 'r') ;    
                           plot(POR.PhiU,L.Depth ,'b' ) 
                           legend('PhiE', 'PhiC', 'PhiU','Location', 'South');   set(gca,'XaxisLocation','Top');     title( 'Porosity')

subplot(1,N,4);    plot(VOL.Shale,  L.Depth, 'k');  hold on
                           plot(VOL.Sand,  L.Depth, 'r') 
                           legend('VShale', 'Vsand','Location', 'South');      set(gca,'XaxisLocation','Top');           title( 'Volume')

subplot(1,N,5);    plot(BPV.PhiE ,L.Depth, 'k');    hold on
                            plot(BPV.PhiC,L.Depth, 'r'); 
                            plot(BPV.PhiU,L.Depth ,'b'); 
                            legend('PhiE', 'PhiC', 'PhiU','Location', 'South');    set(gca,'XaxisLocation','Top');    title( 'Blocked Porosity')

subplot(1,N,6);    plot(BPV.VSh ,L.Depth, 'k');          hold on
                           plot(BPV.VSst,L.Depth, 'r');           legend('VSh', 'VSst', 'Location', 'South')
                            set(gca,'XaxisLocation','Top');     title( 'Blocked Volume')
                            
str= ['OUTPUT', filesep,fname]; 
print( gcf, str, '-djpeg','-r300' )
savefig(gcf, str )                           