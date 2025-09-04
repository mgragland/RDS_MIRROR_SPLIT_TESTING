function Do_Depth_Screening(design, SetUp_Info)

Window_ID = SetUp_Info.Window_ID;
BlackColor = SetUp_Info.BlackColor;
Window_Width = SetUp_Info.Window_rectangle(3);
Window_Height = SetUp_Info.Window_rectangle(4);




Give_test = 1;
while Give_test ==1
    
    Word_list = {'Here'  'Where'  'There'};
    debug_word_list= {'DOG' 'CAT'};
    location_xy = [0.2, 0.3;  0.3, 0.5;  0.4, 0.7];
    Depth_Sign_list  = [0, 1, -1];
    for LeftOrRight =1:2
        Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
        Screen('TextSize', SetUp_Info.Window_ID, design.Text_FontSize);
        DrawFormattedText(Window_ID, 'Please tell me which word --- here, where, and there ---  is nearest and farther from you', 0.1* Window_Width, 0.1*Window_Height, BlackColor);
        DrawFormattedText(Window_ID, 'enter left arrow key to do another round of test, press right arrow key to finish this test and proceed', 0.1* Window_Width, 0.9*Window_Height, BlackColor);
        Screen('TextSize', SetUp_Info.Window_ID, 6*design.Text_FontSize);
        if LeftOrRight ==1
            for i = 1:3
                DrawFormattedText(Window_ID, Word_list{i}, location_xy(i, 1)* Window_Width, location_xy(i,2)*Window_Height, BlackColor);
            end
        else
            Depth_Sign_list = Depth_Sign_list(randperm(3));
            for i = 1:3
                DrawFormattedText(Window_ID, Word_list{i}, location_xy(i, 1)* Window_Width + 3*Depth_Sign_list(i)*design.Depth_Magnitudes_in_Pixel, location_xy(i,2)*Window_Height, BlackColor);
                fprintf(Word_list{i})
                Depth_Sign_list(i)
            end
        end
    end
    Screen('DrawingFinished', Window_ID,2);
    Screen('Flip', Window_ID);
    GoForward_Or_Backward = Wait_For_RightOrLeftArrowKey(design); 
    if GoForward_Or_Backward ==1
        Give_test = 0;
    end
end
%--- return back to the normal size
Screen('TextSize', SetUp_Info.Window_ID, design.Text_FontSize);
