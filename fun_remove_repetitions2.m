function [BL2]= fun_remove_repetitions(BL,PFract, PlotON)
%FUN_REMOVE_REPETITIONS
% This function removes the layers which have same PhiU 
% This is the improved version of the manual (AJ)

temp = BL;
% select useful porosity
index = single(find(BL.PhiU <= PFract.PhiShale));     % program will run for these indices

temp.Depth(index)=  [];
temp.PhiU(index) =  [];   % any unique value
temp.PhiE(index) =  [];   % any unique value
temp.PhiC(index) =  [];   % any unique value
temp.VSst(index)=  [];
temp.VSh(index)=   [];


BL2=temp;
% select 
[BL2.PhiU, BL2.iA, BL2.iC] = unique(temp.PhiU,'stable'); 
BL2.Depth = temp.Depth(BL2.iA);
BL2.PhiU  = temp.PhiU(BL2.iA);
BL2.PhiE  = temp.PhiE(BL2.iA);
BL2.PhiC  = temp.PhiC(BL2.iA);
BL2.VSst  = temp.VSst(BL2.iA);
BL2.VSh   = temp.VSh(BL2.iA);

if ~isempty(PlotON)
   plotfig_removed_repetitions(BP,BP2); 
end

end




% a = [9 9 9 9 9 9 8 8 8 8 7 7 7 6 6 6 5 5 4 2 1];
% [c1,ia1,ic1] = unique(a);
% returns
% c1 = [1 2 4 5 6 7 8 9]
% ia1 = [21 20 19 17 14 11 7 1]'
% ic1 = [8 8 8 8 8 8 7 7 7 7 6 6 6 5 5 5 4 4 3 2 1]'


% [c1,ia1,ic1] = unique(a,'stable');
% returns
% c1 = [9 8 7 6 5 4 2 1]
% ia1 = [1 7  11  14  17  19  20  21]
% ic1 = [1 1 1 1 1 1 2 2 2 2 3 3 3  4 4 4 5 5 6 7 8]