function [Nt, Df, dclay, Area, index, radius, lambda, BL2 ]= fun_find_parameters_fractal(BL, fract); % phishale,BL,dclay,rad_opt)              
% Nt    : Total number of pores
% Df    : pore area fractal dimension
% dclay : diameter of clay
% Area  : porous cross section area
% index : index for which permeability is computed (after ignoring repetition)
% radius: Grain radius
% lambda: pore diameter
% BL2   : logs 

%% select useful porosity
index = single(find(BL.PhiU >= fract.PhiShale));     % program will run for these indices
BL2.PhiU  = BL.PhiU(index);
BL2.VSst  = BL.VSst(index);
BL2.VSh   = BL.VSh(index);
BL2.Depth = BL.Depth(index);

%%  find the sand radius,
dclay=fract.DClay;            %minimum particle diameter converted to m
if (fract.SandRad<=0)
    PhiUMax = max(BL.PhiU);                 % highest useful porosity refers to pure sand interval
    F= 0.62/(PhiUMax )^2.15;                   % humble formula
    Kgess = (6.7*1e-8)/(F^4.591);            % in m^2
    T2=(0.67/PhiUMax )^2;                       % tortuosity^2 of pure sand layer
    radius.Sand=(sqrt(72*T2*Kgess)/2)*((1-PhiUMax )/(PhiUMax )^(3/2)); %sand grain radius in m
else
    radius.Sand=fract.SandRad;       %the input value of sand grain radius is converted to m
end

%effective grain radius of shaly sand interval
radius.Eff=((dclay/2)*BL2.VSh + radius.Sand*BL2.VSst)./(BL2.VSh+BL2.VSst); 

Area=0.5*pi*(radius.Eff.^2).*(1./(1-BL2.PhiU));         %Lo=sqrt(Area);     %Representative length of cubic cell,

d=2*radius.Eff/dclay;
lambda.Ratio=((sqrt(2)./d).*(sqrt((1- BL2.PhiU))));
lambda.Max=(radius.Eff/2).*(sqrt(2*((1./(1-BL2.PhiU))-1))+(sqrt((2*pi/sqrt(3))*(1./(1-BL2.PhiU)))-2));
lambda.Min= lambda.Ratio.* lambda.Max;

% to estimate Df from the formula
Df=2-(log(BL2.PhiU)./log( lambda.Min./ lambda.Max));
Nt=(1./ lambda.Ratio).^Df;

% if Ratio < 0.01         then   RatioCheck = 0.01  
% if Ratio 0.01 --.014  then   Ratiocheck = Ratio*1.1
% if Ratio >.014          then   RatioCheck =0
% if Ratio<= 0            then    Ratio Check=0 

lambda.RatioCheck  = single(zeros(size( lambda.Ratio)));
lambda.RatioCheck( lambda.Ratio<1e-2) = 0.010;

idx=find( lambda.Ratio>= 1e-2  &    lambda.Ratio<=14e-3 );
lambda.RatioCheck(idx) =  lambda.Ratio(idx) * 1.1;

lambda.RatioCheck( lambda.Ratio>14e-3) = 0.0;
lambda.RatioCheck( lambda.Ratio<= 0) = 0.0;

end
