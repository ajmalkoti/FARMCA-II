function writedata_final()

fileID = fopen('OUTPUT/perm_AW_err.txt','w');
fprintf(fileID,'%4s \n', 'K1.err');
for iii=1:size(K1.err,1)
    for ijj=1:length(BL.PhiU)
        fprintf(fileID, '%4.2f ', K1.err(iii,ijj));
    end
    fprintf(fileID, '\n');
end
fclose(fileID);


fileID = fopen('OUTPUT/perm_phi_perm_fract_dims_AW.txt','w');
fprintf(fileID,'%10s %4s %4s %4s %10s %10s %10s %6s %3s %3s %9s \n', 'BI.Depth', 'BI.PhiU', 'BI.VSh', 'BI.VSST', 'K1.median', 'K1.UB', 'K1.LB', 'radius.eff', 'Df', 'Dt', 'LBD.ratio');
for jp=1:length(BL.Depth)
    fprintf(fileID, '%10.5f \t %4.2f \t %4.2f \t %4.2f \t %10.0f \t %10.0f \t %10.0f \t %6.3f \t %3.2f \t %3.2f \t %9.8f \n', ...
        BL.Depth(jp), BL.PhiU(jp), BL.VSh(jp), BL.VSST(jp), K1.median(jp), K1.UB(jp), K1.LB(jp), radius.eff(jp), Df(jp), Dt(jp), LBD.ratio(jp));
end
fclose(fileID);

fileID = fopen('OUTPUT/perm_zone_AW.txt','w');
fprintf(fileID,'%10s %4s %6s %5s %4s %5s %5s \n', 'BL2.Depth', 'BL2.PhiU', 'Reff', 'Kcalc', 'error', 'KUBound', 'KLBound');
for jz=1:length(BP2.Depth)
    fprintf(fileID, '%10.5f \t %4.2f \t %6.3f \t %5.0f \t %4.2f \t %5.0f \t %5.0f \t \n', ...  %%%modified
        BP2.Depth(jz), BP2.PhiU(jz), Reff(jz), Kcalc(jz), error(jz), KUBound(jz), KLBound(jz));
end
fclose(fileID);


fileID = fopen('OUTPUT/perm_blockedlogAW.txt','w');
fprintf(fileID,'%10s %5s \n', 'BL.Depth', 'BL.K');
for jb=1:length(BP.Depth)
    fprintf(fileID, '%10.5f \t %5.0f \t \n', BP.Depth(jb), BP.K(jb));
end
fclose(fileID);