
function [FixationFrame_OnsetTimes, StimulusFrame_OnsetTimes, All_Responses, Mask_OnsetTime] =  ...
    Do_Or_Replay_GivenInfo(Do_Or_Replay_ATrial, design, SetUp_Info, condition, StimulusInfo, ...
    lastvbl,  Previous_FrameDuration_Desired, Response_Info_txt,  practice_or_test)

%%%%%%%%%%%%%%%%%%%%%%%%  Explicitly get the variables needed from the input variables. 
Window_ID = SetUp_Info.Window_ID;
InterFrame_Interval= SetUp_Info.FrameInterval_in_Second;
nFramesEachTrial=condition.PresentationDuration/condition.PresentationPeriod;
WhiteColor = SetUp_Info.WhiteColor;
BlackColor = SetUp_Info.BlackColor;
Background_Color = SetUp_Info.GrayColor;
%
x_fixation= condition.x_fixation;
y_fixation=condition.y_fixation;
%
if Do_Or_Replay_ATrial==1
    Criterion.txt = 'Task button response';
    Criterion.ValidButtons = design.Response_Buttons.keyName;
else
    Criterion.txt = 'Nothing';
end
%%%
Text_Info.ShowText = 1;
TrialResponsePrompt = design.TrialResponsePrompt;
if  Do_Or_Replay_ATrial> 1  %--- add response info if it is a replay
    n_txt = length(TrialResponsePrompt);
    TrialResponsePrompt{n_txt+1} =  TrialResponsePrompt{1} ;
    TrialResponsePrompt{n_txt+1}.txt = Response_Info_txt;
    xy_in_Scale =  TrialResponsePrompt{1}.xy_in_Scale + [0, -0.02];
    xy_in_Pixel =   xy_in_Scale*SetUp_Info.Window_rectangle(3);
    TrialResponsePrompt{n_txt+1}.xy_in_Scale = xy_in_Scale;
    TrialResponsePrompt{n_txt+1}.xy_in_Pixel = xy_in_Pixel;
end
Text_Info.Text_Info_Details = TrialResponsePrompt;
n_txt = length(Text_Info.Text_Info_Details);
for n = 1:n_txt
    Text_Info.Text_Info_Details{n}.xy_in_Pixel = Text_Info.Text_Info_Details{n}.xy_in_Pixel + [x_fixation, y_fixation];
end


%--- (1) get the Stereograms from the StimlusInfo.
Stereograms = DrawStereograms_FromStimulusInfoEtc(StimulusInfo, BlackColor, WhiteColor, Background_Color);

%----(2) Get the StereoInputFrames and fixatioFrame_pointer 
[StereoInputFrames, fixationFrame_pointer] = ...
    Get_StereoInputFrames_Etc(design, SetUp_Info, condition, Stereograms, StimulusInfo.MaskInfo);

%----- (3)  Start the prompt and fixation frames
[All_Responses, FixationFrame_OnsetTimes, lastvbl]= ...
    Start_and_FixationFrames_In_ATrial(design, SetUp_Info, fixationFrame_pointer, ...
    x_fixation, y_fixation, Previous_FrameDuration_Desired,  Do_Or_Replay_ATrial, lastvbl, practice_or_test);

% ---- (4)  the stereograms
StimulusFrame_OnsetTimes= Show_Stereogram_Frames_In_ATrial(design, Window_ID, SetUp_Info.FrameInterval_in_Second, lastvbl, ...
    StereoInputFrames, nFramesEachTrial, Previous_FrameDuration_Desired(3:3+nFramesEachTrial-1));

%---  (5) show the promopt frame for subject response
%---- first, get the frame ready.
lastvbl = StimulusFrame_OnsetTimes(nFramesEachTrial);
%
%--- show the response frame, whether is either fixation frame or mask
if design.Add_Mask ~=1
    ResponseFrame_pointer = fixationFrame_pointer;
else
    frame  = nFramesEachTrial+1;
    for LeftOrRight = 1:2
        Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
        This_StereoInputFrame= StereoInputFrames{frame,LeftOrRight};
        ResponseFrame_pointer{LeftOrRight} = ...
            Screen('MakeTexture', Window_ID, This_StereoInputFrame);
    end
end
%---- now show this frame at its designated onset time and get the button responses.
[lastvbl, Task_Button_Response, EyeData] = ...
    Show_A_Frame_Till_Criterion(SetUp_Info, design, ResponseFrame_pointer, Text_Info, ...
    lastvbl, Previous_FrameDuration_Desired(end), Criterion,  practice_or_test);


% --- (6) record information.
FixationFrame_OnsetTimes = [FixationFrame_OnsetTimes, lastvbl];
Mask_OnsetTime=lastvbl; 
All_Responses.Task_Button_Response = Task_Button_Response;
All_Responses.EyeData=EyeData; 

