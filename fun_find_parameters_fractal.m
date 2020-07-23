function [BLx, fract ]= fun_find_parameters_fractal(BL, fract)
% BLx.Nt    : Total number of pores corresponding to each layer       (Nx1)
% BLx.Df    : pore area fractal dimension corresponding to each layer (Nx1)
% BLx.Area  : porous cross section area corresponding to each layer   (Nx1)
% BLx.SandRadEff  : Effetive sand radius of each layer                (Nx1)

% BLx.Lambda is the pore diameter(Ratio, Min, Max, RatioCheck)
% BLx.LambdaMin         : 
% BLx.LambdaMax         : 
% BLx.LambdaRatio       : Min/Max 
% BLx.LambdaRatioCheck  : 

% fractal.SandRad or R  : Grain radius


%%  find the sand radius,

DClay=fract.DClay;                          %minimum particle diameter converted to m

if (fract.SandRad<=0)
    PhiUMax = max(BL.PhiU);                % highest useful porosity refers to pure sand interval
    F     = 0.62/(PhiUMax )^2.15;          % humble formula
    Kgess = (6.7*1e-8)/(F^4.591);          % in m^2
    T2    = (0.67/PhiUMax )^2;             % tortuosity^2 of pure sand layer
    Num   = sqrt(72*T2*Kgess)*(1-PhiUMax); %sand grain radius in m
    Den   = 2*(PhiUMax)^(3/2);
    %radius.Sand=(sqrt(72*T2*Kgess)/2)*((1-PhiUMax )/(PhiUMax )^(3/2)); %sand grain radius in m
    R = Num/Den;
    fract.SandRad  = R;
    disp( ' Recalculated var fract.SandRad.' )
else
    R = fract.SandRad;             %the input value of sand grain radius is converted to m
end

%% effective grain radius of shaly sand interval
BLx.SandRadEff=((DClay/2)*BL.VSh + R*BL.VSst)./(BL.VSh+BL.VSst); 
BLx.Area=0.5*pi*((BLx.SandRadEff).^2).*(1./(1-BL.PhiU));         %Lo=sqrt(Area);     %Representative length of cubic cell,

d = 2* (BLx.SandRadEff)/DClay;
BLx.LambdaRatio = ((sqrt(2)./d).*(sqrt((1- BL.PhiU))));
BLx.LambdaMax = ((BLx.SandRadEff)/2).*(sqrt(2*((1./(1-BL.PhiU))-1))+(sqrt((2*pi/sqrt(3))*(1./(1-BL.PhiU)))-2));
BLx.LambdaMin = BLx.LambdaRatio.* BLx.LambdaMax;

%%
% Condition 1: if Ratio <= 0           then   RatioCheck = 0 
% Condition 2: if Ratio < 0.01         then   RatioCheck = 0.01  
% Condition 3: if Ratio 0.01 --.014    then   Ratiocheck = Ratio*1.1
% Condition 4: if Ratio >.014          then   RatioCheck = 0

BLx.LambdaRatioCheck  = single(zeros(size( BLx.LambdaRatio)));              % Initialize the vector
BLx.LambdaRatioCheck( BLx.LambdaRatio<= 0)    = 0.0;                        % Condition 1
BLx.LambdaRatioCheck( BLx.LambdaRatio < 1e-2) = 0.010;                      % Condition 2

idx=find( (BLx.LambdaRatio >= 1e-2) &  (BLx.LambdaRatio<=14e-3 ) );         % Condition 3
BLx.LambdaRatioCheck(idx)              = BLx.LambdaRatio(idx) * 1.1;

BLx.LambdaRatioCheck( BLx.LambdaRatio>14e-3) = 0.0;                         % Condition 4


%% To estimate Df from the formula

BLx.Df = 2-(log(BL.PhiU)./log( BLx.LambdaMin./ BLx.LambdaMax));
BLx.Nt = (1./ BLx.LambdaRatio).^BLx.Df;


end
