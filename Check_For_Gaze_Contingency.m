
function  EyeTracker_Gaze_Contingent_Data = Check_For_Gaze_Contingency(SetUp_Info,  Criterion, design, EyeTracker_Gaze_Contingent_Data,  practice_or_test)


if practice_or_test==2 && design.GazeContingent_Or_Not==1;
    Datapixx('StartTPxSchedule');
    Datapixx('GetTPxStatus')
    Datapixx('RegWrRd');
    Datapixx('StartDinLog');                                % Turn on logging
    Datapixx('SetMarker');
end



%% Start Logging Eye Data 
Fixation=SetUp_Info.EyeTracker_Info;
whicheye=1; %% need to code based on the participant assignment table
Eyetracker=1;
fixation_complete=0;
framecount=0;
fixating=0;
% x_fixation= condition.x_fixation;
% y_fixation=condition.y_fixation;

if framecount==0;
    resetgazevars
end

while fixation_complete==0
    framecount=framecount+1;
    eyefixation; 
    [fixating, framecount, fixation_complete, xeye, yeye, eyedist]= IsFixatingSquareNew_MGR(SetUp_Info,xeye,yeye,fixating,framecount,design, eyedist);
end
EyeTracker_Gaze_Contingent_Data.xeye{end+1}=xeye;
EyeTracker_Gaze_Contingent_Data.yeye{end+1}=yeye;
EyeTracker_Gaze_Contingent_Data.fixating{end+1}=fixating;
EyeTracker_Gaze_Contingent_Data.reye{end+1}=eyedist;