function  GiveInstructions(design, SetUp_Info, Instruction_Pages_Info, practice_or_test)
pause(0.5);
Window_ID = SetUp_Info.Window_ID;
BlackColor = SetUp_Info.BlackColor;
Window_Width = SetUp_Info.Window_rectangle(3);
Window_Height = SetUp_Info.Window_rectangle(4);


Start_Instructions = 1;
while Start_Instructions ==1
    for LeftOrRight =1:2
        Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
        Screen('TextSize', SetUp_Info.Window_ID, design.Text_FontSize);
        DrawFormattedText(Window_ID, 'Next are the instructions for this data taking session', ...
						0.1* Window_Width, 0.1*Window_Height, design.Text_Color);
        DrawFormattedText(Window_ID, 'Enter the Right Arrow key to proceed from one instruction sentence/page to the next', ...
					 0.1* Window_Width, 0.2*Window_Height, design.Text_Color);
        
        DrawFormattedText(Window_ID, 'and enter the Left Arrow key to go back to the previous sentence or instruction page ', ...
				0.1* Window_Width, 0.25*Window_Height, design.Text_Color);
        DrawFormattedText(Window_ID, 'enter Right Arrow key to proceed', 0.1* Window_Width, 0.5*Window_Height, design.Text_Color);
    end
    Screen('DrawingFinished', Window_ID,2);
    Screen('Flip', Window_ID);
    
    Wait_For_RightArrowKey;
    
    %
    p = 1;
    while p >=1 & p <= length(Instruction_Pages_Info)
	disp(sprintf('showing %d-th page of instructions',p));
        Goto_Next_or_PreviousPage = Do_A_Instruction_Page(design, SetUp_Info, Instruction_Pages_Info{p}, practice_or_test);
        p = p+Goto_Next_or_PreviousPage;
    end
    if p ==0
        Start_Instructions =1;
    else
        Start_Instructions =0;
    end
end


