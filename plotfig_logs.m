function plotfig_logs(L, strname)
figure()
subplot(1,2,1);     plot(L.Rho,L.Depth)
title('Density [g/cc]'); 
ylabel('Depth [z]')
set(gca,'XaxisLocation','Top')
axis ij
grid on

subplot(1,2,2);     plot(L.GR,L.Depth) 
title('GR'); 
ylabel('Depth [z]')
set(gca,'XaxisLocation','Top')
axis ij
grid on

str= ['OUTPUT', filesep,strname]; 
print( gcf, str, '-djpeg','-r300' )

savefig(gcf, str )
end