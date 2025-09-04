
filename = input('enter the file name of the data file:   ', 's');

load(filename);

design.GazeTracking_Or_Not=0;
design.GazeContingent_Or_Not=0;

Debug_Or_Whole_Screen=1;

 Plot_Accuracies(Practice_Trial_Data, design,  Debug_Or_Whole_Screen);
 Plot_Accuracies(Testing_Trial_Data, design, Debug_Or_Whole_Screen);

try
    New_SetUp_Info = initializePtbStereo(SetUp_Info.Debug_Or_Whole_Screen, ...
		SetUp_Info.Viewing_Distance_in_mm, SetUp_Info.Stereo_Color_Gain_Vectors, design);
    
    disp('checking whether the display is the same');
    if isequal(New_SetUp_Info.ScreenResolution,  SetUp_Info.ScreenResolution) ~=1 | ...
		abs(SetUp_Info.FrameInterval_in_Second -New_SetUp_Info.FrameInterval_in_Second)>0.0001
        disp('The set up is not the same as the original one in resolution and/or frame rate,  need to find the same display to replay');
        error('exiting');
    end
    disp('checking completed');
    
    SetUp_Info = New_SetUp_Info;
    Screen('TextSize', SetUp_Info.Window_ID, design.Text_FontSize);
    
    Replay_Or_Examine = input('enter 1 or 2 for replay or reamine the trials');	
    %Do_Depth_Screening(design, SetUp_Info);
    %---- skip instructions and eye tracking, just replay the practice and testing trials.
    Write_txt_to_display(SetUp_Info.Window_ID, 'Enter RightArrow to replay the practice trials',  ...
        0.1,  0.5, design.Text_Color);
    Wait_For_RightArrowKey;
    Replay_Or_Examine_Trials(design, SetUp_Info, Practice_Trial_Data, Replay_Or_Examine);
    %
    Write_txt_to_display(SetUp_Info.Window_ID, 'Enter RightArrow to replay the testing trials',  ...
        0.1,  0.5, design.Text_Color);
    Wait_For_RightArrowKey;
    Replay_Or_Examine_Trials(design, SetUp_Info, Testing_Trial_Data, Replay_Or_Examine);
    
    Write_txt_to_display(SetUp_Info.Window_ID, 'Testing trials replay finished,  Enter RightArrow to close screen',  ...
        0.1,  0.5, design.Text_Color);
    Wait_For_RightArrowKey;
    FlushEvents;
    FlushEvents;
    Screen('CloseAll')
    ShowCursor;
    ListenChar(0); %--- let matlab listen to keyboard presses
catch
    Screen('CloseAll')
    ListenChar(0); %--- let matlab listen to keyboard presses
    disp('An error occurred:');
    disp(exception.message);
    R=input('you should terminate the program and fix the problem, enter to continue');
end


