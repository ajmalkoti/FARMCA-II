function [POR,VOL]= fun_parametrs_derived(logs,GR,Rho, Ldepth, PlotON )
POR.PhiE=single(zeros(length(logs.Depth),1));
GMA1=round(logs.GR);

%estimation of porosity
%to estimate the average density of pure sand interval
num1=find(logs.Depth<Ldepth.SstBottom  &  logs.Depth>Ldepth.SstTop);
RHO_clean=mean(logs.Rho(num1));

%to estimate the average density of pure shale interval
num2 = find(logs.Depth<Ldepth.ShaleBottom  &  logs.Depth>Ldepth.ShaleTop);
RHO_shale = mean( logs.Rho( num2 ) );

indx_interest_zone=find(GMA1<GR.SandMax);
n1=find(GMA1>=GR.ShaleMin);

%estimate effective porosity
for i=1:length(POR.PhiE)
    if GMA1(i)<GR.SandMax
        POR.PhiE(i)=(logs.Rho(i) - Rho.Mat)/(Rho.Fl-Rho.Mat);      %porosity of pure sand layer
    else
        GMA1(indx_interest_zone)=GR.SandMax;
        GMA1(n1)= GR.ShaleMin;
        
        I=(GMA1- GR.SandMax)/(GR.ShaleMin - GR.SandMax);             %Shale volume calculated from Gamma-ray log
        VOL.Shale=0.083*(2.^(3.7* I)-1);                           %Dresser tertiary rock equation
        
        logs.Rho(i) = RHO_clean*(1-VOL.Shale(i))+RHO_shale*VOL.Shale(i);          %In case of shaly sand stone layers Bulk density is corrected for shale volume
        POR.PhiE(i)=(logs.Rho(i)-Rho.Mat)/(Rho.Fl-Rho.Mat);           %effective porosity of shaly sand stone
    end
end

VOL.Sand=1-POR.PhiE-VOL.Shale;

indx_interest_zone=find(VOL.Sand<0);
VOL.Sand(indx_interest_zone)=0;

C=(VOL.Shale./(VOL.Shale+VOL.Sand));
POR.PhiC=POR.PhiE .*C;                               %critical porosity
POR.PhiU=POR.PhiE -POR.PhiC;                            %useful porosity



if ~isempty(PlotON)
   plotfig_Vsh_Phiu_Vs_phi(VOL,POR,PlotON ) 
end
end