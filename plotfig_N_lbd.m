function plotfig_N_lbd(SimLBD,strname)

a1=min(SimLBD*10^6);                % AJ: is it possible to obtain simlbd in correct unit from the function??
a2=max(SimLBD*10^6);
a=a1:0.1:a2;

NLM=zeros(length(a),1);
for l=1:length(a)
    n=find(SimLBD*10^6>=a(l));
    N=length(n);
    NLM(l,1)=N;
end


X=log(a');
Y=log(NLM);

X1=X; Y1=Y;
n=find(diff(Y1)==0); X1(n)=[]; Y1(n)=[]; 
C=polyfit(X1,Y1,1); Y1=polyval(C,X1);

% Figure 3
figure ();
plot(X,Y,'b*',X1,Y1,'r-')
xlabel('ln(lamda)')
ylabel('ln(N)')
annotation('textbox', [.6 .6 .1 .1], 'String', ...
                    ['Df=',num2str(abs(C(1)))]);
title('power law distribution of pore diameters')


str= ['OUTPUT', filesep,strname]; 
print( gcf, str, '-djpeg','-r300' )

savefig(gcf, str )

end