 function      SetUp_Info = initializePtbStereo(Debug_Or_Whole_Screen, Viewing_Distance_in_mm)

%global ptb_drawformattedtext_oversize

sca;
KbName('UnifyKeyNames');
Screen('Preference', 'SkipSyncTests', 1);

PsychImaging('PrepareConfiguration');
ptb_drawformattedtext_oversize = 2;
% PsychImaging('AddTask', 'LeftView', 'DisplayColorCorrection', 'SimpleGamma');
% PsychImaging('AddTask', 'RightView', 'DisplayColorCorrection', 'SimpleGamma');
% 
ScreenNumber = max(Screen('Screens'));

ScreenResolution = Screen('Resolution', ScreenNumber);
[ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
StereoMode = 4;


%...... COLORS
WhiteColor =  WhiteIndex(ScreenNumber);
BlackColor =  BlackIndex(ScreenNumber);
GrayColor =   round(WhiteColor+BlackColor)/2;
Background_ColorVector = GrayColor*[1, 1, 1];


if Debug_Or_Whole_Screen ==1 %debug, open a small window
    [Window_ID, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector, ...
        [0 0 round(ScreenResolution.width*0.5), round(ScreenResolution.height*0.8)], [], [], StereoMode);
else
    [Window_ID, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector, ...
        [], [], [], StereoMode);
end


FrameInterval_in_Second   = Screen('GetFlipInterval', Window_ID);
FrameRate = Screen('FrameRate', Window_ID);
% Screen('TextSize', Window_ID, design.Text_FontSize);

SetUp_Info.FrameInterval_in_Second = FrameInterval_in_Second;
SetUp_Info.Window_ID = Window_ID;
SetUp_Info.Window_rectangle = Window_rectangle;
SetUp_Info.ScreenNumber = ScreenNumber;
SetUp_Info.ScreenResolution = ScreenResolution;
SetUp_Info.Debug_Or_Whole_Screen =Debug_Or_Whole_Screen;
SetUp_Info.ScreenWidth_in_mm =ScreenWidth_in_mm;
SetUp_Info.ScreenHeight_in_mm =ScreenHeight_in_mm;
SetUp_Info.Viewing_Distance_in_mm = Viewing_Distance_in_mm;
SetUp_Info.StereoMode = StereoMode;
SetUp_Info.WhiteColor = WhiteColor;
SetUp_Info.BlackColor = BlackColor;
SetUp_Info.GrayColor = GrayColor;
SetUp_Info.Background_ColorVector = Background_ColorVector;
SetUp_Info.FrameRate  = FrameRate;
