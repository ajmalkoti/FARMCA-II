function plotfig_K_freq(K,i)
% Figure 4
figure();   
histfit(K(:,i));            
xlabel('permeability');             
ylabel('frequency');