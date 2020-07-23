function [Klog_interpolated]=create_perm_log(depth_block,Mdepth1,Kcalc)

D=zeros(length(Mdepth1),1);
for i=1:length(Mdepth1)
    i;
    k=find(depth_block==Mdepth1(i));
    D(i)=k;
end
klog=zeros(length(depth_block),1);
for j=0:length(D)-2
    n=D(j+2);
    n1=D(j+1);
    N=n-n1;
    m=repmat(Kcalc(j+1),N,1);
    klog(n1:n-1,1)=m;
end
    j=j+1;
    n1=n;
    n=length(depth_block);
    N=n-n1;
    m=repmat(Kcalc(j+1),N+1,1);
    
  klog(n1:n,1)=m;
  Klog_interpolated=[depth_block klog];
end
