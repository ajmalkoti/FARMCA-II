function [PSim] = fun_error_analysis_on_max_porosity(BP,BLx,PSim,KB)

% the maximum useful porosity is considered for error analysis
MaxPhiIdx = find(BP.PhiU==max(BP.PhiU),1);      

flag=0;         
tic
while flag==0    
    fprintf('No of runs: %d \n',PSim.NRun);
    for iter=1:3        
        [Dt1,K,NBinSeries,K1,SimLBD,tau]= fun_perm_estimation(MaxPhiIdx,BP,BLx,PSim,KB);
        err_round = round(K1.err(:,MaxPhiIdx),2); 
        flag = issorted(err_round(1:PSim.CP));    
        if (err_round(PSim.CP) < PSim.ErrorLimit) && (flag==1)
           break       
        end
    end
    PSim.NRun= PSim.NRun*2; 
end
PSim.NRun= PSim.NRun/2; 
disp('Total time for testing is : ')
toc

plotfig_NBinSeries(NBinSeries, K1,tau,4, 'fig_NBinSeries')            
plotfig_N_lbd(SimLBD,'fig_N_LBD')  

%save(['OUTPUT',filesep,'state_testrun.mat']);       % load(['OUTPUT',filesep,'state_testrun.mat']); 
%writedata_simLBD(SimLBD,'AW_max_phi_lambda.txt')

end