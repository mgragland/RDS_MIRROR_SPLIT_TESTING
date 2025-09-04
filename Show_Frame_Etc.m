  function FixationFrame_OnsetTime= Show_Frame_Etc(Window_ID, Frame_pointer, Text_Info, ...
            Last_ScreenFlipTime,  Ongoing_Frame_DisplayDuration_Desired, FrameInterval_in_Second)
        
        advanceframe_ratio = 0.5;
        for LeftOrRight = 1:2
            Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
            Screen('DrawTexture', Window_ID, Frame_pointer{LeftOrRight});
            if  Text_Info.ShowText ==1
                Text_Info_Details = Text_Info.Text_Info_Details;
                number_of_txtstrings = length(Text_Info_Details);
                [width, height] = Screen('WindowSize', Window_ID);
                for n = 1:number_of_txtstrings
                    this_Text = Text_Info_Details{n};
                    txt = this_Text.txt;
                    if length(txt)>0
                        DrawFormattedText(Window_ID, txt, ...
                            this_Text.xy_in_Pixel(1), this_Text.xy_in_Pixel(2), Text_Info.TextColor);
                    end
                end
            end
        end
        if Ongoing_Frame_DisplayDuration_Desired ==0
            FixationFrame_OnsetTime  = Screen('Flip', Window_ID);
        else
            FixationFrame_OnsetTime  = Screen('Flip', Window_ID, ...
                Last_ScreenFlipTime  +  Ongoing_Frame_DisplayDuration_Desired - advanceframe_ratio*FrameInterval_in_Second);
        end
        
  end