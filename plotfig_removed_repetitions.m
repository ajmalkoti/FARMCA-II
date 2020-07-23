function plotfig_removed_repetitions( BP,BP2 )
%PLOTFIG_REMOVED_REPETITIONS Summary of this function goes here
%   Detailed explanation goes here

figure()
subplot(1,5,1)
plot(BP.PhiE, BP.Depth); hold on
plot(BP2.PhiE, BP2.Depth, 'o')
xlabel('PhiE (%)')
ylabel('Depth [m]')
set(gca, 'XAxisLocation','Top')


subplot(1,5,2)
plot(BP.PhiC, BP.Depth); hold on
plot(BP2.PhiC, BP2.Depth, 'o')
xlabel('PhiC (%)')
set(gca, 'XAxisLocation','Top','YTickLabel',[])


subplot(1,5,3)
plot(BP.PhiU, BP.Depth); hold on
plot(BP2.PhiU, BP2.Depth, 'o')
xlabel('PhiU (%)')
set(gca, 'XAxisLocation','Top','YTickLabel',[])


subplot(1,5,4)
plot(BP.VSst, BP.Depth); hold on
plot(BP2.VSst, BP2.Depth, 'o')
xlabel('VSst (%)')
set(gca, 'XAxisLocation','Top','YTickLabel',[])


subplot(1,5,5)
plot(BP.VSh, BP.Depth); hold on
plot(BP2.VSh, BP2.Depth, 'o')
xlabel('VSh (%)')
set(gca, 'XAxisLocation','Top','YTickLabel',[])
end

