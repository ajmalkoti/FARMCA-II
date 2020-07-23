function plotfig_Phiu_Kfull_Vs_depth(BP,Kfull)

figure ()
subplot(1,2,1);
plot(flipud(BP.PhiU*100),flipud(BP.Depth),'k-','Linewidth',2);
set(gca,'ydir','reverse')
title('useful porosity (%)')

subplot(1,2,2);
plot(flipud(Kfull(:,2)),flipud(BP.Depth),'k-','Linewidth',2);
set(gca,'ydir','reverse')
title('permeability (mD)')