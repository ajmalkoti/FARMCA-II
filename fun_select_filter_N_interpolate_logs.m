function [logs]=fun_select_filter_N_interpolate_logs(logs, depth, PRho, PGR, PlotON )

% zero out all the elements out of range 
indx_out_of_range_zone=find(logs.Depth <depth.Start  |   logs.Depth>depth.Stop);
logs.Depth(indx_out_of_range_zone)=[];       
logs.Rho(indx_out_of_range_zone)=[];     
logs.GR(indx_out_of_range_zone)=[];

%very high & low values of density are removed to avoid verylow & high porosity
indx_high=find(logs.Rho>=PRho.Max | logs.GR>=PGR.High | logs.Rho<PRho.Min); 

logs.Rho(indx_high)=[];      
logs.Depth(indx_high)=[];    
logs.GR(indx_high)=[];

curves=[logs.Rho logs.GR];
interpolcurves=zeros(size(curves));

for i=1:2;
    curve1 = curves(:,i);
    index=find(curve1~= logs.nanval );
    idx=find(diff(index)>1);
    nidx=length(idx);
    for ii=1:nidx
        ia=index(idx(ii));
        ie=index(idx(ii)+1);
        curve1(ia+1:ie-1)=interp1q(depth([ia,ie]),curve1([ia,ie]),depth(ia+1:ie-1));
    end
    interpolcurves(:,i)=curve1;
end

logs.Rho=single(interpolcurves(:,1));
logs.GR=single(interpolcurves(:,2));


if ~isempty(PlotON)
   plotfig_logs(logs, PlotON) 
end
end
