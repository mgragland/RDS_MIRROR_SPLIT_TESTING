directoryPath='C:\Users\raglandm\Desktop\RDS DATA\Reliability Data\CJT';
% Get a list of all files in the directory
fileList = dir(directoryPath);
% Filter out hidden files
fileList = fileList(~startsWith({fileList.name}, '.'));
lowervis=1; %1= inferior 2=L/R peripheral 
uppervis=0;
count=0;
multiple_sessions=1; % yes=1 no=0 


% Loop through each file in the directory
for i = 1:length(fileList)
    count=count+1;
    if i==1;
        Accuracy=cell(2,length(fileList))
    end
    % Check if the current item is a file (not a folder)
    if ~fileList(i).isdir
        % Get the full path of the file
        filePath = fullfile(directoryPath, fileList(i).name);
        fprintf('Processing file: %s\n', filePath);
        load(filePath)

        % Determine Accuracy of Trials 
        if lowervis==1;
            [Accuracy_Anti,Accuracy_Corr]=lowervisualfield(filePath, count)
            Accuracy{2,i}=Accuracy_Anti;
            Accuracy{1,i}=Accuracy_Corr;
        elseif uppervis==1;
            [Accuracy_Anti,Accuracy_Corr]=uppervisualfield(filePath, count)
            Accuracy{2,i}=Accuracy_Anti;
            Accuracy{1,i}=Accuracy_Corr;
        elseif lowervis==2;
            [Accuracy_Anti,Accuracy_Corr, Accuracy_Table,SignalDetect_Table]=lower_peripheralvisualfield(filePath, count)
            Accuracy{2,i}=Accuracy_Anti;
            Accuracy{1,i}=Accuracy_Corr;
        else
            [Accuracy]=MGR_graphresults(filePath, count, fileList, Accuracy)
        end

        % Determine reaction times for trials 
        rt_lowervisualfield(filePath, count)
    end
end

groupanalysis(Accuracy, lowervis, uppervis, multiple_sessions)


