
function Replay_Or_Examine_Trials(design, SetUp_Info, Trial_Data, Replay_Or_Examine)

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
    
    if Replay_Or_Examine ==1	
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
    else
	WhiteColor = SetUp_Info.WhiteColor;
	BlackColor = SetUp_Info.BlackColor;
	Background_Color = SetUp_Info.GrayColor;
	Window_ID = SetUp_Info.Window_ID;

	%--- (1) get the Stereograms from the StimlusInfo.
	Stereograms = DrawStereograms_FromStimulusInfoEtc(StimulusInfo, BlackColor, WhiteColor, Background_Color);
	%----(2) Get the StereoInputFrames and fixatioFrame_pointer
	[StereoInputFrames, fixationFrame_pointer] = ...
    		Get_StereoInputFrames_Etc(design, SetUp_Info, condition, Stereograms, StimulusInfo.MaskInfo);
	nFramesEachTrial =  length(StimulusFrame_OnsetTimes);
	frame = 1;
	while frame > 0 & frame <=nFramesEachTrial+1
		disp(frame);
		 for LeftOrRight = 1:2
		        Screen('SelectStereoDrawBuffer', Window_ID, LeftOrRight-1);
        		This_MonocularFrame = StereoInputFrames{frame,LeftOrRight};
        		TestStimulusFrame_pt{LeftOrRight} =Screen('MakeTexture', Window_ID, This_MonocularFrame);
        		Screen('DrawTexture', Window_ID, TestStimulusFrame_pt{LeftOrRight});
        		Screen('Close', TestStimulusFrame_pt{LeftOrRight});
			if frame == nFramesEachTrial+1
				xy =  design.WrongButtonPrompt{1}.xy_in_Pixel + design.Reference_Display_location_xy_in_Pixel;
				DrawFormattedText(Window_ID, Response_Info_txt, xy(1), xy(2), design.Text_Color);
			end
    		end
		disp('here 4');
    		Screen('DrawingFinished', Window_ID,2);
    		Screen('Flip', Window_ID);
		GoForward_Or_Backward = Wait_For_RightOrLeftArrowKey();
		frame = frame + GoForward_Or_Backward;
	end
    end			
end


