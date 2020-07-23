function writedata_simLBD(simulated_LBD,fname)  

sim_LBD=simulated_LBD*10^6;
str = ['OUTPUT',filesep,'PERMEABILITY_',fname ];
fileID = fopen(str,'w');
fprintf(fileID,'%16s \n', 'LBD_sim_maxphi (micro m)');

for jj=1:length(sim_LBD)
    fprintf(fileID, '%16.10f \n', sim_LBD(jj));
end
fclose(fileID);

end