function [Dtcalc,K,NBinSeries,KStat, lambda,tau]= fun_perm_estimation(index, BL,BLx,PSim,KB)

%FUN_PERM_ESTIMATION
% OUTPUTS
% Dtcalc =  Tartousity fractal dimension
% K      = Permeability
% NBinSeries = Binned series of "K" and "error in K"  for N number of elements where N =2^i
% Kmean     = Mean Permeability 
% lambda = Diameter of pores
% tau    = Integrated correlation time
%------------------------------------------------
% INPUTS
% index  =  indexes for unique porosity values
% BL     =  Blocked Logs
%
% BLx.Nt     =  Total number of pores
% BLx.Area   =  Cross section area of block with pores 
% BLx.Df     =  Fractal dimension of pores   
% BLx.LambdaMax    =  parameter(structure) containing information about diameter e.g. Min/Max/RatiCheck/Ratio 
% BLx.LambdaMin
% BLx.LambdaRatio
% BLx.LambdaRatioCheck
%
% PSim.Nrun     =  No of runs 
% PSim.cp       =  Number of points used for checking convergence.
%
% KB,    =  Upper and lower bounds for permeability



%%%%%%% shortening the names of variables for sake of clarity
NRun = PSim.NRun;
NDepth = length(BL.PhiU);

Nt = BLx.Nt;
Df = BLx.Df;
LambdaRatio = BLx.LambdaRatio;
LambdaMax   = BLx.LambdaMax ;
LambdaMin   = BLx.LambdaMin;
LambdaRatioCheck = BLx.LambdaRatioCheck;
Area = BLx.Area;

% Predefined constants
G = (pi/128)*(1/0.98692)*10^15;
t=(0.67)./BL.PhiU;

% pre allocate matrices
Dtmat=single(zeros(NDepth,NRun));
K = single(zeros(NDepth,NRun) );

for runs=1:NRun
    for j=index' 
        ktest=KB.max+2;                     % this value is assign so that the followingwhile loop is traveresed at least once.
        while ktest<KB.min||ktest>KB.max
            % The execution of MC algorithm
            flag=1;                        
            while flag
                clear lambda
                lambda_rand = rand(round(Nt(j)),1).*(1 - LambdaRatio(j).^Df(j) );     % Constrain random no  to a range of lambda
                lambda = LambdaRatio(j)*(LambdaMax(j)./(1-lambda_rand).^(1/Df(j)));   % Generate the lambda
                cum_Aj=  (pi/4)*cumsum(lambda.^2)./BL.PhiU(j);                        % Generate area
                
                check=( cum_Aj /Area(j) )>=1;                                        % To check if any cumulavie sum is less than Area, if yes then continue
                if any(check)                                                          % Check if any Aj> Area is found in cumsum matrix
                    id=find(check==1,1);                                             % find first occurance of 1 in the check vector
                    LMratio_sim =  min(lambda(1:id))/max(lambda(1:id));   
                    flag=~(  LMratio_sim<LambdaRatioCheck(j)   );
                end
            end
            LMratio_sim=min(lambda(1:id))/max(lambda(1:id)) ;
            
            %
            av_diameter= Df(j)*min(lambda(1:id))/( Df(j) - 1 )*( 1- LMratio_sim^(Df(j)-1) );
            Lo=sqrt(cum_Aj(id));
            
            Dt= 1 + ( log(t(j))/log(Lo/av_diameter) );
            S=sum(lambda(1:id).^(3+Dt));
            ktest=G*( (cum_Aj(id))^(-(1+Dt)/2))*S;               % Permeability in mdarcy
        end
        K(j,runs)=ktest;   %check
        Dtmat(j,runs)=Dt;  % check
    end
end

Dtcalc=mean(Dtmat,2);  % check


[NBinSeries,LogKbin_mean,err,UB,LB,median,tau] = fun_corr_time2(K',PSim.CP);


NBinSeries = NBinSeries';
tau = tau';

KStat.LogKbin_mean = LogKbin_mean';
KStat.err = err' ;
KStat.UB = UB' ;
KStat.LB = LB'; 
KStat.median =median' ;

                                   
end

