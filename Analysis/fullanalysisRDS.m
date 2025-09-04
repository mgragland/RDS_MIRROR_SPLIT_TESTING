directoryPath= 'C:\Users\raglandm\Desktop\Data';
% Get a list of all files in the directory
fileList = dir(directoryPath);
% Filter out hidden files
fileList = fileList(~startsWith({fileList.name}, '.'));
lowervis=1; %1= inferior 2=L/R peripehral 
uppervis=0;
count=0;


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
    end
end

groupanalysis(Accuracy, lowervis, uppervis)


