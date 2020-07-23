function [logs,Rho,GR, depth,sim, fract, KB] = fun_param_testing(fname, PlotON)  
%FUN_PARAM_TESTING
% Create a default set of parameters used for testing the code.

logs.FName = fname;
logs.Rho=single(dlmread(['INPUT',filesep,fname],'\t',[0 12 5844 12]));
logs.Depth=single(dlmread(['INPUT',filesep,fname],'\t',[0 0 5844 0]));
logs.GR=single(dlmread(['INPUT',filesep,fname],'\t',[0 8 5844 8]));
logs.nanval = -999.25;              % LOG NAN VALUES

Rho.Fl=single(1.1);             % fluid density-default density of saline water in g/cc
Rho.Mat=single(2.65);           % density of matrix-Default density of quartz mineral in g/cc
Rho.Min=single(2.0);            % RHOmin should be greater than or equal to RHOf
Rho.Max=single(2.58);           % RHO.max this should less than or equal to RHO.m

GR.High =single(130);           %GMA_high=130;
GR.SandMax=single(35);          % the gamma ray reading below which the formation is pure sand
GR.ShaleMin=single(55);         % the gamma ray reading above which the formation is pure shale
                                %GMAmin & GMAmax can change one formation to another

depth.Start=single(3155.5);             % startdepth=1116;
depth.Stop=single(3786.089);
depth.SstTop=single(3517.06);           %1128
depth.SstBottom=single(3599.081);       % 1130
depth.ShaleTop=single(3212.5984);       %1116.5
depth.ShaleBottom=single(3253.6089);    %1119

sim.NRun=single(2^8);            % No of run
sim.ErrorLimit=single(300);      % for testing of the parameters, error_limit can be taken between 10-15
sim.CP=single(2);                % no of points used to test convergence of the error, for testing purposes it can be 2

fract.DClay = single(0.6);       % minimum partcle zie or clay particle size in micro meters
fract.PhiShale=single(0.10);     % Maximum porosity of predominantly shale intervals, the porosity values below which are ignored from the computation, it can be tween 0.11 to 0.14
fract.SandRad= -999;             % It should be a +ve value in micro m. Default value is in -ve  (program will calculate in this case); 

% extra
KB.min=single(2);                % PERMEABILITY BOUNDS
KB.max=single(18000);


%% %%%%%%%%%
% Don't change here afterwards
%
fract.DClay = fract.DClay*1e-6;             %minimum partcle zie or clay particle size converted from micro meters to meters

if (fract.SandRad<= 0);    
    disp('    Grain radius will be estimated by program since no value provided. ') 
else           
    fract.SandRad= fract.SandRad*1e-6;     % change grain radius from micro meters to meters.
end


if ~isempty(PlotON)
   plotfig_logs(logs,PlotON) 
end

end