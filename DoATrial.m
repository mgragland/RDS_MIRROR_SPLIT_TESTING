function [FixationFrame_OnsetTimes,  StimulusFrame_OnsetTimes,  All_Responses, StimulusInfo, Mask_OnsetTime] = ...
    DoATrial(design, SetUp_Info, condition, FrontOrBack,  practice_or_test)


Do_Or_Replay_ATrial=1;
Response_Info_txt='';
RDS_frame_duration = condition.PresentationPeriod;
FixationCross_Color = design.FixationCross_Color;
Background_Color = SetUp_Info.GrayColor;
FrameRate = 1/min(design.RDS_frame_durations_in_Second);  %-- this FrameRate does not matter, but needed for calling GetStimulusInfoFromConditionEtc.m so I make it up for this purrpose.
lastvbl = 0;  %--- this number does not matter for Do_Or_Replay_ATrial=1
nFramesEachTrial=condition.PresentationDuration/condition.PresentationPeriod;


%%%%%%%%%%%%%%%%%%%%%%%%%%%-- (1) Get Stimulus Info
StimulusInfo = GetStimulusInfoFromConditionEtc(condition, FrontOrBack, FixationCross_Color, Background_Color, FrameRate);
if design.Add_Mask ==1
    MaskInfo = Get_Mask(condition); %--- put in condition variable, to suit an old code.
else
    MaskInfo = [];
end
StimulusInfo.MaskInfo = MaskInfo;

%%%%%%%%%%%%%%%%--- (2) get Previous_FrameDuration_Desired , the time to wait for each frame onset, to ensure that the previous frame was displayed for due course.
Previous_FrameDuration_Desired = [0, 0]; %%%%%%%%%%%%%%%% This is for the first 2 fixation duration frames before stimulus onset
temlist = RDS_frame_duration*ones(1, nFramesEachTrial); %%%% this is for the stereogram frames
if design.GazeContingent_Or_Not ==0
    temlist(1) = design.FixationPeriod_in_Second; %--- first frame in the stereogram, wait for onset after the fixation duration if there is no gaze contingency
else
    temlist(1) = 0; %--- first frame in the stereogram, no need to wait for onset after the gaze contingency
end
Previous_FrameDuration_Desired = [Previous_FrameDuration_Desired, temlist];
%--- for the response frame
Previous_FrameDuration_Desired = [Previous_FrameDuration_Desired, RDS_frame_duration];

%%%%%%%%%%%%%%%%%%%%%%% (3) Do the trial
[FixationFrame_OnsetTimes, StimulusFrame_OnsetTimes, All_Responses, Mask_OnsetTime] =  ...
    Do_Or_Replay_GivenInfo(Do_Or_Replay_ATrial, design, SetUp_Info, condition, StimulusInfo, ...
    lastvbl,  Previous_FrameDuration_Desired, Response_Info_txt,  practice_or_test);



