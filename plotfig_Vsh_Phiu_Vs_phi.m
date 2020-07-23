function plotfig_Vsh_Phiu_Vs_phi(VOL,POR, strname)

%Figrue 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure();     
plot(VOL.Shale*100,   POR.PhiU*100,'b*')  ; hold on
plot(VOL.Shale*100, POR.PhiE*100,'ko');

xlabel('Shale volume (%)');         
ylabel('Porosity (%)');         
title('Porosity variation with shale volume');
legend('Useful porosity','Effective porosity','Location','NorthEast');


str= ['OUTPUT', filesep,strname]; 
print( gcf, str, '-djpeg','-r300' )

savefig(gcf, str )
end 