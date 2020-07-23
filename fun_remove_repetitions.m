function [BL2,index]= fun_remove_repetitions(BL,PFract)
%FUN_REMOVE_REPETITIONS
% This function permforms two tasks : 
%  1) Removes the cases phiU < PhiShale, permeability will not be computed.
%  2) Removes the layers with same PhiU (in given block only). 
%     All these layers will be assigned same phiU value.
%
% Index.shale: the index of values for phiU < PhiShale
% Index.block: the index of values containing double values.

%% % The permeability is not computed for the cases where porosity is too low. 
%    The thereshold is defined by PFract.PhiShale.

BL2 = BL;
index.shale1 = single(find(BL2.PhiU <= PFract.PhiShale));     

BL2.Depth(index.shale1)=  [];
BL2.PhiU(index.shale1) =  [];   
BL2.PhiE(index.shale1) =  [];   
BL2.PhiC(index.shale1) =  [];   
BL2.VSst(index.shale1) =  [];
BL2.VSh(index.shale1)  =  [];


%% % Removes the layers which have same PhiU
N= length(BL2.PhiU);
index.block2 = zeros(N,1); 

i=1;  
index.block2(i) = 1;


for i = 2:N
    if BL2.PhiU(i)==BL2.PhiU(i-1)
        BL2.Depth(i)=0;        
        index.block2(i) = index.block2(i-1); 
    else
        index.block2(i) = i;
    end
end


index.block2=find(BL2.Depth==0);
BL2.Depth(index.block2)=[];
BL2.PhiU(index.block2)=[];
BL2.VSst(index.block2)=[];
BL2.VSh(index.block2)=[];
BL2.PhiE(index.block2)=[];
BL2.PhiC(index.block2)=[];





end
