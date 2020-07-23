function [Dtcalc,K,n_elem_bin_series2,KF, lambda,tau]= ...
         fun_perm_estimation_fn(index, NRun,  Nt, Area, Df,  KB, LBD, BL, K, K1, cp)
 K=single(zeros(NRun,length(BL.PhiU)));     % Note N run might change each time.
G=pi/128;
Dtmat=single(zeros(NRun,length(BL.PhiU)));
t=(0.67)./BL.PhiU;
for runs=1:NRun
    for j=index' %1:length(BI.PhiU);
        ktest=KB.max+2;
        while ktest<KB.min||ktest>KB.max
            %%%%% The execution of MC algorithm            %%%%%%%%%%%%%%%%%
            flag=1;
            while flag
                %clear   lambda
                lambda_rand = rand(round(Nt(j)),1).* (  1 - LBD.Ratio(j).^Df(j) );   % Constrain random no  to a range of lambda
                lambda = LBD.Ratio(j)*(LBD.Max(j)./( 1 - lambda_rand).^(1/Df(j)));      % Generate the lambda
                cum_aj=  (pi/4)*cumsum(lambda.^2)./BL.PhiU(j);                     % Generate area
                
                check=( cum_aj /Area(j) )>=1;                                        % To check if any cumulavie sum is less than Area, if yes then continue
                if any(check);                                                          % Check if any Aj> Area is found in cumsum matrix
                    id=find(check==1,1);                                             % find first occurance of 1 in the check vector
                    flag=~(  (  min(lambda(1:id))/max(lambda(1:id))  )<LBD.RatioCheck(j)   );
                end
            end
            LMratio_sim=min(lambda(1:id))/max(lambda(1:id)) ;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            av_diameter= Df(j)*  min(lambda(1:id))/ (Df(j) - 1)*(1- LMratio_sim^(Df(j)-1));
            Lo=sqrt(cum_aj(id));
            
            Dt=1+(log(t(j))/log(Lo/av_diameter));
            S=sum(lambda(1:id).^(3+Dt));
            ktest=G*( (cum_aj(id))^(-(1+Dt)/2))*S*(1/0.98692)*10^15;               %in mdarcy
        end
        K(runs,j)=ktest;   %check
        Dtmat(runs,j)=Dt;
    end
end

Dtcalc=mean(Dtmat);
if isempty(K1) 
     K1.LogKbin_mean=0;
     K1.err=0;
     K1.UB=0;
     K1.LB=0;
     K1.median=0;
end
[n_elem_bin_series2,  KTEMP.LogKbin_mean, KTEMP.err, KTEMP.UB, KTEMP.LB, KTEMP.median, tau]=... 
                                      fn_corr_time2(K,cp);
KF.LogKbin_mean = KTEMP.LogKbin_mean + K1.LogKbin_mean;
KF.err =KTEMP.err + K1.err;
KF.UB = KTEMP.UB + K1.UB;
KF.LB = KTEMP.LB + K1.LB;
KF.median = KTEMP.median + K1.median;
end

