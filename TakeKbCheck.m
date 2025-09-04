keyIsDown =0;
            while keyIsDown==0   %While waiting for button response.
                [keyIsDown,timeSecs,keyCode] = KbCheck;  %Check response
                pause(0.001);
            end
           
