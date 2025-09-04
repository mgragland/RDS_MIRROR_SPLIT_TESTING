function    EyeTracker_Info = SetUp_EyeTracker();
Screen('Preference', 'SkipSyncTests', 1);
ScreenNumber = max(Screen('Screens'));
addpath('C:\Users\vpixx\Desktop\clean_codes_MGR\FixationScripts')
 eyetracking_turnon
EyeTracker_Info=[];