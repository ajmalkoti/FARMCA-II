function [logs,RHO,GR,a,depth,Ldepth,phishale,dclay,N_run,KB,error_limit,cp] ...
                                     = fun_param_real()
%Read the tab spaced text file or las file
logs.RHO=single(dlmread('INPUT/balol183_4_noheader.txt','\t',[0 12 5844 12]));
logs.Depth=single(dlmread('INPUT/balol183_4_noheader.txt','\t',[0 0 5844 0]));
logs.GR=single(dlmread('INPUT/balol183_4_noheader.txt','\t',[0 8 5844 8]));

% logs.RHO=dlmread('B161_logs_noH.txt','\t',[0 1 1000 1]);
% logs.Depth=dlmread('B161_logs_noH.txt','\t',[0 0 1000 0]);
% logs.GR=dlmread('B161_logs_noH.txt','\t',[0 2 1000 2]);

RHO.f=single(1.1);              %fluid density-default density of saline water in g/cc
RHO.m=single(2.65);             %density of matrix-Default density of quartz mineral in g/cc
RHO.min=single(2.0);           %RHOmin should be greater than or equal to RHOf
RHO.max=single(2.58);            %RHO.max this should less than or equal to RHO.m

GR.high =single(130);           %GMA_high=130;
GR.sand_max=single(35);      %the gamma ray reading below which the formation is pure sand
GR.shale_min=single(55);     %the gamma ray reading above which the formation is pure shale
%GMAmin & GMAmax can change one formation to another
a=-999.25;
depth.start=single(3155.5);    %startdepth=1116;
depth.stop=single(3786.089);
Ldepth.topVSST=single(3517.06);  %1128
Ldepth.bottomVSST=single(3599.081); %1130

Ldepth.topVSh=single(3212.5984);  %1116.5
Ldepth.bottomVSh=single(3253.6089);  %1119
%Ntext=single(31);              %number of rows to be ignored from the textfile
phishale=single(0.10);         %Maximum porosity of predominantly shale intervals, the porosity values below which are ignored from the computation, it can be tween 0.11 to 0.14
dclay=single(0.6);             %minimum partcle zie or clay particle size in micro meters
N_run=single(2^8);           %No of run

KB.min=single(2);
KB.max=single(18000);
error_limit=single(200);      %for testing of the parameters, error_limit can be taken between 10-15
cp=single(2);               % no of points used to test convergence of the error, for testing purposes it can be 2


end