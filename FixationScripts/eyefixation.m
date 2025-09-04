%% Script to get the position of the eye on the screen 

eye_used=0;
% [xScreenRight yScreenRight xScreenLeft yScreenLeft xRawRight yRawRight xRawLeft yRawLeft timetag] = Datapixx('GetEyePosition');
[xScreenLeft, yScreenLeft, xScreenRight, yScreenRight, ~, ~, ~, ~, ~] = Datapixx('GetEyePosition');

if whicheye==1
    pos = Datapixx('ConvertCoordSysToCustom', [xScreenLeft, yScreenLeft]);
    %   [~, ~, Left_Major, Left_Minor]= Datapixx('GetPupilSize');
    [Left_Major, Left_Minor, ~, ~]= Datapixx('GetPupilSize');
    newpupil_maj=Left_Major;
    newpupil_min=Left_Minor;
elseif whicheye==2
    pos = Datapixx('ConvertCoordSysToCustom', [xScreenRight, yScreenRight]);
    %    [Right_Major, Right_Minor]= Datapixx('GetPupilSize');
    [~, ~, Right_Major, Right_Minor]= Datapixx('GetPupilSize');
    
    newpupil_maj=Right_Major;
    newpupil_min=Right_Minor;
end
newsamplex=pos(1);
newsampley=pos(2);

xeye=[xeye newsamplex];
yeye=[yeye newsampley];


pupilmaj=[pupilmaj newpupil_maj];
pupilmin=[pupilmin newpupil_min];


