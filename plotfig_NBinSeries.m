function plotfig_NBinSeries(NBinSeries, K1,tau,i, fname)

%Figure 2##################################
figure();  %%%%%%modified (Deleted 3 rd sub plot)
subplot(2,1,1); 
semilogx(NBinSeries,K1.err(i,:), '-ko','LineWidth',1.4, 'MarkerSize',8);
xlabel('Number of runs');   
ylabel('Standard error');           
title('Variation of error with number of runs');

subplot(2,1,2); 
semilogx(NBinSeries,tau(i,:)   , '-ko','LineWidth',1.4, 'MarkerSize',8);
xlabel('Number of runs');   
ylabel('\tau');      


str= ['OUTPUT', filesep,fname]; 
print( gcf, str, '-djpeg','-r300' )
savefig(gcf, str )

end