FlushEvents;
To_Continue =0;
checkescapekey

if strcmp(design.Response_Buttons.Type, 'Keyboard')
    while To_Continue ==0
        FlushEvents;
        TakeKbCheck;
        R= KbName(keyCode);
        if strcmp(R, 'RightArrow') ==1
            To_Continue =1;
        end
        disp(R);
        FlushEvents;
        pause(0.2);
        FlushEvents;
    end
end


if strcmp(design.Response_Buttons.Type, 'ResponseBox')
    while To_Continue ==0
        Datapixx('Flush');
        Datapixx('RegWrRd');
        [keyValue, keyTime]= Datapixx('ReadDinLog');
        if length(keyValue) >1
            if keyValue(end)== 65534
                To_Continue =1;
            end
        elseif length(keyValue) ==1
            if keyValue== 65534
                To_Continue =1;
            end
        end
        Datapixx('Flush');
    end
end

                

