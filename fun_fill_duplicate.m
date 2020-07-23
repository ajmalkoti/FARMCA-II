function [K1, Dt,BI_perm_stats,Klog_interpolated] = fun_fill_duplicate(radius,Dt, temp,LBD,K1, BP,BP2,index)

% Filling for repeated porosity values
for il=1:length(temp)   
    index3=find(temp(il)==LBD.Max);
    for jl=index3'
        K1.LogKbin_mean(:,jl)=K1.LogKbin_mean(:,index3(1));
        K1.err(:,jl)=K1.err(:,index3(1));
        K1.UB(:,jl)=K1.UB(:,index3(1));
        K1.LB(:,jl)=K1.LB(:,index3(1));
        K1.median(:,jl)=K1.median(:,index3(1));
        Dt(jl)=Dt(index3(1));
    end
end

% Filling for repeated porosity values
BI_perm_stats=zeros(length(BP2.Depth),6);
for ik=1:length(K1.median)
    BI_perm_stats(index(ik),1)= K1.median(ik);  %%%modified
    BI_perm_stats(index(ik),5)= radius.Eff(ik);    %%%modified
    BI_perm_stats(index(ik),2)= K1.UB(ik);       %%%modified
    BI_perm_stats(index(ik),3)=K1.LB(ik);         %%%modified
    BI_perm_stats(index(ik),4)=K1.err(1,ik);      %%%modified
    BI_perm_stats(index(ik),6)=LBD.Max(ik);    %%%modified
end

% 
Kcalc=BI_perm_stats(:,1);
Reff=BI_perm_stats(:,5);
KUBound=BI_perm_stats(:,2);
KLBound=BI_perm_stats(:,3);
error=BI_perm_stats(:,4);
LBD_max=BI_perm_stats(:,6);
%PHI_K_stats=[BP2.Depth BP2.PhiU Reff Kcalc error KUBound KLBound LBD_max];

 
[Klog_interpolated]=create_perm_log(BP.Depth,BP2.Depth,Kcalc);
% 
BP.K=Klog_interpolated(:,2);

IA1=find(BP2.PhiU > PFract.PhiShale);
Kcalc1=Kcalc(IA1);     %%%modified
KUBound1=KUBound(IA1); %%%modified
KLBound1=KLBound(IA1);%%%modified

BP2.PhiU=BP2.PhiU(IA1);%%%modified

[BP2.PhiU, IA, IC]=unique(BP2.PhiU,'first');    % modified
Kcalc2=Kcalc1(IA);                              % 
KUBound2=KUBound1(IA);%%%modified
KLBound2=KLBound1(IA);%%%modified

