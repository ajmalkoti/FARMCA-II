function [BP, B] = fun_blocked(logs, POR, VOL,  GR, PlotON )
% The logs are blocked (provided same values)

% blocking of porosity logs
A=[POR.PhiE    POR.PhiC    POR.PhiU    VOL.Sand     VOL.Shale];
A=round(A*100)./100;

logs.GR=round(logs.GR);
n1=find(logs.GR<GR.SandMax);

n2=find(logs.GR>=GR.SandMax & logs.GR<=GR.ShaleMin);
n3=find(logs.GR>GR.ShaleMin);

idx1=find(diff(n1)>1);
idx2=find(diff(n2)>1);
idx3=find(diff(n3)>1);


B=zeros(size(A,1),size(A,2));
%%%%%%%%%%
l=1;
if isempty(idx1)==1
    idx1=n1(end);
    jrange=[1;idx1+1];
else
    jrange=[1;idx1+1];
    idx1=[idx1;idx1(end)+(size(n1,1)-idx1(end))];
end

for j1=1:size(idx1,1)
    j=jrange(l);
    idx1(j1);
    c=A(n1(j):n1(idx1(j1)),:);
    if size(c,1)==1
        c1=c;
    else
        c1=mean(c);
    end
    
    n1(j);
    n1(idx1(j1));
    B(n1(j):n1(idx1(j1)),:)=repmat(c1,size(c,1),1);
    
    l=l+1;
end

%%%%%%%%%%%%%%
l=1;
if isempty(idx2)==1
    idx2=n2(end);
    jrange=[1;idx2+1];
else
    jrange=[1;idx2+1];
    idx2=[idx2;idx2(end)+(size(n2,1)-idx2(end))];
end

for j1=1:size(idx2,1)
    j=jrange(l);
    c=A(n2(j):n2(idx2(j1)),:);
    if size(c,1)==1
        c1=c;
    else
        c1=mean(c);
    end
    
    B(n2(j):n2(idx2(j1)),:)=repmat(c1,size(c,1),1);
    l=l+1;
end
%%%%%%%%%%%%
l=1;
if isempty(idx3)==1
    idx3=n3(end);
    jrange=[1;idx3+1];
else
    jrange=[1;idx3+1];
    idx3=[idx3;idx3(end)+(size(n3,1)-idx3(end))];
end
for j1=1:size(idx3,1)
    j=jrange(l);
    c=A(n3(j):n3(idx3(j1)),:);
    if size(c,1)==1
        c1=c;
    else
        c1=mean(c);
    end
    
    B(n3(j):n3(idx3(j1)),:)=repmat(c1,size(c,1),1);
    
    l=l+1;
end
%%%%%%%%

B = round(B*100)./100;
B = single(B);

% Blocked parameters
BP.PhiE = B(:,1);
BP.PhiC = B(:,2);
BP.PhiU = B(:,3);
BP.VSst = B(:,4);
BP.VSh  = B(:,5);
BP.Depth= logs.Depth ;

if ~isempty(PlotON)
   plotfig_petrophysical_param(logs,POR,VOL,BP, PlotON)  
   %plotfig_Vsh_Phiu_Vs_phi(VOL,POR,PlotON ) 
end

end