function [radius, Area, Nt, Df, LBD ]= ...
    fun_find_parameters_fractal(BL, fract)
% Nt    : Total number of pores
% Df    : pore area fractal dimension
% DClay : diameter of clay                      (AJ: Removed)
% Area  : porous cross section area
% radius: Grain radius
% LBD   : pore diameter(Ratio, Min, Max, RatioCheck)


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
    radius.Sand = Num/Den;
else
    radius.Sand=fract.SandRad;             %the input value of sand grain radius is converted to m
end

%% effective grain radius of shaly sand interval
radius.Eff=((DClay/2)*BL.VSh + radius.Sand*BL.VSst)./(BL.VSh+BL.VSst); 

Area=0.5*pi*(radius.Eff.^2).*(1./(1-BL.PhiU));         %Lo=sqrt(Area);     %Representative length of cubic cell,

d=2*radius.Eff/DClay;
LBD.Ratio=((sqrt(2)./d).*(sqrt((1- BL.PhiU))));
LBD.Max=(radius.Eff/2).*(sqrt(2*((1./(1-BL.PhiU))-1))+(sqrt((2*pi/sqrt(3))*(1./(1-BL.PhiU)))-2));
LBD.Min= LBD.Ratio.* LBD.Max;

%%
% Condition 1: if Ratio <= 0           then   RatioCheck = 0 
% Condition 2: if Ratio < 0.01         then   RatioCheck = 0.01  
% Condition 3: if Ratio 0.01 --.014    then   Ratiocheck = Ratio*1.1
% Condition 4: if Ratio >.014          then   RatioCheck = 0

LBD.RatioCheck  = single(zeros(size( LBD.Ratio)));              % Initialize the vector
LBD.RatioCheck( LBD.Ratio<= 0)    = 0.0;                        % Condition 1
LBD.RatioCheck( LBD.Ratio < 1e-2) = 0.010;                      % Condition 2

idx=find( (LBD.Ratio >= 1e-2) &  (LBD.Ratio<=14e-3 ) );         % Condition 3
LBD.RatioCheck(idx)              = LBD.Ratio(idx) * 1.1;

LBD.RatioCheck( LBD.Ratio>14e-3) = 0.0;                         % Condition 4



%% to estimate Df from the formula
Df = 2-(log(BL.PhiU)./log( LBD.Min./ LBD.Max));
Nt = (1./ LBD.Ratio).^Df;


end
