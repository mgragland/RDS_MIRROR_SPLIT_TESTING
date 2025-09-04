
function [Testing_Trial_Data, Testing_Accuracies] = Do_Testing_Trials(design, SetUp_Info,  practice_or_test)


%--- remind or clarify the task again if there was no instruction or no practice trials
txt_add = sprintf('. *** In each trial, press %s to report disk in front, and press %s to report disk behind', ...
                design.Response_Buttons.keyName{1}, design.Response_Buttons.keyName{2});
design.Message_BeforeTestingTrials(1).txt = [design.Message_BeforeTestingTrials(1).txt, txt_add];

Prompt_Messages_to_Screen(design, SetUp_Info, design.Message_BeforeTestingTrials);
Wait_For_RightArrowKey;



%
Testing_Trial_Data  = Do_TrialSequence(design.Testing_TrialSequence, design, SetUp_Info,  practice_or_test);
%
[Testing_Accuracies, N_Trials] = Plot_Accuracies(Testing_Trial_Data, design, SetUp_Info.Debug_Or_Whole_Screen);
%
Write_txt_to_display(SetUp_Info.Window_ID, 'Testing trials finished, Thank you,     --- Enter RightArrow to close screen',  ...
    0.1,  0.5, design.Text_Color);

Wait_For_RightArrowKey;
	

