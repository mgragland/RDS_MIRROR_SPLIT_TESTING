
function  [All_Responses, FixationFrame_OnsetTimes, lastvbl]= ...
    Start_and_FixationFrames_In_ATrial(design, SetUp_Info, fixationFrame_pointer, x_fixation, y_fixation,  ...
    					Previous_FrameDuration_Desired, Do_Or_Replay_ATrial, lastvbl, practice_or_test)

GazeContingent_Or_Not=design.GazeContingent_Or_Not;

if Do_Or_Replay_ATrial ==1
    Frame_Criterion_txt{1} = 'Any button response';
    Frame_Criterion_txt{2} = 'Nothing';
else
    Frame_Criterion_txt{1} = 'Nothing';
    Frame_Criterion_txt{2} = 'Nothing';
    
    GazeContingent_Or_Not=0;
end

FixationFrame_OnsetTimes =[];
for frame = 1:2
    Ongoing_Frame_DisplayDuration_Desired=Previous_FrameDuration_Desired(frame);
    Criterion.txt = Frame_Criterion_txt{frame};
    if frame ==1
        Fixation_Text_Info.ShowText = 1;
        Fixation_Text_Info.Text_Info_Details = design.TrialStartPrompt;
        n_txt = length(Fixation_Text_Info.Text_Info_Details);
        for n = 1:n_txt
            Fixation_Text_Info.Text_Info_Details{n}.xy_in_Pixel = ...
                Fixation_Text_Info.Text_Info_Details{n}.xy_in_Pixel + [x_fixation, y_fixation];
        end
    else
        Fixation_Text_Info.ShowText =0;
        if GazeContingent_Or_Not ==1
            Criterion.txt = 'Gaze contingent';
            Criterion.fixation_location_xy_in_Pixel = [x_fixation, y_fixation];
            Criterion.fixation_window_radius_in_Pixel = design.Fixation_window_radius_in_Pixel;
            Criterion.fixation_minimum_durationInSecond = design.FixationPeriod_in_Second;
        end
    end
    [lastvbl, This_Response, EyeData] = ...
        Show_A_Frame_Till_Criterion(SetUp_Info, design, fixationFrame_pointer, Fixation_Text_Info, ...
        lastvbl, Ongoing_Frame_DisplayDuration_Desired, Criterion, practice_or_test);
    FixationFrame_OnsetTimes = [FixationFrame_OnsetTimes, lastvbl];
    if frame ==1
        All_Responses.Trial_Start_Response =  This_Response;
    else
        All_Responses.Fixation_Response    =   This_Response;
    end
    All_Responses.EyeData=EyeData; 
end
