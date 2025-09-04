KbQueueCreate(deviceIndex);
KbQueueStart(deviceIndex);
if responsebox==1
    % Open Datapixx, and stop any schedules which might already be running
    Datapixx('Open');
    Datapixx('StopAllSchedules');
    Datapixx('RegWrRd');
    % Synchronize DATAPixx registers to local register cache
    % Configure digital input system for monitoring button box
    Datapixx('SetDinDataDirection', hex2dec('1F0000'));     % Drive 5 button lights
    Datapixx('EnableDinDebounce');                          % Debounce button presses
    Datapixx('SetDinLog');                                  % Log button presses to default address
    Datapixx('StartDinLog');                                % Turn on logging
    Datapixx('RegWrRd');
    if site~=5
        % Bit locations of button inputs, and colored LED drivers
        dinRed      = hex2dec('0000FFFE');
        dinGreen    = hex2dec('0000FFFB');
        dinBlue=hex2dec('0000FFF7');
        dinYellow=hex2dec('0000FFFD');
        dinWhite=hex2dec('0000FFEF');
        RespType=[dinGreen;
            dinRed;
            dinYellow;
            dinBlue]';
        %escapeKey=dinWhite;
        %   escapeKey=KbName('ESCAPE');
        
        TargList = [1 2 3 4]; % 1=red (right), 2=yellow (up), 3=green (left), 4