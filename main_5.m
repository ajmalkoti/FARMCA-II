%% Description of parameters and code 
% All inputs are defined in param_testing/param_actual (depending which simulation you are running)

% Conventions to be followed
% Logs name convection       logs.__ = GR, Depth, Rho
% PetroParam- Porosity       PPPOR.__= PhiE, PhiC, PhiU 
% PetroParam- Volume         PPVOL.__= Sh, Sst
% Param  GR                    PGR.__= High, SandMax, ShaleMin
% Param  Rho                  PRho.__= Fl, Mat, Min,Max
% Param  Depth              PDepth.__= Start, Stop, SstTop, SstBottom,ShaleTop, ShaleBottom
% Param  Simulation           PSim.__= NRun, ErrorLimit, cp
% Param  Fractal            PFract.__= DClay,PhiShale, GrainRad
% KB, 
%
%  Points to be noted: 
% 1) Make a uniform  nomenclature for variables (otherwise there is thick chances for error.)
% 2) Write all the plotting and data writing functions as the functions.
% 3) Write a function for checking/ploting the result, so that they can be varified.


%%  Default setup:  creates the Output folder etc
clc;    clear all;      close all;
setup_code(pwd)                                                      

% STEP: 1) load, select, derive parameters.
% load all the parameters, data for given zone of interest
[Logs,PRho,PGR,PDepth, PSim,PFract,KB] = fun_param_testing('balol183_4.txt','fig_InputLogs')  ;         % plotfig_logs(logs, 'fig_InputLogs')            

% selected part of logs (in zone of interest)
[Logs] = fun_select_filter_N_interpolate_logs(Logs,PDepth,PRho,PGR, 'fig_SelectedLogs' );       % plotfig_logs(logs, 'fig_SelectedLogs')

% derive the useful/conventional parameters using logs
[POR, VOL] = fun_parametrs_derived(Logs, PGR, PRho, PDepth,'fig_porosity_vs_shalevol');         % plotfig_Vsh_Phiu_Vs_phi(VOL,POR,'fig_porosity_vs_shalevol' ) 
 
[BP, ~]  = fun_blocked(Logs, POR, VOL, PGR, 'fig_Blocked_LogsNParam');     % plotfig_petrophysical_param(logs,POR,VOL,BP, 'fig_LogsNParam')      

[BP2,IdxRep]= fun_remove_repetitions(BP,PFract);              % plotfig_removed_repetitions(BP,BP2); 
                                                              % writedata_BlockedLogs(BP,'blocked_logsB183_GR35.txt')
% STEP: 2,3,4)  Estimate Fractal parameters                   %[R,Area, Nt, Df, LBD] = fun_find_parameters_fractal(BP2, PFract);
[BLx, PFract2] = fun_find_parameters_fractal(BP2, PFract);

% skip the values forwhich ratio check ==0 
[BLx,BP3, IdxRep] = fun_remove_nonfractal(BLx,BP2,IdxRep); 
close('all') 

% STEP: 5) Error analysis (partial): This is required to find the NRun using max porosity (else not required).  
PSim2 = fun_error_analysis_on_max_porosity(BP2,BLx,PSim,KB);

% Error analysis (full run: for all porosities) 
[Dt,K,NBinSeries,KStat,SimLBD,tau] = fun_perm_estimation(IdxRep.LambdaUni4,BP2,BLx,PSim2,KB);
save(['OUTPUT',filesep,'state_fullrun.mat']);                              % load(['OUTPUT',filesep,'state_fullrun.mat']); 

%% Fill back for the duplicate coloumns 



%%
Dt= Dt+Dt1;
[KStat, Dt, stat, Kfull] = fun_fill_duplicate(R,Dt,temp,LBD,KStat,BP,BP2,index);

[Klog_interpolated]= fun_create_perm_log(BP.Depth,BP2.Depth,Kcalc);


%%
plotfig_K_freq(K,2) 
plotfig_Phiu_Kfull_Vs_depth(BP,Kfull)

Kcalc = stat(:,1);
% Reff=BI_perm_stats(:,5);
KUBound = stat(:,2);
KLBound = stat(:,3);
% error=BI_perm_stats(:,4);
% LBD_max=BI_perm_stats(:,6);

figure();
h=plot(BP2.PhiU*100,Kcalc2,'k.',...
       BP2.PhiU*100,KUBound2,'r-',...
       BP2.PhiU*100,KLBound2,'b-');
hold on
plot(BP2.PhiU*100,Kcalc1,'k.')%%%modified
xlabel('useful porosity (%)');      
ylabel('permeability (mD)');     
title('Useful porosity versus permeability')
legend(h,{'median','first quartile','third quartile'});



plotfig_final(K,BP,BP2,stat)
writedata_final()

