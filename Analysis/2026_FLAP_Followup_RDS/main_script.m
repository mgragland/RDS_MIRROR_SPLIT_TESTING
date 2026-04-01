% For group level analysis 
directoryPath=['C:\Users\raglandm\Desktop\RDS DATA\FLAP_DATA\data']
savefigures=['C:\Users\raglandm\Desktop\RDS DATA\FLAP_DATA\FIGURES']

if ~exist("savefigures", 'dir')
    mkdir(savefigures);
end


% Initialize
% Get a list of all files in the directory
fileList = dir(directoryPath);
% Filter out hidden files
fileList = fileList(~startsWith({fileList.name}, '.'));
group=1; %yes= 1 and no= 2
Accuracy=cell(2,length(fileList));

% Central vs Peripheral Y Fixation 
fixation_y=[720, 499]; % central vs peripheral


% Loop through each file in the directory
for i = 1:length(fileList)
    count=count+1;
    % Check if the current item is a file (not a folder)
    if ~fileList(i).isdir
        % Get the full path of the file
        filePath = fullfile(directoryPath, fileList(i).name);
        fprintf('Processing file: %s\n', filePath);
        load(filePath)

        % Determine Accuracy of Trials
        [Accuracy_Anti,Accuracy_Corr]=individual_analysis(filePath, count, savefigures, fixation_y)
        Accuracy{2,i}=Accuracy_Anti;
        Accuracy{1,i}=Accuracy_Corr;


        % Determine reaction times for trials
        rt_lowervisualfield(filePath, count, savefigures, fixation_y);
    end
end

if group==1
    groupanalysis(Accuracy, lowervis, uppervis, multiple_sessions, savefigures)
end