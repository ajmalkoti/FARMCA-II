function setup_code(pwd)
% SETUP_CODE
% The code check for the input and outpur directories.
% 

% Check for input directory
str = [pwd,filesep,'INPUT'];
if ~exist(str,'dir')
    error('Input directory does not exists.')
end


% Create the output directory 
str = [pwd,filesep,'OUTPUT'];
if ~exist(str, 'dir')
mkdir(str);
end



end