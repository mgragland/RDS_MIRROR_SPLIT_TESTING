% constrained fixation loop

% fixation is NOT achieved 

% ITI= time between beginning of trial and first event in the trial;
% fixating= seconds when participants are fixating 
% stopchecking= counter to stop checking for fixation? might want to
% initalize this at a different point in the code 
% trialTimeout= number of seconds before trial is void (participant did NOT
% achieve fixation 
if  (eyetime2-pretrial_time)>=ITI && fixating<fixationduration/ifi && stopchecking>1 && (eyetime2-pretrial_time)<=trialTimeout
    presentcue=0;
    %   IsFixatingSquare
    [fixating counter framecounter ]=IsFixatingSquareNew(wRect,xeye,yeye,fixating,framecounter,counter,fixwindowPix);
    if exist('starfix')==0

        if datapixxtime==1
            startfix(trial)=Datapixx('GetTime');
            startfix2(trial)= eyetime2;
        else
            startfix(trial)=eyetime2;
        end
    end
    
% fixation conditions HAVE been satisfied 
elseif (eyetime2-pretrial_time)>ITI && fixating>=fixationduration/ifi && stopchecking>1 && fixating<1000 && (eyetime2-pretrial_time)<=trialTimeout
    % forced fixation time satisfied
    if datapixxtime==1
        Datapixx('RegWrRd');
        trial_time = Datapixx('GetTime');
        trial_time2 = eyetime2;
    else
        trial_time = eyetime2;
    end
    if EyetrackerType ==2
        Datapixx('SetMarker');
        Datapixx('RegWrVideoSync');
        %collect marker data
        Datapixx('RegWrRd');
        Pixxstruct(trial).TrialOnset = Datapixx('GetMarker');
    end
    %      clear imageRect_offsCirc
    clear imageRect_offs imageRect_offs_flank1 imageRect_offs_flank2 imageRect_offscircle imageRect_offscircle1 imageRect_offscircle2
    clear stimstar subimageRect_offs_cue
    fixating=1500;
end