function  [NBinSeries,  LogKbin_mean, err, KUBound, KLBound, median_K, tau]=fun_corr_time2(K,cp)
%K=log(K);
dim=single(size(K));
bin_level= 0:floor(log2(dim(1)));

for i=0:(max(bin_level)-1)
    NBinSeries(i+1) = floor(dim(1)/(2^i)/2) *2;
end
%bin_size=n_elem_bin_series2(1) ./n_elem_bin_series2

var_parent =  var(K,0,1);                %variance of parant series

tau=single(zeros(max(bin_level), dim(2)));
LogKbin_mean=single(zeros(max(bin_level), dim(2)));

for j=0:max(bin_level)-1
    K_bin=K(1:NBinSeries(j+1),:);                  % k binned series at zeroth level
    LogKbin_mean(j+1,:)=mean(K_bin);
    for i=1:max(bin_level)-1-j
        dim_k_bin = size(K_bin);
        N= 2*floor(dim_k_bin(1)/2) ;
        K_bin = 0.5*(K_bin(1:2:N,:) + K_bin(2:2:N,:));       % k binned series at ith level
        
    end
    nB_min=size(K_bin,1);                                                   %number of elemens in last or minimun bin
    BS_max= NBinSeries(j+1)/nB_min;                                               %bin size of last bin
    var_last = var(K_bin,0,1);
    tau(j+1,:)= BS_max*(var_last./var_parent)/2;
end

err=single(zeros(size(tau)));
for i=1:size(tau,1)
    err(i,:) = sqrt((1/dim(1))*(1+2*tau(i,:)).*var_parent);
end
err(isnan(err))=0;
tau(isnan(tau))=0;
%to ignore the elements of K which are before acquiring equilibrium in
%simulation

K=K(NBinSeries(cp):end,:);
Kasc=sort(K);
dim=size(K);
Ncenter=(dim(1)+1)/2;
median_K=(Kasc(floor(Ncenter),:)+Kasc(round(Ncenter),:))/2;
nQ1=round(Ncenter)/2;
Q1=(Kasc(floor(nQ1),:)+Kasc(round(nQ1),:))/2;  %first quartile
nQ3=dim(1)-(nQ1-1);
Q3=(Kasc(floor(nQ3),:)+Kasc(round(nQ3),:))/2;  %third quartile

KUBound=Q3;      % upper bound for median of K
KLBound=Q1;       % lower bound for median of K

end
