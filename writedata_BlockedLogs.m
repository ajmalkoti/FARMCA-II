function writedata_BlockedLogs(BL,fname)

str = ['OUTPUT/PHI_',fname];
fileID = fopen(str, 'w');
fprintf(fileID,'%10s %4s %4s %4s %4s %4s \n', 'BL.Depth', 'BL.VSh', 'BL.VSSt', 'BL.PhiE', 'BL.PhiC','BL.PhiU');

for jk=1:length(BL.Depth)
    fprintf(fileID, '%10.5f \t %4.2f \t %4.2f \t %4.2f \t %4.2f \t %4.2f \t \n', BL.Depth(jk), BL.VSh(jk),BL.VSst(jk),BL.PhiE(jk), BL.PhiC(jk),BL.PhiU(jk));
end

fclose(fileID);

end