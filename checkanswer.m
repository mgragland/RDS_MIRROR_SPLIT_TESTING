function [Buttons, Time, EyeData]= checkanswer(design, practice_or_test)

if strcmp(design.Response_Buttons.Type, 'Keyboard')
    TakeKbCheck;
    Buttons= KbName(keyCode);
    Time= timeSecs; % time of button press 
    
    response_recorded=1; 
end


if strcmp(design.Response_Buttons.Type, 'ResponseBox')
    keycode=0;
    while keycode==0;
        Datapixx('Flush');
        Datapixx('RegWrRd');
        [keyValue, keyTime]= Datapixx('ReadDinLog');
        if length(keyValue)>1
            if keyValue(end)==65533 || keyValue(end)==65527
                if keyValue==65533
                    keyname= 'yellow' ;
                    keycode=1;
                    pause(0.1)
                elseif keyValue==65527
                    keyname= 'blue';
                    keycode=1;
                    pause(0.1)
                end
            end
        elseif  length(keyValue)==1
            if keyValue==65533 || keyValue==65527
                if keyValue==65533
                    keyname= 'yellow';
                    keycode=1;
                    pause(0.1)
                elseif keyValue==65527
                    keyname= 'blue';
                    keycode=1;
                    pause(0.1)
                end
            end
        end
    end
    Buttons= keyname;
    Time= keyTime; %datapixx internal clock
    response_recorded=1; 
end


%% Stop Logging Eye Data 
if practice_or_test==2 && design.GazeContingent_Or_Not==1 && response_recorded==1;
    Datapixx('StopTPxSchedule');
    Datapixx('RegWrRdVideoSync');
    %% Output eyetracking data
    status= Datapixx('GetTPxStatus')
    toRead= status.newBufferFrames;  
    [bufferData, ~, ~]= Datapixx('ReadTPxData', toRead);
     EyeData = array2table(bufferData, 'VariableNames', {'TimeTag', 'LeftEyeX', 'LeftEyeY', 'LeftPupilDiameter', 'RightEyeX', 'RightEyeY', 'RightPupilDiameter',...
        'DigitalIn', 'LeftBlink', 'RightBlink', 'DigitalOut', 'LeftEyeFixationFlag', 'RightEyeFixationFlag', 'LeftEyeSaccadeFlag', 'RightEyeSaccadeFlag',...
        'MessageCode', 'LeftEyeRawX', 'LeftEyeRawY', 'RightEyeRawX', 'RightEyeRawY'});
else
    EyeData=[];
end

checkescapekey
%% Clear Data 
clear keyTime keyValue response_recorded
%Datapixx('Flush')
