function plotfig_final(K,BP,BP2,stat)
%% Figure6


% Figure 7
figure(7)
plot(radius.eff,K1.median,'b*')%%%modified
xlabel('grain radius (mm)')
ylabel('permeability (mD)')
title('grain radius versus permeability')


%Figure 8
figure(8)
plot(LBD.Max*10^6, K1.median,'b*');%%%modified
xlabel('max. pore diameter (um)')
ylabel('permeability (mD)')

%Figure(9)

figure(9);
h2=plot(BP2.PhiU*100,Kcalc,'ko',BP2.PhiE*100,Kcalc,'b*');
xlabel('porosity (%)');      ylabel('permeability (mD)');     title('porosity versus permeability')
legend(h2,{'useful porosity','effective porosity'});

figure(11);
h2=plot(BP2.PhiE*100,BP2.VSh*100,'k<');
xlabel('effective porosity (%)');      ylabel('shale volume (%)');     title('porosity versus permeability')
legend(h2,{'shale volume (%)'});

figure(10);
h3=plot(BP2.PhiE*100,Reff*10^3,'ko',BP2.PhiE*100,LBD_max*10^6,'b*');
xlabel('effective porosity (%)');      ylabel('radius(micro m)');
legend(h3,{'grain radius','max.poredia'});


for jf=1:11
    n=11-jf+1;
    h=figure(n);
    saveas(gcf,['OUTPUT/FIGURES/figure',num2str(n)],'fig')
    saveas(gcf,['OUTPUT/FIGURES/figure',num2str(n)],'jpg')
    close(gcf)
end