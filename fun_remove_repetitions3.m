function [BL2,index]= fun_remove_repetitions(BL,PFract)
%FUN_REMOVE_REPETITIONS
% This function removes the layers which have same PhiU

BL2=BL;
% blockwise values unique values
% for i=1:length(BL.PhiU)-1
%     if BL.PhiU(i)==BL.PhiU(i+1)
%         BL2.Depth(i+1)=0;        
%     end
% end

index.block1 = zeros(length(BL.PhiU),1); 
i=1;  index.block1(i) = 1;
for i=2:length(BL.PhiU)
    if BL.PhiU(i)==BL.PhiU(i-1)
        BL2.Depth(i)=0;        
        index.block1(i) = index.block1(i-1); 
    else
        index.block1(i) = i;
    end
end

index.block1=find(BL2.Depth==0);
BL2.Depth(index.block1)=[];
BL2.PhiU(index.block1)=[];
BL2.VSst(index.block1)=[];
BL2.VSh(index.block1)=[];
BL2.PhiE(index.block1)=[];
BL2.PhiC(index.block1)=[];





index.sand = single(find(BL2.PhiU <= PFract.PhiShale));     % program will run for these indices

BL2.Depth(index.sand)=  [];
BL2.PhiU(index.sand) =  [];   
BL2.PhiE(index.sand) =  [];   
BL2.PhiC(index.sand) =  [];   
BL2.VSst(index.sand) =  [];
BL2.VSh(index.sand)  =  [];



end
