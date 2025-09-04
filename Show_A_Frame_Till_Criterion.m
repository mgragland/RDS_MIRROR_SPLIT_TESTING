function [ThisFrame_OnsetTime, Response, EyeData] = ...
    Show_A_Frame_Till_Criterion(SetUp_Info, design, Frame_pointer, Text_Info, Last_ScreenFlipTime, Ongoing_Frame_DisplayDuration_Desired, Criterion,  practice_or_test)

Window_ID = SetUp_Info.Window_ID;
Text_Info.TextColor = SetUp_Info.BlackColor;
count=0; 

%%% ---- show the fixation frame after Ongoing_Frame_DisplayDuration_Desired if desired ---
ThisFrame_OnsetTime = Show_Frame_Etc(Window_ID, Frame_pointer, Text_Info, ...
    Last_ScreenFlipTime,  Ongoing_Frame_DisplayDuration_Desired, SetUp_Info.FrameInterval_in_Second);

%%%
%%%%%%---- Terminate the displayed frame after criterion is met
if strcmp(Criterion.txt, 'Any button response') ==1   
    if strcmp(design.Response_Buttons.Type, 'Keyboard')
        TakeKbCheck;
        Buttons= KbName(keyCode);
        Response=Buttons; 
        EyeData=[];
    elseif strcmp(design.Response_Buttons.Type, 'ResponseBox')
        moveon=0;
        while moveon==0;
            Datapixx('Flush')
            Datapixx('RegWrRd');
            [keyValue, keyTime]= Datapixx('ReadDinLog');
            if keyValue==65519;
                moveon=1;
            end
        end
        Response=keyValue;
        EyeData=[];
    end
 
elseif strcmp(Criterion.txt, 'Task button response') ==1
    %disp(Criterion.ValidButtons);
    Not_yet = 1;
    Response = [];
    while Not_yet ==1
        [This_Response, EyeData]=Take_SubjectResponse(design, practice_or_test);
        Response = [Response, This_Response];
        %disp(Response.Button_Characters);
        fs = 5000; t = 0:0.00002:0.02;
        LowToneSoundwave =  sin(2*pi*fs/2*t);
        HighToneSoundwave = sin(2*pi*fs*2*t);
        if ismember(This_Response.Button_Characters, Criterion.ValidButtons) ==1
            Not_yet =0;
            sound(LowToneSoundwave, fs);
        else
            %--- give a warning beep and show a warning text to display.
            sound(HighToneSoundwave, fs);
            sound(HighToneSoundwave, fs);
            number_of_txtstrings = length(Text_Info.Text_Info_Details);
            New_Text_Info = Text_Info;
            for i = 1:length(design.WrongButtonPrompt)
                New_Text_Info.Text_Info_Details{number_of_txtstrings+i} = design.WrongButtonPrompt{i};
                New_Text_Info.Text_Info_Details{number_of_txtstrings+i}.xy_in_Pixel = ...
                    New_Text_Info.Text_Info_Details{number_of_txtstrings+i}.xy_in_Pixel + design.Reference_Display_location_xy_in_Pixel;
            end
            WarningFrame_OnsetTime = Show_Frame_Etc(Window_ID, Frame_pointer, New_Text_Info, ...
                0, 0, 0); %--- all it matters to Show_Frame_Etc is that the second 0 is 0, so it flips right away.
        end
    end
elseif  strcmp(Criterion.txt, 'Gaze contingent') ==1
    count=count+1;
    if count==1
        EyeTracker_Gaze_Contingent_Data.xeye={};
        EyeTracker_Gaze_Contingent_Data.yeye={};
        EyeTracker_Gaze_Contingent_Data.fixating={};
        EyeTracker_Gaze_Contingent_Data.reye={};
    end
    EyeTracker_Gaze_Contingent_Data = Check_For_Gaze_Contingency(SetUp_Info,  Criterion, design,EyeTracker_Gaze_Contingent_Data,  practice_or_test);
    Response = EyeTracker_Gaze_Contingent_Data;
    EyeData=[];
else
    Response = [];
    EyeData=[];
end

FixationFrame_OnsetTime= Show_Frame_Etc(Window_ID, Frame_pointer, Text_Info, ...
    Last_ScreenFlipTime,  Ongoing_Frame_DisplayDuration_Desired, SetUp_Info.FrameInterval_in_Second);
%
%         advanceframe_ratio = 0.5;
%         for LeftOrRight = 1:2
%             Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
%             Screen('DrawTexture', Window_ID, Frame_pointer{LeftOrRight});
%             if  Text_Info.ShowText ==1
%                 Text_Info_Details = Text_Info.Text_Info_Details;
%                 number_of_txtstrings = length(Text_Info_Details);
%                 [width, height] = Screen('WindowSize', Window_ID);
%                 for n = 1:number_of_txtstrings
%                     this_Text = Text_Info_Details{n};
%                     txt = this_Text.txt;
%                     if length(txt)>0
%                         DrawFormattedText(Window_ID, txt, ...
%                             this_Text.xy_in_Pixel(1), this_Text.xy_in_Pixel(2), Text_Info.TextColor);
%                     end
%                 end
%             end
%         end
%         if Ongoing_Frame_DisplayDuration_Desired ==0
%             FixationFrame_OnsetTime  = Screen('Flip', Window_ID);
%         else
%             FixationFrame_OnsetTime  = Screen('Flip', Window_ID, ...
%                 Last_ScreenFlipTime  +  Ongoing_Frame_DisplayDuration_Desired - advanceframe_ratio*FrameInterval_in_Second);
%         end
%
%     end
end
