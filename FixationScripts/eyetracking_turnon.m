% Calibration and Validation with DataPixx
isTPX=1
screenNumber = max(Screen('Screens'));
TPxCalibrationTestingMGR(isTPX,screenNumber)
%Connect to TRACKPixx3
Datapixx('Open');
Datapixx('SetTPxAwake');
Datapixx('SetupTPxSchedule'); 
Datapixx('RegWrRd');
