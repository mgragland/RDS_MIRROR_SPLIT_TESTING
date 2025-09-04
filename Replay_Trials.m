
function Replay_Trials(design, SetUp_Info, Trial_Data)

design.GazeTracking_Or_Not=0;
design.GazeContingent_Or_Not=0;
NTrials = length(Trial_Data);
disp(NTrials);
first_trial = 1;
Initial_Time= Trial_Data(first_trial).FixationFrame_OnsetTimes(1);
for trial = 1:NTrials
    disp(trial);
    condition = Trial_Data(trial).condition;
    FixationFrame_OnsetTimes = Trial_Data(trial).FixationFrame_OnsetTimes;
    StimulusFrame_OnsetTimes = Trial_Data(trial).StimulusFrame_OnsetTimes;
    Response_Info_txt = [];
    N_responses = length(Trial_Data(trial).TrialResponses.Task_Button_Response);
    for i = 1: N_responses
        RT =  Trial_Data(trial).TrialResponses.Task_Button_Response(i).Time -  FixationFrame_OnsetTimes(end);
        txt = sprintf('Response %s at RT %f, ', Trial_Data(trial).TrialResponses.Task_Button_Response(i).Button_Characters, RT);
        Response_Info_txt =[ Response_Info_txt, txt];
    end
    Do_Or_Replay_ATrial=2;
    
    %%%%%%%%%%%%%%% (1) Get condition, StimulusInfo,
    StimulusInfo = Trial_Data(trial).StimulusInfo;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (2) get lastvbl and Previous_FrameDuration_Desired
    All_Frames_OnsetTimes = [FixationFrame_OnsetTimes, StimulusFrame_OnsetTimes];
    All_Frames_OnsetTimes = sort(All_Frames_OnsetTimes,'ascend');
    Previous_FrameDuration_Desired = [0, All_Frames_OnsetTimes(2:end)-All_Frames_OnsetTimes(1:end-1)];
    if trial > 1 %--- first frame must wait until the last frame of last trial was displayed for its duration.
        Previous_FrameDuration_Desired(1) = Trial_Data(trial).FixationFrame_OnsetTimes(1) ...
            - Trial_Data(trial-1).FixationFrame_OnsetTimes(end);
    else
        Previous_FrameDuration_Desired(1) = 0;
        lastvbl  = 0; %--- this number does not matter.
    end
    %%%%%%%%%%%%%%%%%%%%%% (3) Replay the trial
    [FixationFrame_OnsetTimes, StimulusFrame_OnsetTimes, All_Responses] =  ...
        Do_Or_Replay_GivenInfo(Do_Or_Replay_ATrial, design, SetUp_Info, condition, StimulusInfo,  ...
        lastvbl, Previous_FrameDuration_Desired, Response_Info_txt);
    
    %%%%%%%%%%%%%%%% (4) record last time the frame onset.time to time the onset of  the first frame next trial
    lastvbl = FixationFrame_OnsetTimes(end);
    if trial ==NTrials
	pause(RT);
    end		
end


