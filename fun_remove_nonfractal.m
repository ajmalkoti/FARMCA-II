function [BLx,BP2,IdxRep2] = fun_remove_nonfractal(BLx,BP, IdxRep)
% This function removes all the values which represent non fractal nature
% i.e. for which BLx.LambdaRatioCheck=0

BP2=BP;
IdxRep2 = IdxRep;

IdxRep2.fract3 = find(BLx.LambdaRatioCheck==0);
BLx.SandRadEff(IdxRep2.fract3) = [];
BLx.Area(IdxRep2.fract3) = [];
BLx.LambdaRatio(IdxRep2.fract3) = [];
BLx.LambdaMax(IdxRep2.fract3) = [];
BLx.LambdaMin(IdxRep2.fract3) = [];
BLx.LambdaRatioCheck(IdxRep2.fract3) = [];
BLx.Df(IdxRep2.fract3) = [];
BLx.Nt(IdxRep2.fract3) = [];

BP2.PhiE(IdxRep2.fract3) = []; 
BP2.PhiU(IdxRep2.fract3) = []; 
BP2.PhiC(IdxRep2.fract3) = []; 
BP2.VSst(IdxRep2.fract3) = []; 
BP2.VSh(IdxRep2.fract3) = []; 
BP2.Depth(IdxRep2.fract3) = []; 


% Returns the index of all unique elements based upon LambdaMax
% Simulation wll run only for unique elements 
[IdxRep2.LbdUniVal, IdxRep2.LbdUniIdx, IdxRep2.LbdUniCol] = unique(BLx.LambdaMax); 
end