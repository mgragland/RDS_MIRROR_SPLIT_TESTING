function GoForward_Or_Backward = Wait_For_RightOrLeftArrowKey(design)
	FlushEvents;	
	GoForward_Or_Backward=0;
    
    if strcmp(design.Response_Buttons.Type, 'Keyboard')
        while GoForward_Or_Backward ==0
            FlushEvents;
            TakeKbCheck;
            R= KbName(keyCode);
            if strcmp(R, 'RightArrow') ==1
                GoForward_Or_Backward=1;
            elseif strcmp(R, 'LeftArrow') ==1
                GoForward_Or_Backward=-1;
            end
            disp(R);
            FlushEvents;
            pause(0.2);
            FlushEvents;
        end
    end
    
    
    if strcmp(design.Response_Buttons.Type, 'ResponseBox')
        while GoForward_Or_Backward ==0
            Datapixx('Flush');
            Datapixx('RegWrRd');
            [keyValue, keyTime]= Datapixx('ReadDinLog');
            if length(keyValue)>1
                if keyValue(end)==  65534
                    To_Continue =1;
                    GoForward_Or_Backward=1;
                elseif keyValue(end)== 65531
                    GoForward_Or_Backward=-1;
                end
            elseif length(keyValue)==1
                if keyValue==  65534
                    To_Continue =1;
                    GoForward_Or_Backward=1;
                elseif keyValue== 65531
                    GoForward_Or_Backward=-1;
                    disp(keyValue);
                end
            end
            Datapixx('Flush');
        end
    end

