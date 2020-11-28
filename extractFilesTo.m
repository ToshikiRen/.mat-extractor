function [completeDestinationPath] = extractFilesTo(sourceFolderPath, destination, folderName)

%       Input arguments:
%                       sourceFolderPath = the folder containing all the
%                                          individual submission files
%                       destination = the folder we're we want to create
%                                     the subfolder that will store the .mat
%                                     files and the errorReport file
%                       folderName = the name of the folder we'll be
%                                    creating to store all the *.mat files
%       Output arguments:
%                       completeDestinationPath = the path to the folder
%                                         containing all the *.mat files
%
%       Created By: Leonard-Gabriel Necula
%       Date: 27.11.2020

% Check user inputs
if ( nargin < 1 )
    disp('Please specify the source folder');
    return;
end
if (isempty(sourceFolderPath))
    disp('Please specify the source folder');
    return;
end
if ( nargin < 2 )
    disp('Please specify the destination next time');
    return;
end
if (isempty(destination))
    disp('If the folder name will be validated it will be created in the CWD');
end
if ( nargin < 3 )
    disp('Please specify the folder name next time');
    disp('This time we created a folder for you at the specified destination!');
    folderName = 'Dumbo';
end
if (isempty(folderName))
    disp('Please specify a valid folder name');
    return;
end

% Open error report file in write mode
errorReportPath = fullfile(destination, 'Error_Report.txt');
errorReport = fopen(errorReportPath,'w');

% Path to destination folder
completeDestinationPath = fullfile(destination, folderName);
folderCheck = dir(completeDestinationPath);
% Check if the folder already exists
if ( ~size(folderCheck, 1) )
   mkdir(completeDestinationPath); 
end

% Get the folders from the specified path
folders = dir(sourceFolderPath);

for i = 1:numel(folders)
    
    % Check if the folder name it's not an artifact
    if (numel(folders(i).name) > 10)
        
        % Construct path to the i_th folder
        folder = folders(i).name;
        pathToFile = fullfile(sourceFolderPath, folder);
        
        % Try to acces .mat file 
        checkDotMat = dir(fullfile(pathToFile, '*.mat'));
        if (~numel(checkDotMat))
            fprintf(errorReport, 'No *.mat found in %s folder \n', folder);
        else
            % Get the first *.mat in the submission
            matName = checkDotMat(1).name;
            pathToMat = fullfile(pathToFile, matName);

            copyfile(pathToMat, completeDestinationPath);
        end

    end
end

end


