function startPTB(SetUp_Info)
Debug_Or_Whole_Screen=SetUp_Info.Debug_Or_Whole_Screen; 
StereoMode= SetUp_Info.StereoMode;
ScreenNumber=SetUp_Info.ScreenNumber;
Background_ColorVector= SetUp_Info.Background_ColorVector; 
ScreenResolution=SetUp_Info.ScreenResolution; 
% Stereo_Color_Gain_Vectors=SetUp_Info.Stereo_Color_Gain_Vectors;

sca;
KbName('UnifyKeyNames');
Screen('Preference', 'SkipSyncTests', 1);

PsychImaging('PrepareConfiguration');
ptb_drawformattedtext_oversize = 2;
PsychImaging('AddTask', 'LeftView', 'DisplayColorCorrection', 'SimpleGamma');
PsychImaging('AddTask', 'RightView', 'DisplayColorCorrection', 'SimpleGamma');
%

if Debug_Or_Whole_Screen ==1 %debug, open a small window
    [Window_ID, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector, ...
        [0 0 round(ScreenResolution.width*0.5), round(ScreenResolution.height*0.8)], [], [], StereoMode);
else
    [Window_ID, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector, ...
        [], [], [], StereoMode);
end

if   Debug_Or_Whole_Screen ==2 %--- in real mode, hide the cursor from the screen with the visual input for experiments.
    HideCursor(ScreenNumber);   %ShowCursor(ScreenNumber)
end