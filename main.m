rng('shuffle');   
KbName('UnifyKeyNames');
%--- get design parameters, subject information, display information, instruction information, output file name
[Use_Default_Or_Review, Subject_Info, design, Instruction_Pages_Info, SetUp_Info] = Initialization();
try
    ListenChar(2); %--- prevent matlab listen to keyboard entries.
    
    %--- set up eye tracking if needed
    if design.GazeTracking_Or_Not ==1
        EyeTracker_Info = SetUp_EyeTracker();
        SetUp_Info.EyeTracker_Info = EyeTracker_Info    
    end                         
    % Open PTB
    startPTB(SetUp_Info)
    
    % Set up Response Box
    if strcmp(design.Response_Buttons.Type, 'ResponseBox')
        setupresponsebox
    end
    
    %---- show opening messages to the screen.
    Give_OpeningMessage(design, SetUp_Info);
 
    Do_Depth_Screening(design, SetUp_Info);
    
    %---  experiment date, time,  and file name for saving results
    day = date; clocktime = clock;
    filename_output =[Subject_Info.Name, num2str(Subject_Info.SessionNumber), '-', day, '-', num2str(clocktime(4)), '-', num2str(clocktime(5)), '.mat'];
    %--- give instruction if needed
    if design.Give_Instructions_Or_Not ==1
        practice_or_test=1;
        GiveInstructions(design, SetUp_Info, Instruction_Pages_Info, practice_or_test);
    end
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Do Practice trials if needed
    Practice_Trial_Data = [];
    if length(design.Practice_TrialSequence) >0 %--- check if there is any practice trials
        practice_or_test=1; 
        Practice_Trial_Data = Do_Practice_Trials(design, SetUp_Info, Practice_Trial_Data, practice_or_test); 
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%% do Testing trials
    practice_or_test=2; 
    [Testing_Trial_Data, Testing_Accuracies] = Do_Testing_Trials(design, SetUp_Info,  practice_or_test);
    %
    save(filename_output, 'design', 'SetUp_Info', 'Practice_Trial_Data', 'Testing_Trial_Data', 'Subject_Info', 'Instruction_Pages_Info', 'Use_Default_Or_Review');
    %
    FlushEvents;
    Screen('CloseAll')
    ShowCursor;
    ListenChar(0); %--- let matlab listen to keyboard presses
catch exception
    Screen('CloseAll')
    ListenChar(0); %--- let matlab listen to keyboard presses
    disp('An error occurred:');
    disp(exception.message);
    R=input('you should terminate the program and fix the problem, enter to continue');
end

%---- ask for any comments from the subject, and append it to Subject_Info
Subject_Info  = Get_Subject_Reports(Subject_Info);

%--- add any experimental notes
Experimenter_Notes = input('Enter any experimental notes about this session:  ', 's');

%--- save everything into the *.mat file
save(filename_output,  'Subject_Info', 'Experimenter_Notes', '-append');

%--- also output a spreadsheet of summary trial information
filename_excel =[Subject_Info.Name, num2str(Subject_Info.SessionNumber), '-', day, '-', num2str(clocktime(4)), '-', num2str(clocktime(5)), '.xls'];
Save_Summary_to_Spreadsheet(Practice_Trial_Data, Testing_Trial_Data, design, filename_excel);
