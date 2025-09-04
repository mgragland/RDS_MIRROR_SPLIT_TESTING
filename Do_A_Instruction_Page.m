
function  Goto_Next_or_PreviousPage =Do_A_Instruction_Page(design, SetUp_Info, Instruction_Page_Info, practice_or_test)

Trial_Character = Instruction_Page_Info.Trial_Character;
RDS_BinocularMatchingProb_Index  = Trial_Character.RDS_BinocularMatchingProb_Index;
RDS_FrameDuration_Index  = Trial_Character.RDS_FrameDuration_Index;   
RDS_Location_Index = Trial_Character.RDS_Location_Index;
DepthOrder = Trial_Character.DepthOrder;

condition  = Get_condition(RDS_BinocularMatchingProb_Index, RDS_FrameDuration_Index, RDS_Location_Index, design);

if isfield(Trial_Character, 'Real_Prob_Noise_Anti_Parameters') ==1 & length(Trial_Character.Real_Prob_Noise_Anti_Parameters)==3
    condition.Prob_DiskDotIsSameAcrossEyes=Trial_Character.Real_Prob_Noise_Anti_Parameters(1);
    condition.Noise_Fraction = Trial_Character.Real_Prob_Noise_Anti_Parameters(2);
    condition.Anti_Fraction = Trial_Character.Real_Prob_Noise_Anti_Parameters(3);
end



if Instruction_Page_Info.Type ==1  %--- Show text with or without images
    %
    Have_Image_Sound_Or_Nothing= Instruction_Page_Info.Have_Image_Sound_Or_Nothing;
    Instruction_TextInfo = Instruction_Page_Info.Instruction_TextInfo;
    
    Goto_Next_or_PreviousPage= Give_OnePage_Instructions(design, SetUp_Info, ...
        condition, DepthOrder, Instruction_TextInfo, Have_Image_Sound_Or_Nothing);
    
elseif Instruction_Page_Info.Type ==2  %--- Do a trial
    [FixationFrame_OnsetTimes,  StimulusFrame_OnsetTimes,  All_Responses, StimulusInfo] = ...
        DoATrial(design, SetUp_Info, condition, DepthOrder, practice_or_test);
    
    Write_txt_to_display(SetUp_Info.Window_ID, 'Enter RightArrow to proceed, enter LeftArrow to go back to repeat this step', ...
        0.1, 0.5, design.Text_Color);
    Goto_Next_or_PreviousPage =  Wait_For_RightOrLeftArrowKey(design);
end












