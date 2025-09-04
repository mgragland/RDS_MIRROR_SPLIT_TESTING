responsebox= []; 
%Open Datapixx, and stop any schedules which might already be running
% Datapixx('Open');
% Datapixx('StopAllSchedules');
% %Datapixx('RegWrRd'); NO IDEA WHAT THIS COMMAND DOES 
% %Synchronize DATAPixx registers to local register cache
% %Configure digital input system for monitoring button box
% Datapixx('SetDinDataDirection', hex2dec('1F0000'));     % Drive 5 button lights
% Datapixx('EnableDinDebounce');                          % Debounce button presses
% Datapixx('SetDinLog');                                  % Log button presses to default address
% Datapixx('StartDinLog');                                % Turn on logging
% Datapixx('RegWrRd'); 

%% 
Datapixx('Open');
% Datapixx('StopAllSchedules');
Datapixx('SetTPxAwake');
Datapixx('RegWrRd'); 
Datapixx('SetTPxSchedule');
Datapixx('SetDinDataDirection', hex2dec('1F0000'));     % Drive 5 button lights
Datapixx('EnableDinDebounce');                          % Debounce button presses
Datapixx('SetDinLog');                                  % Log button presses to default address
Datapixx('StartDinLog');                                % Turn on logging
Datapixx('RegWrRd'); 

%Bit locations of button inputs, and colored LED drivers
dinRed      = hex2dec('0000FFFE');
dinGreen    = hex2dec('0000FFFB');
dinBlue=hex2dec('0000FFF7');
dinYellow=hex2dec('0000FFFD');
dinWhite=hex2dec('0000FFEF'); 
RespType=[dinGreen;dinRed;dinYellow;dinBlue]';
TargList = [1 2 3 4]; % 1=red (right), 2=yellow (up), 3=green (left), 4=blue (down)
responsebox.colors=[dinRed, dinGreen, dinBlue, dinYellow, dinWhite];
responsebox.RespType=RespType;
responsebox.targlist=TargList;

%% Debugging- is response box working   
keycode=0;
while keycode==0; 
    Datapixx('RegWrRd'); 
    [keyTime, keyValue]= Datapixx('ReadDinLog');
    if keyValue~=0 
        keycode=1;
    end
    pause(0.1)
end
disp(keyValue)

clear dinRed dinGreen dinBlue dinYellow dinWhite RespType TargList