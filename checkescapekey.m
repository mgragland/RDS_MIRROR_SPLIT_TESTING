keyIsDown =0;
escapeKey = KbName('ESCAPE');

[keyIsDown,timeSecs,keyCode] = KbCheck;  %Check response
pause(0.001);
if keyIsDown
    R= KbName(keyCode);
    if strcmpi(R, 'ESCAPE')
        sca; 
    end
end
    