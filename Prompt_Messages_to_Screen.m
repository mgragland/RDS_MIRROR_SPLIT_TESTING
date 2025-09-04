function   Prompt_Messages_to_Screen(design, SetUp_Info,  Instruction)

Window_ID = SetUp_Info.Window_ID;
BlackColor = SetUp_Info.BlackColor;
Window_Width = SetUp_Info.Window_rectangle(3);
Window_Height = SetUp_Info.Window_rectangle(4);

for LeftOrRight = 1:2
    Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
    for j = 1:length(Instruction)
        DrawFormattedText(Window_ID, Instruction(j).txt, ...
            Instruction(j).xy(1)*Window_Width, Instruction(j).xy(2)*Window_Height, BlackColor);
    end
end
Screen('DrawingFinished', Window_ID,2);
Screen('Flip', Window_ID);

