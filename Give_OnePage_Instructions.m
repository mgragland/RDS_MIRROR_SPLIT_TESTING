function  Goto_Next_or_PreviousPage= Give_OnePage_Instructions(design, SetUp_Info,  condition, DepthOrder, Instruction, Have_Image_Sound_Or_Nothing)

Window_ID = SetUp_Info.Window_ID;
BlackColor = SetUp_Info.BlackColor;
Window_Width = SetUp_Info.Window_rectangle(3);
Window_Height = SetUp_Info.Window_rectangle(4);

if Have_Image_Sound_Or_Nothing ==1
    [StereoInputFrames, StimulusInfo,  fixationFrame_pt] = ...
        Get_StereoInputFrames_StimulusInfo_Etc(design, SetUp_Info, condition, DepthOrder);
end
frame = 1;
i =1;
while i >=1 & i<=length(Instruction)
    for LeftOrRight = 1:2
        Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
        if Have_Image_Sound_Or_Nothing==1
            This_MonocularFrame = StereoInputFrames{frame,LeftOrRight};
            TestStimulusFrame_pt{LeftOrRight} =Screen('MakeTexture', Window_ID, This_MonocularFrame);
            Screen('DrawTexture', Window_ID, TestStimulusFrame_pt{LeftOrRight});
        end
        for j = 1:i
            DrawFormattedText(Window_ID, Instruction(j).txt, ...
                Instruction(j).xy(1)*Window_Width, Instruction(j).xy(2)*Window_Height, BlackColor);
        end
    end
    Screen('DrawingFinished', Window_ID,2);
    Screen('Flip', Window_ID);
    GoForward_Or_Backward = Wait_For_RightOrLeftArrowKey(design);
    i  = i+GoForward_Or_Backward;
    %R=input('enter to continue to the next instruction sentence, or go to the next step', 's');
end
if i ==0
    Goto_Next_or_PreviousPage = -1;
else
    Goto_Next_or_PreviousPage = 1;
end
