
function [StereoInputFrames, StimulusInfo,  fixationFrame_pt] = ...
    Get_StereoInputFrames_StimulusInfo_Etc(design, SetUp_Info, condition, FrontOrBack)

FixationCross_Color = design.FixationCross_Color;
Background_Color = SetUp_Info.GrayColor;
FrameRate = 1/min(design.RDS_frame_durations_in_Second);  %-- this FrameRate does not matter, but needed for calling GetStimulusInfoFromConditionEtc.m so I make it up for this purrpose.
WhiteColor = SetUp_Info.WhiteColor;
BlackColor = SetUp_Info.BlackColor;

StimulusInfo = GetStimulusInfoFromConditionEtc(condition, FrontOrBack, FixationCross_Color, Background_Color, FrameRate);

Stereograms = DrawStereograms_FromStimulusInfoEtc(StimulusInfo, BlackColor, WhiteColor, Background_Color);

if design.Add_Mask ==1
    MaskInfo = Get_Mask(condition); %--- put in condition variable, to suit an old code.
else
    MaskInfo = [];
end
StimulusInfo.MaskInfo = MaskInfo;
[StereoInputFrames, fixationFrame_pt] = ...
    Get_StereoInputFrames_Etc(design, SetUp_Info, condition, Stereograms, MaskInfo);

